import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../constant/constant.dart';
import '../../constant/set_pref.dart';
import '../../constant/snack_bar.dart';
import '../profile/edit_my_profile_page.dart';

class FeedBackScreen extends StatefulWidget {
  const FeedBackScreen({Key? key}) : super(key: key);

  @override
  State<FeedBackScreen> createState() => _FeedBackScreenState();
}

class _FeedBackScreenState extends State<FeedBackScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        reverse: true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                SizedBox(
                  height: getScreenHeight(context, 0.3) + 60,
                ),
                Container(
                  height: getScreenHeight(context, 0.3),
                  width: getScreenWidth(context, 1.0),
                  decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(50),
                          bottomRight: Radius.circular(50))),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: 5, top: MediaQuery.of(context).padding.top + 10),
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(
                          Icons.keyboard_arrow_left_outlined,
                          size: 38,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        width: getScreenWidth(context, 0.03),
                      ),
                      Text(
                        "Feedback",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 23,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0.5,
                  right: 0.5,
                  child: Container(
                    margin: EdgeInsets.only(
                        top: getScreenHeight(context, 0.3) + 22.5),
                    child: CircleAvatar(
                      backgroundColor: Colors.grey.shade200,
                      radius: 60,
                      child: Icon(
                        Icons.feedback,
                        color: primaryColor,
                        size: 50,
                      ),
                    ),
                  ),
                )
              ],
            ),
            Form(
              key: formKey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Title :",
                          style: allCardMainTextStyle,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        textFieldWidget(
                            "Enter Title",
                            titleController,
                            false,
                            true,
                            Colors.grey.shade100.withOpacity(0.5),
                            TextInputType.text,
                            Color(0xffFB578E).withOpacity(0.3),
                            1,
                            false),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          "Description :",
                          style: allCardMainTextStyle,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        textFieldWidget(
                            "Enter Description",
                            descController,
                            false,
                            true,
                            Colors.grey.shade100.withOpacity(0.5),
                            TextInputType.text,
                            Color(0xffFB578E).withOpacity(0.3),
                            2,
                            false),
                        SizedBox(
                          height: 20,
                        ),
                        InkWell(
                          onTap: () {
                            if (formKey.currentState?.validate() == true) {
                              submitFeedBack();
                            }
                          },
                          child: primaryBtn("Submit", 0),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            Padding(padding: EdgeInsets.only(bottom: 10))
          ],
        ),
      ),
    );
  }

  void submitFeedBack() {
    showConnectivity(context).then((value) {
      if (value) {
        print(titleController.text);
        getStringPref('token').then((token) async {
            final response = await http.post(Uri.parse("$apiUrl/addFeedback"),
              headers: {
                'Authorization': token,
                'Content-Type': 'application/json',
              },
              body: jsonEncode({
                "title": titleController.text,
                'description': descController.text
              }));
          print(response.body);
          var data = jsonDecode(response.body);
          if (data['code'] == 200) {
            snackBar(context, "Feedback sent successfully", Colors.green);
            Navigator.pop(context);
          } else {
            snackBar(context, data['message'], Colors.red);
          }
        });
      } else {
        showToast("Check Internet");
      }
    });
  }
}
