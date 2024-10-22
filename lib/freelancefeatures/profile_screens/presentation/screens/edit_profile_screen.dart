import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quick_hire/core/utils/app_icon.dart';
import 'package:quick_hire/core/utils/constants.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';
import 'package:quick_hire/core/widgets/custom_text_field.dart';
import 'package:http/http.dart' as http;
import 'package:quick_hire/freelancefeatures/authintication_screens/data/datasources/local/auth_local_data_source.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:quick_hire/freelancefeatures/profile_screens/data/repositories/user_repository_impl.dart';

import '../../../../core/widgets/skill_buttons.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController bioController = TextEditingController();
  final TextEditingController skillController = TextEditingController();
  final TextEditingController rateNameController = TextEditingController();
  final TextEditingController ratePriceController = TextEditingController();
  late UserRepositoryImpl _userRepository;

  File? _image;
  List<String> skills = [];
  List<Map<String, String>> rates = [];
  String? userId;

  @override
  void initState() {
    super.initState();
    _initializeRepository();
  }

  Future<void> _initializeRepository() async {
    final secureStorage = FlutterSecureStorage();
    final authLocalDataSource = AuthLocalDataSource(secureStorage);
    userId = await secureStorage.read(key: 'user_id');
    setState(() {
      _userRepository = UserRepositoryImpl(http.Client(), authLocalDataSource);
    });
  }

  Future<void> _pickImage() async {
    try {
      var status = await Permission.photos.status;
      if (!status.isGranted) {
        await Permission.photos.request();
      }

      if (await Permission.photos.isGranted) {
        final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
        if (pickedFile != null) {
          setState(() {
            _image = File(pickedFile.path);
          });
        }
      } else {
        print("Permission not granted to access photos.");
      }
    } catch (e) {
      print("Error picking image: $e");
    }
  }

  void _addSkill() {
    if (skillController.text.isNotEmpty) {
      setState(() {
        skills.add(skillController.text);
      });
      skillController.clear();
    }
  }

  void _removeSkill(String skill) {
    setState(() {
      skills.remove(skill);
    });
  }

  void _addRate() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: rateNameController,
                  decoration: const InputDecoration(labelText: 'Rate Name'),
                ),
                SizedBox(height: MediaQuery.of(context).size.width * 0.03),
                TextField(
                  controller: ratePriceController,
                  decoration: const InputDecoration(labelText: 'Rate Price'),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        setState(() {
                          rates.add({
                            'name': rateNameController.text,
                            'price': ratePriceController.text,
                          });
                        });
                        rateNameController.clear();
                        ratePriceController.clear();
                        Navigator.of(context).pop();
                      },
                      child: const Text('Add'),
                    ),
                    TextButton(
                      onPressed: () {
                        rateNameController.clear();
                        ratePriceController.clear();
                        Navigator.of(context).pop();
                      },
                      child: const Text('Cancel'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _removeRate(String id) {
    setState(() {
      rates.removeWhere((rate) => rate['id'] == id);
    });
  }

  Map<String, dynamic> filterEmptyFields(Map<String, dynamic> data) {
    return data..removeWhere((key, value) => value == null || value.toString().isEmpty);
  }

  void _saveProfile() async {
    if (_formKey.currentState!.validate()) {
      final updates = {
        'username': usernameController.text,
        'bio': bioController.text,
        'skills': skills,
        'rates': rates, // Ensure rates is sent as an array of objects
      };

      final filteredUpdates = filterEmptyFields(updates);

      try {
        print('Attempting to patch user profile with updates: $filteredUpdates');
        await _userRepository.patchUserProfile(filteredUpdates);
        print('Profile updated successfully');
        Navigator.pop(context);
      } catch (e) {
        print('Error updating profile: $e');
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to update profile')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        leading: IconButton(
          icon: SvgPicture.asset(
            AppIcons.backIcon,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: SvgPicture.asset('assets/images/quickhire logo.svg'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _saveProfile,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.width * 0.3,
                          width: MediaQuery.of(context).size.width * 0.3,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: _image != null
                                  ? FileImage(_image!)
                                  : const AssetImage('assets/images/cyclops-profile.png') as ImageProvider,
                              fit: BoxFit.cover,
                            ),
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: AppColors.secondaryColor,
                              width: 2.0,
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: GestureDetector(
                            onTap: _pickImage,
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                                border: Border.all(
                                  color: AppColors.primaryColor,
                                  width: 2.0,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: SvgPicture.asset(
                                  AppIcons.penEditIcon,
                                  width: MediaQuery.of(context).size.width * 0.07,
                                  height: MediaQuery.of(context).size.width * 0.07,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                CustomTextField(
                  controller: usernameController,
                  labelText: 'Username',
                  hintText: 'username',
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a username';
                    }
                    return null;
                  },
                  obscureText: false,
                ),
                SizedBox(height: MediaQuery.of(context).size.width * 0.02),
                CustomTextField(
                  controller: bioController,
                  hintText: 'ur old bio',
                  labelText: 'Bio',
                  maxLines: 4,
                  maxLength: 120,
                  obscureText: false,
                ),
                SizedBox(height: MediaQuery.of(context).size.width * 0.02),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Add or remove Skills & Expertise:',
                          style: TextStyle(
                            color: AppColors.primaryColor,
                            fontSize: 16,
                          ),
                        ),
                        IconButton(
                          onPressed: _addSkill,
                          icon: SvgPicture.asset(
                            AppIcons.addIcon,
                            width: MediaQuery.of(context).size.width * 0.06,
                            height: MediaQuery.of(context).size.width * 0.06,
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: skillController,
                            decoration: const InputDecoration(
                              labelText: 'Enter skill',
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: _addSkill,
                          icon: Icon(Icons.add, color: AppColors.primaryColor),
                        ),
                      ],
                    ),
                    SizedBox(height: MediaQuery.of(context).size.width * 0.03),
                    Wrap(
                      spacing: 8.0,
                      runSpacing: 10.0,
                      children: skills.map((skill) {
                        return SkillButtons(
                          skillName: skill,
                          iconPath: AppIcons.minusIcon,
                          onPressed: () => _removeSkill(skill),
                        );
                      }).toList(),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.width * 0.03),
                    Row(
                      children: [
                        Text(
                          'Add or Remove Rates & Pricing:',
                          style: TextStyle(
                            color: AppColors.primaryColor,
                            fontSize: 16,
                          ),
                        ),
                        IconButton(
                          onPressed: _addRate,
                          icon: SvgPicture.asset(
                            AppIcons.addIcon,
                            width: MediaQuery.of(context).size.width * 0.06,
                            height: MediaQuery.of(context).size.width * 0.06,
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: MediaQuery.of(context).size.width * 0.03),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: rates.map((rate) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '${rate['name']}: ${rate['price']}',
                                style: TextStyle(
                                  color: AppColors.secondaryColor,
                                  fontSize: 16,
                                ),
                              ),
                              IconButton(
                                onPressed: () => _removeRate(rate['id']!),
                                icon: SvgPicture.asset(
                                  AppIcons.minusIcon,
                                  width: MediaQuery.of(context).size.width * 0.06,
                                  height: MediaQuery.of(context).size.width * 0.06,
                                ),
                                color: AppColors.primaryColor,
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}