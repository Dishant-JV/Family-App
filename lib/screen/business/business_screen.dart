import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;

import '../../constant/constant.dart';
import '../../constant/set_pref.dart';
import '../../constant/snack_bar.dart';
import '../../constant/switch.dart';
import '../../getx_controller/getx.dart';
import '../profile/edit_my_profile_page.dart';
import 'business_detail_list.dart';

class BusinessScreen extends StatefulWidget {
  const BusinessScreen({Key? key}) : super(key: key);

  @override
  State<BusinessScreen> createState() => _BusinessScreenState();
}

class _BusinessScreenState extends State<BusinessScreen> {
  FamilyGetController familyGetController = Get.put(FamilyGetController());

  @override
  void initState() {
    super.initState();
    showConnectivity(context).then((value) {
      if (value) {
        familyGetController.businessNameList.clear();
        getBusinessData();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          allScreenStatusBarPadding(context),
          allPageTitleRow("Business Type", familyGetController.businessOnOff),
          Obx(() => Expanded(
              child: familyGetController.businessNameList.isNotEmpty
                  ? ListView.builder(
                      scrollDirection: Axis.vertical,
                      physics: BouncingScrollPhysics(),
                      itemCount: familyGetController.businessNameList.length,
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            pushMethod(
                                context,
                                BusinessDetailList(
                                  businessTypeId: familyGetController
                                          .businessNameList[index]
                                      ['businessTypeId'],
                                ));
                          },
                          child: Container(
                            width: double.infinity,
                            margin: EdgeInsets.only(bottom: 10),
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 15),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6.0),
                              border: Border.all(
                                  color: primaryColor.withOpacity(0.3),
                                  width: 0.1),
                              color: index % 2 == 0
                                  ? Color(0xff01559E)
                                  : Color(0xff688BAB),
                            ),
                            child: Obx(() => Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        physics: BouncingScrollPhysics(),
                                        child: Text(
                                          familyGetController
                                                      .businessOnOff.value ==
                                                  false
                                              ? familyGetController
                                                      .businessNameList[index]
                                                  ['engName']
                                              : familyGetController
                                                      .businessNameList[index]
                                                  ['gujName'],
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 5),
                                      child: Icon(Icons.arrow_forward_ios,
                                          size: 18, color: Colors.white),
                                    )
                                  ],
                                )),
                          ),
                        );
                      })
                  : Center(
                      child: circularProgress(),
                    ))),
        ],
      ),
    );
  }

  void getBusinessData() {
    try {
      getStringPref('token').then((token) async {
        final response = await http.get(
          Uri.parse("$apiUrl/viewBusinessTypeList"),
          headers: {'Authorization': token},
        );
        var data = jsonDecode(response.body);
        if (data['code'] == 200) {
          familyGetController.businessNameList.addAll(data['data']);
        } else {
          snackBar(context, "Something went wrong", Colors.red);
        }
      });
    } catch (e) {
      snackBar(context, "Something went wrong", Colors.red);
    }
  }
}
