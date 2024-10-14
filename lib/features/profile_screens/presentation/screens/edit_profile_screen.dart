import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quick_hire/core/utils/app_icon.dart';
import 'package:quick_hire/core/utils/constants.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  File? _image;

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
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
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
                              : AssetImage('assets/images/cyclops-profile.png') as ImageProvider,
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
          ],
        ),
      ),
    );
  }
}