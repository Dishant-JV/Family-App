import 'package:family_app/screen/login/otp_verify_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../constant/constant.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({Key? key}) : super(key: key);

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final formKey = GlobalKey<FormState>();
  TextEditingController mobileNumberController = TextEditingController();
  TextEditingController memberNumber = TextEditingController();

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
                            memberNumber,
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
                        SizedBox(
                            width: double.infinity,
                            height: 40,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: primaryColor),
                                onPressed: () {
                                  FocusScope.of(context).unfocus();
                                  if (formKey.currentState?.validate() ==
                                      true) {
                                    pushMethod(context, VerifyOtpScreen());
                                  }
                                },
                                child: Text(
                                  "SEND OTP",
                                  style: TextStyle(
                                      fontSize: 16.5, letterSpacing: 1),
                                )))
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
