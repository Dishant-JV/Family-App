import 'dart:async';

import 'package:family_app/constant/set_pref.dart';
import 'package:family_app/screen/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../constant/constant.dart';
import '../login/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? timer;

  @override
  void initState() {
    checkLogIn();
  }

  @override
  void dispose() {
    super.dispose();
    timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Container(
          alignment: Alignment.center,
          child: Column(
            children: [
              Expanded(
                  child: Column(
                children: [
                  allScreenStatusBarPadding(context),
                  Lottie.asset('assets/images/splash_image.json',
                      height: getScreenHeight(context, 0.5),
                      width: getScreenWidth(context, 0.8)),
                  SizedBox(
                    height: 20,
                  ),
                  Lottie.asset('assets/images/welcome_image.json',
                      height: getScreenHeight(context, 0.1),
                      width: getScreenWidth(context, 0.8)),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    familyName,
                    style: familyTextStyle,
                  ),
                ],
              )),
              Text(
                "Powered by Laxicon Solution",
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 17,
                    letterSpacing: 0.5,
                    color: Colors.grey.shade500),
              ),
              Text(
                "www.laxicon.in",
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 17,
                    letterSpacing: 0.5,
                    color: Colors.grey.shade700),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void checkLogIn() {
    Timer(Duration(seconds: 3), () {
      getBoolPref('login').then((value) {
        if (value == true) {
          pushRemoveUntilMethod(context, HomeScreen());
        } else {
          pushRemoveUntilMethod(context, LogInScreen());
        }
      });
    });
  }
}
