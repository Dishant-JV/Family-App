import 'dart:convert';

import 'package:family_app/constant/snack_bar.dart';
import 'package:family_app/getx_controller/getx.dart';
import 'package:family_app/screen/login/otp_verify_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:lottie/lottie.dart';
import 'package:sms_autofill/sms_autofill.dart';
import '../../constant/constant.dart';
import 'package:http/http.dart' as http;

class LogInScreen extends StatefulWidget {
  const LogInScreen({Key? key}) : super(key: key);

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final formKey = GlobalKey<FormState>();
  TextEditingController mobileNumberController = TextEditingController();
  TextEditingController memberNumberController = TextEditingController();
  FamilyGetController familyGetController = Get.put(FamilyGetController());
  FirebaseAuth _auth = FirebaseAuth.instance;
  String? verificationId;
  int? forceResendingToken;

  @override
  void initState() {
    super.initState();
    Future<void>.delayed(
        const Duration(milliseconds: 300), _tryPasteCurrentPhone);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        reverse: true,
        scrollDirection: Axis.vertical,
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          behavior: HitTestBehavior.translucent,
          child: Column(
            children: [
              commanLoginAndOtpContainer(context),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        textFieldWidget(
                            "Enter Your Mobile Number",
                            mobileNumberController,
                            false,
                            true,
                            Colors.grey.shade100.withOpacity(0.5),
                            TextInputType.number,
                            Color(0xffFB578E).withOpacity(0.3),
                            1,
                            true),
                        SizedBox(
                          height: 10,
                        ),
                        textFieldWidget(
                            "Enter Your Member number",
                            memberNumberController,
                            false,
                            true,
                            Colors.grey.shade100.withOpacity(0.5),
                            TextInputType.number,
                            Color(0xffFB578E).withOpacity(0.3),
                            1,
                            false),
                        SizedBox(
                          height: getScreenHeight(context, 0.05),
                        ),
                        Obx(() => familyGetController.loginLoading.value ==
                                false
                            ? InkWell(
                                onTap: () async {
                                  if (formKey.currentState?.validate() ==
                                      true) {
                                    FocusScope.of(context).unfocus();
                                    familyGetController.loginLoading.value =
                                        true;
                                    bool r = await showConnectivity(context);
                                    if (r) {
                                      checkLogInDetail(
                                          mobileNumberController.text,
                                          memberNumberController.text.trim());
                                    }
                                  }
                                },
                                child: primaryBtn("NEXT", 0),
                              )
                            : circularProgress()),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    )),
              ),
              Padding(padding: EdgeInsets.only(bottom: 10))
            ],
          ),
        ),
      ),
    );
  }

  Future _tryPasteCurrentPhone() async {
    if (!mounted) return;
    try {
      final autoFill = SmsAutoFill();
      final phone = await autoFill.hint;
      if (phone == null) return;
      if (!mounted) return;
      mobileNumberController.text = phone.replaceAll("+91", "");
      setState(() {});
    } on PlatformException catch (e) {
      print('Failed to get mobile number because of: ${e.message}');
    }
  }

  phoneSignIn(String phone) async {
    try {
      await _auth.verifyPhoneNumber(
          phoneNumber: "+91$phone",
          verificationCompleted: _onVerificationCompleted,
          verificationFailed: _onVerificationFailed,
          codeSent: _onCodeSent,
          codeAutoRetrievalTimeout: _onCodeTimeout,
          forceResendingToken: forceResendingToken,
          timeout: Duration(seconds: 60));
    } catch (e) {
      familyGetController.loginLoading.value = false;
    }
  }

  _onVerificationCompleted(PhoneAuthCredential phoneAuthCredential) async {
    try {
      await _auth.signInWithCredential(phoneAuthCredential);
    } catch (e) {
      familyGetController.loginLoading.value = false;
      snackBar(context, "Something went wrong !", Colors.red);
    }
  }

  _onVerificationFailed(FirebaseAuthException error) {
    try {
      familyGetController.loginLoading.value = false;
      if (error.code == 'invalid-phone-number') {
        snackBar(context, "Enter Valid Mobile Number !", Colors.red);
      } else {
        snackBar(context, "Something went wrong !", Colors.red);
      }
    } catch (e) {
      snackBar(context, "Something went wrong !", Colors.red);
    }
  }

  _onCodeSent(String verificationId, int? forceResendingToken) async {
    this.verificationId = verificationId;
    this.forceResendingToken = forceResendingToken;
    snackBar(context, "Otp Send SuccessFully !", Colors.green);
    familyGetController.loginLoading.value = false;
    pushMethod(
        context,
        VerifyOtpScreen(
          verificationId: verificationId,
          mobileNumber: "+91${mobileNumberController.text}",
          memberId: memberNumberController.text.trim(),
        ));
  }

  _onCodeTimeout(String verificationId) {
    this.verificationId = verificationId;
    setState(() {});
  }

  Future<void> checkLogInDetail(String phone, String memberId) async {
    try {
      final response = await http.post(Uri.parse("$apiUrl/checkCredentials"),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(
              {"phno": "+91$phone", 'memberId': int.parse(memberId)}));
      var data = jsonDecode(response.body);
      if (data['code'] == 200) {
        phoneSignIn(phone);
      } else {
        snackBar(context, "Enter valid phone or memberId", Colors.red);
        familyGetController.loginLoading.value = false;
      }
    } catch (e) {
      familyGetController.loginLoading.value = false;
      snackBar(context, "Something went wrong", Colors.red);
    }
  }
}

commanLoginAndOtpContainer(BuildContext context) {
  return Column(
    children: [
      allScreenStatusBarPadding(context),
      SizedBox(
        height: 15,
      ),
      Text(
        familyName,
        style: familyTextStyle,
      ),
      Lottie.asset('assets/images/family_logo.json',
          height: getScreenHeight(context, 0.3),
          width: getScreenWidth(context, 0.8)),
    ],
  );
}
