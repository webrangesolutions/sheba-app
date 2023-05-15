import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:sheba_financial/models/user_model.dart';
import 'package:sheba_financial/utils/color_constants.dart';

import '../helpers/ui_helper.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _comapnyIdController = TextEditingController();
  UserModel userModel = UserModel.loggedinUser!;
  ImagePicker picker = ImagePicker();
  XFile? image;
  File? imageFile;

  @override
  void initState() {
    _nameController.text = userModel.fullName ?? "";
    _phoneController.text = userModel.phoneNo ?? "";
    _emailController.text = userModel.email ?? "";
    _comapnyIdController.text = userModel.companyId ?? "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mediaHeight = MediaQuery.of(context).size.height;
    final mediaWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Edit Profile",
            style: TextStyle(color: AppColors.secondaryColor),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            color: AppColors.secondaryColor,
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: mediaHeight * 0.05),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(
                      alignment: Alignment.bottomRight,
                      children: <Widget>[
                        imageFile == null
                            ? Container(
                                height: 140,
                                width: 140,
                                // ignore: prefer_const_constructors
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    image: NetworkImage(userModel.profilePic!),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              )
                            : Container(
                                height: 140,
                                width: 140,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    image: FileImage(File(imageFile!.path)),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                        InkResponse(
                          onTap: () async {
                            showPhotoOption(context);
                          },
                          child: Container(
                            height: 50.0,
                            width: 30.0,
                            decoration: BoxDecoration(
                              color: Colors.grey[400],
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.add,
                              size: 25,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: mediaHeight * 0.05),
                const Text(
                  'Full Name',
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
                TextField(
                  controller: _nameController,
                  style: const TextStyle(
                    color:
                        AppColors.secondaryColor, // Set the text color to red
                  ),
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                const Text(
                  'Email Address',
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
                TextField(
                  readOnly: true,
                  controller: _emailController,
                  style: const TextStyle(
                    color: Colors.grey, // Set the text color to red
                  ),
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                const Text(
                  'Company ID',
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
                TextField(
                  controller: _comapnyIdController,
                  style: const TextStyle(
                    color:
                        AppColors.secondaryColor, // Set the text color to red
                  ),
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                const Text(
                  'Phone Number',
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
                TextField(
                  controller: _phoneController,
                  style: const TextStyle(
                    color:
                        AppColors.secondaryColor, // Set the text color to red
                  ),
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                  ),
                ),
                // Row(
                //   children: [
                //     Expanded(
                //       child: Container(
                //         decoration: const BoxDecoration(
                //           border: Border(
                //             bottom: BorderSide(
                //               color: Colors.black,
                //               width: 1.0,
                //             ),
                //           ),
                //         ),
                //         child: InternationalPhoneNumberInput(
                //           textFieldController: _phoneController,
                //           textStyle: const TextStyle(
                //               color: AppColors.secondaryColor),
                //           initialValue: _phoneNumber,
                //           onInputChanged: (PhoneNumber number) {
                //             print(number.phoneNumber);
                //           },
                //           onInputValidated: (bool value) {
                //             print(value);
                //           },
                //           selectorConfig: const SelectorConfig(
                //             selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                //           ),
                //           ignoreBlank: false,
                //           autoValidateMode: AutovalidateMode.disabled,
                //           selectorTextStyle:
                //               const TextStyle(color: Colors.black),
                //           formatInput: true,
                //           keyboardType: const TextInputType.numberWithOptions(
                //               signed: true, decimal: true),
                //           onSaved: (PhoneNumber number) {},
                //         ),
                //       ),
                //     ),
                //   ],
                // ),
                const SizedBox(height: 16.0),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  alignment: Alignment.center,
                  child: SizedBox(
                    height: 50,
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: ElevatedButton(
                      onPressed: () {
                        checkValues();
                      },
                      style: ButtonStyle(
                        elevation: MaterialStateProperty.all(0),
                        backgroundColor: MaterialStateProperty.all(
                            const Color.fromARGB(255, 32, 131, 37)),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                      child: const Text(
                        'Save',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void checkValues() {
    String email = _emailController.text.trim();
    String name = _nameController.text.trim();
    String companyId = _comapnyIdController.text.trim();
    String phoneNo = _phoneController.text.trim();

    if (email.isEmpty || name.isEmpty || companyId.isEmpty || phoneNo.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: AppColors.secondaryColor,
          duration: Duration(seconds: 1),
          content: Text("Please fill all the fields!"),
        ),
      );
    } else {
      signUp(
        email: email,
        companyId: companyId,
        name: name,
        phoneNo: phoneNo,
      );
    }
  }

  void signUp({
    required String email,
    required String companyId,
    required String name,
    required String phoneNo,
  }) async {
    UIHelper.showLoadingDialog(context, 'Updating User...');
    String imageUrl = '';

    if (imageFile != null) {
      UploadTask uploadTask = FirebaseStorage.instance
          .ref("profilepictures")
          .child(userModel.uid.toString())
          .putFile((File(imageFile!.path)));
      TaskSnapshot snapshot = await uploadTask;
      imageUrl = await snapshot.ref.getDownloadURL();
    }

    String uid = userModel.uid!;
    UserModel newUser = UserModel(
      uid: uid,
      role: userModel.role,
      email: email,
      fullName: name,
      isVerified: userModel.isVerified,
      profilePic: (imageUrl == '') ? userModel.profilePic : imageUrl,
      phoneNo: phoneNo,
      companyId: companyId,
    );
    UserModel.loggedinUser = newUser;
    await FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .set(newUser.toMap())
        .then(
      (value) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: AppColors.secondaryColor,
            duration: Duration(seconds: 1),
            content: Text("User updated!"),
          ),
        );
        Navigator.pop(context);
      },
    );
  }

  void selectImage(ImageSource source) async {
    XFile? selectedImage = await ImagePicker().pickImage(source: source);
    if (selectedImage != null) {
      _cropImage(selectedImage);
    }
  }

  Future<void> _cropImage(selectedImage) async {
    if (selectedImage != null) {
      final croppedFile = await ImageCropper().cropImage(
        sourcePath: selectedImage!.path,
        compressFormat: ImageCompressFormat.jpg,
        compressQuality: 15,
        uiSettings: [
          AndroidUiSettings(
              toolbarTitle: 'Cropper',
              toolbarColor: Colors.deepOrange,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: false),
          IOSUiSettings(
            title: 'Cropper',
          ),
        ],
      );
      if (croppedFile != null) {
        setState(() {
          imageFile = File(croppedFile.path);
        });
      }
    }
  }

  void showPhotoOption(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          shape: const RoundedRectangleBorder(),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Choose',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        Navigator.pop(context);
                        selectImage(ImageSource.camera);
                      },
                      child: Column(
                        children: [
                          Image.asset('assets/images/camera.png'),
                          const SizedBox(height: 10),
                          const Text(
                            'Camera',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                      onTap: () async {
                        Navigator.pop(context);
                        selectImage(ImageSource.gallery);
                        // handle gallery option
                      },
                      child: Column(
                        children: [
                          Image.asset('assets/images/gallery.png'),
                          const SizedBox(height: 10),
                          const Text(
                            'Gallery',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text(
                    'Cancel',
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColors.secondaryColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
