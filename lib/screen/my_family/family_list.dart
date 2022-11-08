import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;

import '../../constant/constant.dart';
import '../../constant/profile/profile_page.dart';
import '../../constant/set_pref.dart';
import '../../constant/snack_bar.dart';
import '../../getx_controller/getx.dart';
import '../profile/edit_my_profile_page.dart';
import 'family_form_screen.dart';

class FamilyListScreen extends StatefulWidget {
  const FamilyListScreen({Key? key}) : super(key: key);

  @override
  State<FamilyListScreen> createState() => _FamilyListScreenState();
}

class _FamilyListScreenState extends State<FamilyListScreen> {
  @override
  void initState() {
    super.initState();
    showConnectivity(context).then((value) {
      if (value) {
        familyGetController.familyDataList.clear();
        getFamilyData();
      }
    });
  }

  FamilyGetController familyGetController = Get.put(FamilyGetController());
  bool loading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          allScreenStatusBarPadding(context),
          AllPageTitle(
            text: "My Family",
          ),
          Obx(() => Expanded(
                child: familyGetController.familyDataList.isNotEmpty
                    ? ListView.builder(
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        padding: EdgeInsets.symmetric(vertical: 10),
                        shrinkWrap: true,
                        itemCount: familyGetController.familyDataList.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              pushMethod(
                                  context,
                                  ProfilePageUI(
                                    showEditBtn: false,
                                    switchData:
                                        familyGetController.myFamilyOnOff,
                                    map: familyGetController
                                        .familyDataList[index],
                                    screenName: 'Member Profile',
                                  ));
                            },
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 10),
                              padding: EdgeInsets.symmetric(vertical: 8),
                              child: Row(
                                children: [
                                  profilePhotoContainer(40),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${familyGetController.familyDataList[index]['titleData']['engTitle']} ${familyGetController.familyDataList[index]['engFirstName']} ${familyGetController.familyDataList[index]['engMiddleName']} ${familyGetController.familyDataList[index]['engLastName']}",
                                          style: allCardMainTextStyle,
                                        ),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              "Relation : ",
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            Text(
                                                familyGetController
                                                        .familyDataList[index]
                                                    ['engRelation'],
                                                style: TextStyle(
                                                    color: Colors.grey.shade700,
                                                    fontWeight:
                                                        FontWeight.w500))
                                          ],
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
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

  void getFamilyData() {
    try {
      getStringPref('token').then((token) async {
        final response = await http.get(
          Uri.parse("$apiUrl/viewSubMemberList"),
          headers: {'Authorization': token},
        );
        var data = jsonDecode(response.body);
        if (data['code'] == 200) {
          familyGetController.familyDataList.addAll(data['data']);
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
