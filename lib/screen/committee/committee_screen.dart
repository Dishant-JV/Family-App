import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;

import '../../constant/constant.dart';
import '../../constant/member_container.dart';
import '../../constant/profile/profile_page.dart';
import '../../constant/set_pref.dart';
import '../../constant/snack_bar.dart';
import '../../constant/switch.dart';
import '../../getx_controller/getx.dart';
import '../profile/edit_my_profile_page.dart';

class CommmitteeScreen extends StatefulWidget {
  const CommmitteeScreen({Key? key}) : super(key: key);

  @override
  State<CommmitteeScreen> createState() => _CommmitteeState();
}

class _CommmitteeState extends State<CommmitteeScreen> {
  FamilyGetController familyGetController = Get.put(FamilyGetController());
  bool loading = true;

  @override
  void initState() {
    super.initState();
    showConnectivity(context).then((value) {
      if (value) {
        familyGetController.committeeMemberList.clear();
        getCommiteeData('');
      }
    });
  }

  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          allScreenStatusBarPadding(context),
          Row(
            children: [
              Expanded(child: AllPageTitle(text: "Commitee Member")),
              Padding(
                padding: EdgeInsets.only(right: 15),
                child: engGujSwitch(familyGetController.committeeMemberOnOff),
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextFormField(
                controller: searchController,
                onChanged: (val) {
                  setState(() {
                    familyGetController.committeeMemberList.clear();
                    loading = true;
                    getCommiteeData(val);
                  });
                },
                decoration: InputDecoration(
                    isDense: true,
                    hintText: "Search Member",
                    hintStyle:
                        TextStyle(color: Color(0xff5D92C1).withOpacity(0.8)),
                    filled: true,
                    fillColor: Colors.grey.shade100.withOpacity(0.5),
                    errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.red.shade300)),
                    errorStyle:
                        TextStyle(color: Colors.red.shade300, fontSize: 12),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color(0xff5D92C1).withOpacity(0.05)),
                        borderRadius: BorderRadius.circular(10)),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color(0xff5D92C1).withOpacity(0.05)),
                        borderRadius: BorderRadius.circular(10)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color(0xff5D92C1).withOpacity(0.8)),
                        borderRadius: BorderRadius.circular(10))),
              )),
          SizedBox(
            height: 10,
          ),
          Obx(() => Expanded(
                child: familyGetController.committeeMemberList.isNotEmpty
                    ? ListView.builder(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        physics: BouncingScrollPhysics(),
                        itemCount:
                            familyGetController.committeeMemberList.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              showConnectivity(context).then((value) {
                                if (value) {
                                  getParticularCommitteeData(familyGetController
                                          .committeeMemberList[index]
                                      ['comiteeMemberId']);
                                  pushMethod(
                                      context,
                                      ProfilePageUI(
                                        showEditBtn: false,
                                        switchData: familyGetController
                                            .committeeMemberMapOnOff,
                                        map: familyGetController
                                            .committeeMemberMap,
                                        screenName: 'Member Profile',
                                        committeeScreen: true,
                                      ));
                                } else {
                                  snackBar(
                                      context, "Check Internet", Colors.red);
                                }
                              });
                            },
                            child: MemberContainer(
                              index: index,
                              lst: familyGetController.committeeMemberList,
                              switchData:
                                  familyGetController.committeeMemberOnOff,
                              commiteeScreen: true,
                            ),
                          );
                        })
                    : loading == true
                        ? Center(
                            child: circularProgress(),
                          )
                        : centerNoRecordText(),
              ))
        ],
      ),
    );
  }

  void getCommiteeData(String searchBy) {
    try {
      getStringPref('token').then((token) async {
        var params = {'searchBy': searchBy};
        Uri uri = Uri.parse("$apiUrl/viewMainComiteeMemberList");
        final finalUri = uri.replace(queryParameters: params);
        final response = await http.get(finalUri, headers: {
          'Authorization': token,
        });
        var data = jsonDecode(response.body);
        if (data['code'] == 200) {
          familyGetController.committeeMemberList.addAll(data['data']);
          print(familyGetController.committeeMemberList.length);
        }
        setState(() {
          loading = false;
        });
      });
    } catch (e) {
      snackBar(context, "Something went wrong", Colors.red);
    }
  }

  void getParticularCommitteeData(int memberRecId) {
    familyGetController.committeeMemberMap.clear();
    getStringPref('token').then((token) async {
      final response = await http
          .get(Uri.parse("$apiUrl/viewComiteeMember/$memberRecId"), headers: {
        'Authorization': token,
      });
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        familyGetController.committeeMemberMap.addAll(data['data']);
      }
    });
  }
}
