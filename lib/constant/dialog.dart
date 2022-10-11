import 'package:family_app/constant/constant.dart';
import 'package:family_app/constant/set_pref.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import '../screen/login/login_screen.dart';


ExitDialog(BuildContext context) {
  return showGeneralDialog(
    barrierColor: Colors.black.withOpacity(0.5),
    transitionBuilder: (context, a1, a2, widget) {
      return Transform.scale(
        scale: a1.value,
        child: Opacity(
          opacity: a1.value,
          child: Dialog(
              backgroundColor: Colors.transparent,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(
                    children: [
                      Container(
                        height: getScreenHeight( context,0.17),
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.white.withOpacity(0.5), width: 2),
                            borderRadius: BorderRadius.circular(20)),
                      ),
                      Transform.rotate(
                        angle: -math.pi / 30,
                        child: Container(
                          alignment: Alignment.center,
                          height: getScreenHeight(context,0.17),
                          decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.circular(20)),
                          child: Transform.rotate(
                            angle: -math.pi / -30,
                            child: Container(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Sure , Are you want to Logout?",
                                      style: TextStyle(
                                          fontSize: 19,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white),
                                    ),
                                    SizedBox(
                                      height: getScreenHeight(context,0.015),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        InkWell(
                                          onTap: () async {
                                            await FirebaseAuth.instance.signOut();
                                            setBoolPref('login', false);
                                            Navigator.pop(context);
                                            pushRemoveUntilMethod(context, LogInScreen());
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color:
                                                Colors.white.withOpacity(0.5),
                                                borderRadius:
                                                BorderRadius.circular(15)),
                                            height: getScreenHeight(context,0.05),
                                            width: getScreenWidth(context, 0.2),
                                            alignment: Alignment.center,
                                            child: Text(
                                              "Ok",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 16),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Material(
                                          color: Colors.transparent,
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.pop(context);
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  color:
                                                  Colors.white.withOpacity(0.2),
                                                  borderRadius:
                                                  BorderRadius.circular(15)),
                                              height: getScreenHeight(context,0.05),
                                              width: getScreenWidth(context, 0.2),
                                              alignment: Alignment.center,
                                              child: Text(
                                                "Cancel",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 16),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                )),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              )),
        ),
      );
    },
    transitionDuration: Duration(milliseconds: 300),
    barrierDismissible: true,
    barrierLabel: '',
    context: context,
    pageBuilder: (BuildContext context, Animation<double> animation,
        Animation<double> secondaryAnimation) {
      return Text("");
    },
  );
}
