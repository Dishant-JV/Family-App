import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
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

class BusinessDetailList extends StatefulWidget {
  final int businessTypeId;

  const BusinessDetailList({Key? key, required this.businessTypeId})
      : super(key: key);

  @override
  State<BusinessDetailList> createState() => _BusinessDetailListState();
}

class _BusinessDetailListState extends State<BusinessDetailList> {
  FamilyGetController familyGetController = Get.put(FamilyGetController());

  @override
  void initState() {
    super.initState();
    showConnectivity(context).then((value) {
      if (value) {
        familyGetController.businessDetailList.clear();
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
          allPageTitleRow("Business List", familyGetController.businessDetailOnOff),
          Obx(() => Expanded(
              child: familyGetController.businessDetailList.isNotEmpty
                  ? ListView.builder(
                      scrollDirection: Axis.vertical,
                      physics: BouncingScrollPhysics(),
                      itemCount: familyGetController.businessDetailList.length,
                      padding: EdgeInsets.symmetric(vertical: 5),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        Map map = familyGetController.businessDetailList[index];
                        return Obx(() => Container(
                              padding: EdgeInsets.all(10),
                              margin: EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6.0),
                                border: Border.all(
                                    color: primaryColor.withOpacity(0.1),
                                    width: 0.2),
                                color: index % 2 == 0
                                    ? Color(0xff605B83).withOpacity(0.5)
                                    : Color(0xffC9C4A3),
                              ),
                              child: Row(
                                children: [
                                  //
                                  profilePhotoContainer("${imageUrl}=${map['logo']}",height: 70,width: 70),
                                  // Container(
                                  //   width: 70.0,
                                  //   height: 70.0,
                                  //   decoration: new BoxDecoration(
                                  //     shape: BoxShape.circle,
                                  //     border: Border.all(
                                  //         color: primaryColor.withOpacity(0.7),
                                  //         width: 2),
                                  //     image: new DecorationImage(
                                  //       fit: BoxFit.fill,
                                  //       image: new CachedNetworkImageProvider(
                                  //           ),
                                  //     ),
                                  //   ),
                                  // ),
                                  // Container(
                                  //   decoration: BoxDecoration(
                                  //       border: Border.all(
                                  //           color:
                                  //               primaryColor.withOpacity(0.7),
                                  //           width: 2),
                                  //       shape: BoxShape.circle),
                                  //   child: CircleAvatar(
                                  //     radius: 35,
                                  //     child: CachedNetworkImage(
                                  //       imageUrl: "${imageUrl}=${map['logo']}",
                                  //       fit: BoxFit.cover,
                                  //       errorWidget: (context, url, error) =>
                                  //           Icon(
                                  //         Icons.error_outline_outlined,
                                  //         size: 40,
                                  //         color: primaryColor,
                                  //       ),
                                  //       progressIndicatorBuilder:
                                  //           (context, url, downloadProgress) =>
                                  //               Center(
                                  //         child: CircularProgressIndicator(
                                  //           color: primaryColor,
                                  //         ),
                                  //       ),
                                  //     ),
                                  //   ),
                                  // ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          familyGetController
                                                      .businessDetailOnOff
                                                      .value ==
                                                  false
                                              ? "${map['memberData']['engFirstName']} ${map['memberData']['engMiddleName']} ${map['memberData']['engLastName']}"
                                              : "${map['memberData']['gujFirstName']} ${map['memberData']['gujMiddleName']} ${map['memberData']['gujLastName']}",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            letterSpacing: 0.5,
                                            fontSize: 20,
                                            color: Color(0xff605B83),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          familyGetController
                                                      .businessDetailOnOff
                                                      .value ==
                                                  false
                                              ? map['engName']
                                              : map['gujName'],
                                          style: TextStyle(
                                              color: Color(0xff605B83),
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16),
                                        ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.call,
                                              color: Color(0xff605B83),
                                              size: 18,
                                            ),
                                            Text(
                                              " ${map['memberData']['primaryContact']}",
                                              style: TextStyle(
                                                  color: Color(0xff605B83),
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 15),
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        SingleChildScrollView(
                                          physics: BouncingScrollPhysics(),
                                          scrollDirection: Axis.horizontal,
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.location_on,
                                                color: Color(0xff605B83),
                                                size: 17,
                                              ),
                                              Text(
                                                familyGetController
                                                            .businessDetailOnOff
                                                            .value ==
                                                        false
                                                    ? map['engAddress']
                                                    : map['gujAddress'],
                                                style: TextStyle(
                                                    color: Color(0xff605B83),
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 15),
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ));
                      })
                  : centerNoRecordText()))
        ],
      ),
    );
  }

  void getBusinessData() {
    try {
      getStringPref('token').then((token) async {
        final response = await http.get(
          Uri.parse(
              "$apiUrl/viewBusinessList?businessTypeId= ${widget.businessTypeId}"),
          headers: {'Authorization': token},
        );
        var data = jsonDecode(response.body);
        if (data['code'] == 200) {
          familyGetController.businessDetailList.addAll(data['data']);
        }
      });
    } catch (e) {
      snackBar(context, "Something went wrongs", Colors.red);
    }
  }
}
