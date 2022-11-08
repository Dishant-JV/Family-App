import 'dart:convert';

import 'package:family_app/getx_controller/getx.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'package:http/http.dart' as http;

import '../../constant/constant.dart';
import '../../constant/set_pref.dart';
import '../../constant/snack_bar.dart';

class CommiteeMemberListScreen extends StatefulWidget {
  final int comiteeId;

  const CommiteeMemberListScreen({Key? key, required this.comiteeId})
      : super(key: key);

  @override
  State<CommiteeMemberListScreen> createState() =>
      _CommiteeMemberListScreenState();
}

class _CommiteeMemberListScreenState extends State<CommiteeMemberListScreen> {
  FamilyGetController familyGetController = Get.find();
  bool loading = true;
  Map commiteeDetailData = {};
  List mainMemberList = [];
  List subMemberList = [];

  @override
  void initState() {
    super.initState();
    showConnectivity(context).then((value) {
      if (value) {
        getCommiteeMemberList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          allScreenStatusBarPadding(context),
          allPageTitleRow("Commitee Member List",
              familyGetController.commiteeDetailListOnOff),
          commiteeDetailData.length != 0
              ? Obx(() => Container(
                    margin: EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          familyGetController.commiteeDetailListOnOff.value ==
                                  false
                              ? ":: ${commiteeDetailData['engName']} ::"
                              : ":: ${commiteeDetailData['gujName']} ::",
                          style: familyTextStyle,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          commiteeDetailData['comiteeType'],
                          style: profilePageMainTextStyle,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        mainMemberList.isNotEmpty
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Main Member :",
                                    style: allCardMainTextStyle,
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: mainMemberList.length,
                                      padding: EdgeInsets.zero,
                                      itemBuilder: (context, index) {
                                        return Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 8, vertical: 5),
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                              color:
                                                  Colors.grey.withOpacity(0.2),
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          child: Text(
                                            familyGetController
                                                        .commiteeDetailListOnOff
                                                        .value ==
                                                    false
                                                ? "${mainMemberList[index]['engFirstName']} ${mainMemberList[index]['engMiddleName']} ${mainMemberList[index]['engLastName']}"
                                                : "${mainMemberList[index]['gujFirstName']} ${mainMemberList[index]['gujMiddleName']} ${mainMemberList[index]['gujLastName']}",
                                            style: profilePageSubTextStyle,
                                          ),
                                        );
                                      })
                                ],
                              )
                            : Container(),
                        SizedBox(
                          height: 20,
                        ),
                        subMemberList.isNotEmpty
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Sub Member :",
                                    style: allCardMainTextStyle,
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: subMemberList.length,
                                      padding: EdgeInsets.zero,
                                      itemBuilder: (context, index) {
                                        return Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 8, vertical: 5),
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                              color:
                                                  Colors.grey.withOpacity(0.2),
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          child: Text(
                                            familyGetController
                                                        .commiteeDetailListOnOff
                                                        .value ==
                                                    false
                                                ? "${subMemberList[index]['engFirstName']} ${subMemberList[index]['engMiddleName']} ${subMemberList[index]['engLastName']}"
                                                : "${subMemberList[index]['gujFirstName']} ${subMemberList[index]['gujMiddleName']} ${subMemberList[index]['gujLastName']}",
                                            style: profilePageSubTextStyle,
                                          ),
                                        );
                                      })
                                ],
                              )
                            : Container()
                      ],
                    ),
                  ))
              : loading == true
                  ? Expanded(
                      child: Center(
                      child: circularProgress(),
                    ))
                  : Expanded(
                      child: Center(
                      child: centerNoRecordText(),
                    ))
        ],
      ),
    );
  }

  void getCommiteeMemberList() {
    try {
      getStringPref('token').then((token) async {
        final response = await http.get(
            Uri.parse("$apiUrl/viewComiteeMemberList/${widget.comiteeId}"),
            headers: {
              'Authorization': token,
            });
        var data = jsonDecode(response.body);
        if (data['code'] == 200) {
          commiteeDetailData.addAll(data['data']);
          if (data['data']['mainMemberList'] != null) {
            mainMemberList.addAll(data['data']['mainMemberList']);
          }
          if (data['data']['subMemberList'] != null) {
            subMemberList.addAll(data['data']['subMemberList']);
          }
        }
        setState(() {
          loading = false;
        });
      });
    } catch (e) {
      snackBar(context, "Something went wrong", Colors.red);
    }
  }
}
