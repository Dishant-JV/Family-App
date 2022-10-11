import 'dart:convert';
import 'package:family_app/constant/set_pref.dart';
import 'package:http/http.dart' as http;
import 'package:alt_sms_autofill/alt_sms_autofill.dart';
import 'package:family_app/constant/constant.dart';
import 'package:family_app/getx_controller/getx.dart';
import 'package:family_app/screen/home/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:sms_autofill/sms_autofill.dart';

import '../../constant/snack_bar.dart';
import 'login_screen.dart';

class VerifyOtpScreen extends StatefulWidget {
  final String verificationId;
  final String mobileNumber;
  final String memberId;

  const VerifyOtpScreen(
      {Key? key,
      required this.verificationId,
      required this.mobileNumber,
      required this.memberId})
      : super(key: key);

  @override
  State<VerifyOtpScreen> createState() => _VerifyOtpScreenState();
}

class _VerifyOtpScreenState extends State<VerifyOtpScreen> {
  String enteredOtp = "";
  FamilyGetController familyGetController = Get.put(FamilyGetController());
  FirebaseAuth _auth = FirebaseAuth.instance;
  TextEditingController? textEditingController1;
  String _comingSms = '';

  @override
  void initState() {
    super.initState();
    textEditingController1 = TextEditingController();
    initSmsListener();
  }

  initSmsListener() async {
    String? comingSms;
    try {
      comingSms = await AltSmsAutofill().listenForSms;
    } on PlatformException {
      comingSms = 'Failed to get Sms.';
    }
    if (!mounted) return;
    setState(() {
      _comingSms = comingSms ?? "";
      textEditingController1?.text = _comingSms[0] +
          _comingSms[1] +
          _comingSms[2] +
          _comingSms[3] +
          _comingSms[4] +
          _comingSms[5];
    });
  }

  @override
  void dispose() {
    textEditingController1?.dispose();
    AltSmsAutofill().unregisterListener();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        reverse: true,
        scrollDirection: Axis.vertical,
        child: Container(
          alignment: Alignment.center,
          child: Column(
            children: [
              commanLoginAndOtpContainer(context),
              SizedBox(
                height: 20,
              ),
              Container(
                width: getScreenWidth(context, 0.85),
                child: PinCodeTextField(
                  appContext: context,
                  length: 6,
                  obscureText: false,
                  animationType: AnimationType.fade,
                  pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(10),
                      fieldHeight: 45,
                      fieldWidth: getScreenWidth(context, 0.1),
                      inactiveFillColor: Colors.white,
                      inactiveColor: Colors.grey,
                      selectedColor: primaryColor,
                      selectedFillColor: Colors.white,
                      activeFillColor: Colors.white,
                      activeColor: primaryColor),
                  cursorColor: Colors.black,
                  animationDuration: Duration(milliseconds: 300),
                  enableActiveFill: true,
                  controller: textEditingController1,
                  keyboardType: TextInputType.number,
                  onCompleted: (v) {
                    verifyOtp();
                  },
                  onChanged: (value) {
                    setState(() {
                      enteredOtp = value;
                    });
                  },
                ),
              ),
              SizedBox(
                height: getScreenHeight(context, 0.05),
              ),
              Obx(() => familyGetController.otpVerifyLogin.value == false
                  ? InkWell(
                      onTap: () {
                        FocusScope.of(context).unfocus();
                        if (enteredOtp.length == 6) {
                          verifyOtp();
                        }
                      },
                      child: primaryBtn("VERIFY OTP", 20),
                    )
                  : circularProgress()),
              Padding(padding: EdgeInsets.only(bottom: 20))
            ],
          ),
        ),
      ),
    );
  }

  verifyOtp() async {
    familyGetController.otpVerifyLogin.value = true;
    try {
      await _auth
          .signInWithCredential(PhoneAuthProvider.credential(
              verificationId: widget.verificationId, smsCode: enteredOtp))
          .then((value) async {
        if (value.user != null) {
          bool r = await showConnectivity(context);
          if (r) {
            logIn();
          }
        }
      });
    } on FirebaseAuthException catch (e) {
      familyGetController.otpVerifyLogin.value = false;
      if (e.code == 'invalid-verification-code') {
        snackBar(context, "Enter Valid Verification Code !", Colors.red);
      } else {
        snackBar(context, "Something went wrong !", Colors.red);
      }
    }
  }

  Future<void> logIn() async {
    try {
      final response = await http.post(Uri.parse("$apiUrl/login"),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({
            "phno": "${widget.mobileNumber}",
            'memberId': int.parse("${widget.memberId}")
          }));
      var data = jsonDecode(response.body);
      if (data['code'] == 200) {
        setStringPref('token', data['data']['token']);
        setBoolPref('login',true);
        familyGetController.otpVerifyLogin.value = false;
        snackBar(context, "Login SuccessFully !", Colors.green);
        pushMethod(context, HomeScreen());
      } else {
        familyGetController.otpVerifyLogin.value = false;
        snackBar(context, "Something went wrong", Colors.red);
      }
    } catch (e) {
      familyGetController.otpVerifyLogin.value = false;
      snackBar(context, "Something went wrong", Colors.red);
    }
  }
}
