
import 'package:family_app/constant/constant.dart';
import 'package:family_app/getx_controller/getx.dart';
import 'package:family_app/screen/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';

import 'login_screen.dart';

class VerifyOtpScreen extends StatefulWidget {
  const VerifyOtpScreen({Key? key}) : super(key: key);

  @override
  State<VerifyOtpScreen> createState() => _VerifyOtpScreenState();
}

class _VerifyOtpScreenState extends State<VerifyOtpScreen> {
  int? enteredOtp;
  FamilyGetController familyGetController = Get.put(FamilyGetController());

  @override
  void initState() {}

  OtpFieldController otpController = OtpFieldController();

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
              OTPTextField(
                  controller: otpController,
                  length: 4,
                  width: getScreenWidth(context, 0.7),
                  textFieldAlignment: MainAxisAlignment.spaceAround,
                  fieldWidth: 45,
                  fieldStyle: FieldStyle.box,
                  outlineBorderRadius: 15,
                  style: TextStyle(
                      fontSize: 17,
                      color: primaryColor,
                      fontWeight: FontWeight.w500),
                  onChanged: (pin) {
                    familyGetController.userOtp.value = pin;
                  },
                  onCompleted: (pin) {
                    verifyOtp(pin);
                  }),
              SizedBox(
                height: getScreenHeight(context, 0.1),
              ),
              Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: getScreenWidth(context, 0.18)),
                  width: double.infinity,
                  height: 40,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: primaryColor),
                      onPressed: () {
                        FocusScope.of(context).unfocus();
                        if (familyGetController.userOtp.value.length == 4) {
                          pushRemoveUntilMethod(context, HomeScreen());
                        }
                      },
                      child: Text(
                        "VERIFY OTP",
                        style: TextStyle(fontSize: 16.5, letterSpacing: 1),
                      ))),
              Padding(padding: EdgeInsets.only(bottom: 20))
            ],
          ),
        ),
      ),
    );
  }

  void verifyOtp(String pin) {}
}
