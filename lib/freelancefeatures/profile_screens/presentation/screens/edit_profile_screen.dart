import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quick_hire/core/utils/app_icon.dart';
import 'package:quick_hire/core/utils/constants.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';
import 'package:quick_hire/core/widgets/custom_text_field.dart';
import 'package:quick_hire/core/widgets/skill_buttons.dart';
import 'package:http/http.dart' as http;
import 'package:quick_hire/freelancefeatures/authintication_screens/data/datasources/local/auth_local_data_source.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:quick_hire/freelancefeatures/profile_screens/data/repositories/user_repository_impl.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>(); // Define the _formKey
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController bioController = TextEditingController();
  final TextEditingController rateNameController = TextEditingController();
  final TextEditingController ratePriceController = TextEditingController();
  late UserRepositoryImpl _userRepository;

  File? _image;
  List<Map<String, String>> rates = [];

  @override
  void initState() {
    super.initState();
    _initializeRepository();
  }

  Future<void> _initializeRepository() async {
    final secureStorage = FlutterSecureStorage();
    final authLocalDataSource = AuthLocalDataSource(secureStorage);
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

  void _saveProfile() async {
    if (_formKey.currentState!.validate()) {
      final updates = {
        'username': usernameController.text,
        'bio': bioController.text,
      };

      try {
        await _userRepository.patchUserProfile(updates);
        Navigator.pop(context); // Go back to the previous screen
      } catch (e) {
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
            key: _formKey, // Attach the _formKey to the Form widget
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
                          onPressed: () {},
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
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Wrap(
                        spacing: 8.0,
                        runSpacing: 10.0,
                        children: [
                          SkillButtons(skillName: 'Logo Design', iconPath: AppIcons.minusIcon),
                          SkillButtons(skillName: 'Graphic Design', iconPath: AppIcons.minusIcon),
                          SkillButtons(skillName: 'Illustration', iconPath: AppIcons.minusIcon),
                          SkillButtons(skillName: 'Photoshop', iconPath: AppIcons.minusIcon),
                        ],
                      ),
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
                                icon: SvgPicture.asset(AppIcons.minusIcon,width: MediaQuery.of(context).size.width * 0.06, height: MediaQuery.of(context).size.width * 0.06,), color: AppColors.primaryColor,
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