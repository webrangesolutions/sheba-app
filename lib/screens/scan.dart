import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:sheba_financial/models/recipt_model.dart';
import 'package:sheba_financial/models/user_model.dart';
import 'package:sheba_financial/screens/dashboard.dart';
import 'package:http/http.dart' as http;
import 'package:sheba_financial/screens/webview.dart';
import 'package:uuid/uuid.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../helpers/ui_helper.dart';
import '../utils/color_constants.dart';
import '../widgets/bottom_bar.dart';
import 'package:oauth2/oauth2.dart' as oauth2;
import 'package:url_launcher/url_launcher.dart';

class ScanScreen extends StatefulWidget {
  const ScanScreen({super.key});

  @override
  ScanScreenState createState() => ScanScreenState();
}

class ScanScreenState extends State<ScanScreen> {
  int _selectedIndex = 1;
  String authCode = '';
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
    // String dateNow = (DateFormat.yMMMMd().format(DateTime.now())).toString();
    // dateController.text = dateNow;
    getCode();
    // getToken();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mediaHeight = MediaQuery.of(context).size.height;
    final mediaWidth = MediaQuery.of(context).size.width;
    String dateNow = (DateFormat.yMMMMd().format(DateTime.now())).toString();
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
    UIHelper.showLoadingDialog(context, 'Parsing Recipt');
    final navigator = Navigator.of(context);
    String token =
        'ya29.a0AWY7CkksZsVG2FrIokP04Ud4cFd4Tu-MCYPkmgaAm19_q4LO2Rq-mTj4K6MA6bCGUAlJXGhQifsH00B6nlO1xB0uDHIBQWGbtY4Uq7jBESlaJCNzah5yfvjnW0bqYoh6wkd6siBtotNon8WOGLFK7EU9mU_ZaCgYKAUUSARISFQG1tDrp5R93iORIhDavx7rtGuurcg0163';

    try {
      List<int> imageBytes = imageFile!.readAsBytesSync();
      String base64Image = base64Encode(imageBytes);
      print(base64Image);

      var data = {
        "raw_document": {"content": base64Image, "mimeType": "image/jpeg"}
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
        var totalAmount = '';
        if (kDebugMode) {
          print('${response.statusCode} Search Respons: ${response.body}');
          var responseData = jsonDecode(response.body);
          for (var element in responseData['document']['entities']) {
            if (element['type'] == 'total_amount') {
              totalAmount = element['mentionText'];
              total = element['mentionText'];
              setState(() {
                totalController.text = total;
              });
            } else if (element['type'] == 'receipt_date') {
              totalAmount = element['mentionText'];
              date = element['mentionText'];
              setState(() {
                dateController.text = date;
              });
            } else if (element['type'] == 'supplier_name') {
              totalAmount = element['normalizedValue']['text'];
              total = element['normalizedValue']['text'];
              setState(() {
                merchantController.text = total;
              });
            }
          }

          print('Search Respons: $totalAmount');
          // UIHelper.showAlertDialog(context, 'response', totalAmount.toString());
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('An error occurred when scanning text'),
        ),
      );
    }
    Navigator.pop(context);
  }

  Future<String?> generateOAuth2Token() async {
    // Replace these values with your OAuth2 configuration
    const String clientId =
        '205806916918-95gdof0kd4cqho1d079ftctgrpnj44i3.apps.googleusercontent.com';
    const String clientSecret = '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';

    const String tokenUrl = 'https://oauth2.googleapis.com/token';
    const String redirectUrl = 'com.webrange.shebafinancial://login-callback';
    const String code = '';

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

  void getCode() async {
    authCode = await getAuthorizationCode();

    if (authCode != '') {
      print('Authorization code: $authCode');
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

  Future<String> getAuthorizationCode() async {
    try {
      final authorizationUrl = Uri.parse(
          'https://accounts.google.com/o/oauth2/auth?scope=https://www.googleapis.com/auth/cloud-platform&response_type=code&redirect_uri=https://localhost:8080/&client_id=205806916918-95gdof0kd4cqho1d079ftctgrpnj44i3.apps.googleusercontent.com&access_type=offline&prompt=consent');
      // final authorizationUrl = Uri.parse(
      //     'https://accounts.google.com/o/oauth2/auth?scope=https://www.googleapis.com/auth/cloud-platform&response_type=code&redirect_uri=https://google.com/&client_id=205806916918-95gdof0kd4cqho1d079ftctgrpnj44i3.apps.googleusercontent.com&access_type=offline&prompt=consent');

      // if (!await launchUrl(authorizationUrl,
      //     mode: LaunchMode.externalApplication)) {
      //   print('cant open url');
      // }

      // final authCodeCompleter = Completer<String>();

      // final flutterWebviewPlugin = FlutterWebviewPlugin();

      // await flutterWebviewPlugin.launch(
      //   authorizationUrl.toString(),
      // );

      // flutterWebviewPlugin.onUrlChanged.listen((String url) {
      //   if (url.startsWith('https://localhost:8080/')) {
      //     final uri = Uri.parse(url);
      //     final code = uri.queryParameters['code'];

      //     if (code != null) {
      //       authCodeCompleter.complete(code);
      //       print('code:$code');
      //     } else {
      //       authCodeCompleter.completeError('Authorization code not found');
      //     }

      //     flutterWebviewPlugin.close();
      //   }
      // });

      // final code = await authCodeCompleter.future;
      // final controller = WebViewController()
      //   ..setNavigationDelegate(NavigationDelegate(
      //     onPageStarted: (url) {},
      //     onProgress: (progress) {},
      //     onPageFinished: (url) {
      //       print('url:$url');
      //     },
      //     onNavigationRequest: (request) {
      //       // if (request.url.startsWith("https:")) {
      //       //   return NavigationDecision.navigate;
      //       // } else {
      //       _launchURL(request.url);
      //       return NavigationDecision.prevent;
      //       //   }
      //     },
      //   ))
      //   ..loadRequest(
      //     authorizationUrl,
      //   );

      // WebViewWidget(controller: controller);
      

      return '';
    } catch (e) {
      print("errorr${e.toString()}");
      return '';
    }
    
  }
  void _launchAuthorizationUrl(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

  
}
