import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../constant/constant.dart';
import '../../constant/set_pref.dart';
import '../../constant/snack_bar.dart';
import '../../getx_controller/getx.dart';
import 'package:http/http.dart' as http;
import 'donor_detail_screen.dart';

class DonorScreen extends StatefulWidget {
  const DonorScreen({Key? key}) : super(key: key);

  @override
  State<DonorScreen> createState() => _DonorScreenState();
}

class _DonorScreenState extends State<DonorScreen> {
  FamilyGetController familyGetController = Get.put(FamilyGetController());
  bool loading = true;

  @override
  void initState() {
    super.initState();
    showConnectivity(context).then((value) {
      if (value) {
        familyGetController.donationTypeList.clear();
        getDonationType();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          allScreenStatusBarPadding(context),
          allPageTitleRow(
              "Doner's Type", familyGetController.donationTypeOnOff),
          Obx(()=>Expanded(
              child: familyGetController.donationTypeList.isNotEmpty
                  ? ListView.builder(
                  scrollDirection: Axis.vertical,
                  physics: BouncingScrollPhysics(),
                  itemCount: familyGetController.donationTypeList.length,
                  padding:
                  EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () async {
                        pushMethod(
                            context,
                            DonorDetailScreen(
                              donationId:
                              familyGetController.donationTypeList[index]
                              ['donationTypeId'],
                            ));
                      },
                      child: Obx(()=>Container(
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
                              ? Color(0xffDEDAD9)
                              : Color(0xffC4F0F1),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                physics: BouncingScrollPhysics(),
                                child: Text(
                                  familyGetController.donationTypeOnOff
                                      .value ==
                                      false
                                      ? familyGetController.donationTypeList[index]
                                  ['engName']
                                      : familyGetController.donationTypeList[index]
                                  ['gujName'],
                                  maxLines: 1,
                                  style: allCardSubTextStyle,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 5),
                              child: forwardIcon,
                            )
                          ],
                        ),
                      )),
                    );
                  })
                  : loading == true
                  ? Center(
                child: circularProgress(),
              )
                  : centerNoRecordText())),
        ],
      ),
    );
  }

  void getDonationType() {
    try {
      getStringPref('token').then((token) async {
        final response =
            await http.get(Uri.parse("$apiUrl/viewDonationTypeList"), headers: {
          'Authorization': token,
        });
        var data = jsonDecode(response.body);
        if (data['code'] == 200) {
          familyGetController.donationTypeList.addAll(data['data']);
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
