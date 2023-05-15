import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:sheba_financial/models/recipt_model.dart';
import 'package:sheba_financial/models/user_model.dart';
import 'package:sheba_financial/screens/dashboard.dart';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';
import '../helpers/ui_helper.dart';
import '../utils/color_constants.dart';
import '../widgets/bottom_bar.dart';

class ScanScreen extends StatefulWidget {
  const ScanScreen({super.key});

  @override
  ScanScreenState createState() => ScanScreenState();
}

class ScanScreenState extends State<ScanScreen> {
  int _selectedIndex = 1;
  TextEditingController merchantController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController totalController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  File? imageFile;
  Uuid uuid = const Uuid();
  List<String> categoryItems = [
    'Food',
    'Transport',
    'Entertainment',
    'Meal & Entertainment',
    'Others'
  ];
  List<String> currencyItems = ['PKR', 'NGN', 'USD', 'XAF', 'EUR', 'GBP'];
  List<String> paymentItems = [
    'Card',
    'Cash',
    'Bank Transfer',
    'Mobile Money',
    'Others'
  ];
  String currency = 'USD';
  String category = 'Food';
  String payment = 'Card';
  String merchant = '';
  String date = '';
  String total = '';
  String description = '';
  final textRecognizer = GoogleMlKit.vision.textRecognizer();

  String reciptId = '';
  String token = '';
  @override
  initState() {
    String dateNow = (DateFormat.yMMMMd().format(DateTime.now())).toString();
    dateController.text = dateNow;
    getToken();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mediaHeight = MediaQuery.of(context).size.height;
    final mediaWidth = MediaQuery.of(context).size.width;
    String dateNow = (DateFormat.yMMMMd().format(DateTime.now())).toString();
    dateController.text = dateNow;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.arrow_back,
                        color: AppColors.secondaryColor,
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                    SizedBox(width: mediaWidth * 0.2),
                    const Text(
                      'Add New Receipt',
                      style: TextStyle(
                          fontSize: 20, color: AppColors.secondaryColor),
                    ),
                  ],
                ),
              ),
              InkResponse(
                onTap: () {
                  showPhotoOption(context);
                },
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.3,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.8),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                  ),
                  child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            bottom: 0, left: 50, right: 50, top: 60),
                        child: (imageFile != null)
                            ? Image.file(
                                imageFile!,
                                fit: BoxFit.cover,
                                width: double.infinity,
                              )
                            : Image.asset('assets/images/receipts.png'),
                      ),
                      Center(
                        child: Container(
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            color: Colors.black,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: (imageFile == null)
                                ? const Text(
                                    "Add Image",
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                    ),
                                  )
                                : const Text(
                                    "Change Image",
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                    ),
                                  ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Text(
                  'Merchant',
                  style: TextStyle(fontSize: 14),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: TextField(
                  readOnly: false,
                  controller: merchantController,
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
              ),
              const Divider(
                color: Colors.grey,
                thickness: 0.0,
                indent: 16.0,
                endIndent: 16.0,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                child: Text(
                  'Date',
                  style: TextStyle(fontSize: 14),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: TextField(
                  readOnly: true,
                  controller: dateController,
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
              ),
              const Divider(
                color: Colors.grey,
                thickness: 0.0,
                indent: 16.0,
                endIndent: 16.0,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: const [
                    Text(
                      'Currency',
                      style: TextStyle(fontSize: 14),
                    ),
                    SizedBox(
                      width: 60,
                    ),
                    Text(
                      'Total',
                      style: TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Flexible(
                      flex: 0,
                      child: DropdownButton(
                        underline: const SizedBox(
                          height: 0,
                          width: 0,
                        ),
                        value: currency,
                        style: const TextStyle(
                            color: AppColors.secondaryColor, fontSize: 16),
                        items: currencyItems
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        icon: const Icon(
                          Icons.keyboard_arrow_down,
                          color: Colors.grey,
                        ),
                        onChanged: ((value) {
                          setState(() {
                            currency = value.toString();
                          });
                        }),
                      ),
                    ),
                    SizedBox(width: mediaWidth * 0.18),
                    SizedBox(
                      width: mediaWidth * 0.55,
                      child: TextField(
                        readOnly: false,
                        controller: totalController,
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
                    ),
                  ],
                ),
              ),
              Row(
                children: const [
                  Expanded(
                    flex: 4,
                    child: Divider(
                      color: Colors.grey,
                      thickness: 0.0,
                      indent: 16.0,
                      endIndent: 0.0,
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Expanded(
                    flex: 8,
                    child: Divider(
                      color: Colors.grey,
                      thickness: 0.0,
                      indent: 0.0,
                      endIndent: 16.0,
                    ),
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                child: Text(
                  'Description',
                  style: TextStyle(fontSize: 14),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                child: TextField(
                  readOnly: false,
                  controller: descriptionController,
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
              ),
              const Divider(
                color: Colors.grey,
                thickness: 0.0,
                indent: 16.0,
                endIndent: 16.0,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                child: Text(
                  'Category',
                  style: TextStyle(fontSize: 14),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Container(
                        width: mediaWidth * 0.9,
                        child: DropdownButton(
                          underline: Container(
                            height: 0,
                          ),
                          isExpanded: true,
                          icon: const Icon(
                            Icons.keyboard_arrow_down,
                            color: Colors.grey,
                          ),
                          style: const TextStyle(
                              color: AppColors.secondaryColor, fontSize: 16),
                          value: category,
                          onChanged: ((value) {
                            setState(() {
                              category = value.toString();
                            });
                          }),
                          items: categoryItems
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        )),
                  ],
                ),
              ),
              const Divider(
                color: Colors.grey,
                thickness: 0.0,
                indent: 16.0,
                endIndent: 16.0,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                child: Text(
                  'Method of payment',
                  style: TextStyle(fontSize: 14),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Container(
                        width: mediaWidth * 0.9,
                        decoration: const BoxDecoration(),
                        child: DropdownButton(
                          isExpanded: true,
                          underline: Container(
                            height: 0,
                          ),
                          icon: const Icon(
                            Icons.keyboard_arrow_down,
                            color: Colors.grey,
                          ),
                          style: const TextStyle(
                              color: AppColors.secondaryColor, fontSize: 16),
                          value: payment,
                          onChanged: ((value) {
                            setState(() {
                              payment = value.toString();
                            });
                          }),
                          items: paymentItems
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        )),
                  ],
                ),
              ),
              const Divider(
                color: Colors.grey,
                thickness: 0.0,
                indent: 16.0,
                endIndent: 16.0,
              ),
              TextButton(
                onPressed: () {
                  checkValues();
                },
                child: const Text(
                  'Add Receipt',
                  style: TextStyle(color: Colors.red),
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: MyBottomBar(index: _selectedIndex),
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
          _scanImage();
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

  void checkValues() {
    merchant = merchantController.text.trim();
    date = dateController.text.trim();
    description = descriptionController.text.trim();
    total = totalController.text.trim();

    if (merchant.isEmpty || date.isEmpty || total.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: AppColors.secondaryColor,
          duration: Duration(seconds: 1),
          content: Text("Please fill all the fields!"),
        ),
      );
    } else {
      uploadData();
    }
  }

  void uploadData() async {
    UIHelper.showLoadingDialog(context, "Uploading Recipt..");
    reciptId = uuid.v1();
    UploadTask uploadTask = FirebaseStorage.instance
        .ref("recipts")
        .child(reciptId)
        .putFile(imageFile!);
    TaskSnapshot snapshot = await uploadTask;
    String? imageUrl = await snapshot.ref.getDownloadURL();

    ReciptModel newRecipt = ReciptModel(
      reciptId: reciptId,
      userId: UserModel.loggedinUser!.uid,
      merchant: merchant,
      createdAt: date,
      curency: currency,
      totalBill: total,
      description: description,
      category: category,
      paymentMethod: payment,
      image: imageUrl,
    );

    await FirebaseFirestore.instance
        .collection("recipts")
        .doc(reciptId)
        .set(newRecipt.toMap())
        .then((value) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: AppColors.secondaryColor,
          duration: Duration(seconds: 1),
          content: Text("Recipt Uploaded Sucessfully!"),
        ),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) {
          return const DashboardScreen();
        }),
      );
    });
  }

  Future<void> _scanImage() async {
    final navigator = Navigator.of(context);
    String demoIMage =
        "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";
    String token =
        'ya29.a0AWY7CklDLG-5ZLKLhbKVd-fMSrzgcS5FKS-ZCDLAVuOhr875x-Le3GgRQEiFzkO-w62W7w18ri36pzbEe-74D9BLx-abPTuqXqR9Lsobrz4jyfusDDUVGTEnWEBLn3TytUca9TddBkXyaBTm7wSNasuWJovxk4BoH7rfcWU1IQxlHC3AG0Cg8HnIQVnckGrraZfI9Rsn1NIwhJH-cT67AP3rAk2ijtJtrjVn7YkaCgYKAegSARISFQG1tDrpj53moHi4Z8y4bhO4f3EKKg0238';

    try {
      List<int> imageBytes = imageFile!.readAsBytesSync();
      String base64Image = base64Encode(imageBytes);
      print(base64Image);

      var data = {
        "raw_document": {"content": demoIMage, "mimeType": "image/jpeg"}
      };
      var body = jsonEncode(data);
      final response = await http.post(
          Uri.parse(
              'https://us-documentai.googleapis.com/v1/projects/205806916918/locations/us/processors/1c3f33f7cb3a533e:process'),
          body: body,
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          });

      if (response.statusCode == 200) {
        if (kDebugMode) {
          print('${response.statusCode} Search Respons: ${response.body}');
        }
        var responseData = jsonDecode(response.body);
        if (responseData['Status'] == "SUCCESS") {
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              backgroundColor: AppColors.secondaryColor,
              duration: Duration(seconds: 1),
              content: Text("An error occoured!"),
            ),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: AppColors.secondaryColor,
            duration: Duration(seconds: 1),
            content: Text("An error occoured!"),
          ),
        );
        if (kDebugMode) {
          print(response.statusCode);
        }
      }

      // final inputImage = InputImage.fromFile(file!);
      // final recognizedText = await textRecognizer.processImage(inputImage);
      // String name = recognizedText.text.split('\n').first;
      // Navigator.push(context, MaterialPageRoute(
      //   builder: (context) {
      //     return TestingScreen(text: recognizedText.text);
      //   },
      // ));
      // setState(() {
      //   merchantController.text = name;
      // });
      // RegExp amountPattern = RegExp(r'\$([\d\.]+)');
      // // String amountString =
      // //     amountPattern.firstMatch(recognizedText.text)?.group(1)
      // List<double> amounts = amountPattern
      //     .allMatches(recognizedText.text)
      //     .map((match) => double.parse(match.group(1) ?? '0'))
      //     .toList();
      // double largestAmount = amounts.reduce((a, b) => a > b ? a : b);

      // setState(() {
      //   merchantController.text = name;
      //   totalController.text = largestAmount.toString();
      // });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('An error occurred when scanning text'),
        ),
      );
    }
  }

  Future<String?> generateOAuth2Token() async {
    // Replace these values with your OAuth2 configuration
    const String clientId =
        '205806916918-dimk4n1bp13psvu2p8ci1vdhmacpl5dn.apps.googleusercontent.com';
    const String clientSecret =
        '{\'installed\':{\'client_id\':\'205806916918-dimk4n1bp13psvu2p8ci1vdhmacpl5dn.apps.googleusercontent.com\',\'project_id\':\'shebafinancial\',\'auth_uri\':\'https://accounts.google.com/o/oauth2/auth\',\'token_uri\':\'https://oauth2.googleapis.com/token\',\'auth_provider_x509_cert_url\':\'https://www.googleapis.com/oauth2/v1/certs\'}}';
    const String tokenUrl = 'https://oauth2.googleapis.com/token';
    const String redirectUrl = 'https://oauth2.googleapis.com/token';
    const String code = '';
    const String password = 'your_password';

    try {
      final response = await http.post(
        Uri.parse(tokenUrl),
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: {
          "client_id": clientId,
          "client_secret": clientSecret,
          "redirect_uri": redirectUrl,
          "code": code,
          "grant_type": 'authorization_code'
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        final String? accessToken = responseData['access_token'];
        return accessToken;
      } else {
        print('OAuth2 error: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('OAuth2 error: $e');
      return null;
    }
  }

  Future<void> getToken() async {
    String? token = await generateOAuth2Token();
    if (token != null) {
      print('OAuth2 token: $token');
    } else {
      print('Failed to generate OAuth2 token.');
    }
  }
}
