import 'dart:io';

import 'package:family_app/screen/profile/edit_my_profile_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:url_launcher/url_launcher.dart';

import 'constant.dart';

class MemberContainer extends StatelessWidget {
  final List<dynamic> lst;
  final int index;
  final RxBool switchData;
  final bool commiteeScreen;

  const MemberContainer(
      {Key? key,
      required this.lst,
      required this.index,
      required this.switchData,
      required this.commiteeScreen})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => Container(
          padding: EdgeInsets.only(top: 20, bottom: 10),
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(
                      color: Colors.grey.shade600.withOpacity(0.3),
                      width: 1.2))),
          child: Row(
            children: [
              profilePhotoContainer(
                  commiteeScreen == true
                      ? lst[index]['memberData']['avatar']
                      : lst[index]['avatar'],height: 60,width: 60),
              SizedBox(
                width: 10,
              ),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          physics: BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          child: Text(
                            switchData == true
                                ? commiteeScreen == false
                                    ? "${lst[index]['titleData']['gujTitle']} ${lst[index]['gujFirstName']} ${lst[index]['gujMiddleName']} ${lst[index]['gujLastName']} "
                                    : "${lst[index]['titleData']['gujTitle']} ${lst[index]['memberData']['gujFirstName']} ${lst[index]['memberData']['gujMiddleName']} ${lst[index]['memberData']['gujLastName']}"
                                : commiteeScreen == false
                                    ? "${lst[index]['titleData']['engTitle']} ${lst[index]['engFirstName']} ${lst[index]['engMiddleName']} ${lst[index]['engLastName']}"
                                    : "${lst[index]['titleData']['engTitle']} ${lst[index]['memberData']['engFirstName']} ${lst[index]['memberData']['engMiddleName']} ${lst[index]['memberData']['engLastName']}",
                            style: allCardMainTextStyle,
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: primaryColor.withOpacity(0.3)),
                        margin: EdgeInsets.only(left: 10),
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        child: Text(
                          commiteeScreen == false
                              ? lst[index]['memberId'].toString()
                              : lst[index]['memberData']['memberId'].toString(),
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Row(
                    children: [
                      commiteeScreen == false
                          ? Text(
                              "Mo : ${lst[index]['primaryContact'].toString()}",
                              style: allCardSubTextStyle,
                            )
                          : Text(
                              "Mo : ${lst[index]['memberData']['primaryContact'].toString()}",
                              style: allCardSubTextStyle,
                            ),
                      Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: InkWell(
                              onTap: () {
                                openWhatsapp(
                                    commiteeScreen == false
                                        ? lst[index]['primaryContact']
                                        : lst[index]['memberData']
                                            ['primaryContact'],
                                    context);
                              },
                              child: wpIcon)),
                      InkWell(
                        onTap: () {
                          makingPhoneCall(
                              commiteeScreen == false
                                  ? lst[index]['primaryContact']
                                  : lst[index]['memberData']['primaryContact'],
                              context);
                        },
                        child: callContainer(),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  commiteeScreen == false
                      ? Row(
                          children: [
                            locationIcon,
                            Text(
                              switchData.value == true
                                  ? "${lst[index]['villageData']['gujVillageName']} , ${lst[index]['talukaData']['gujTalukaName']} , ${lst[index]['districtData']['gujDistrictName']}"
                                  : "${lst[index]['villageData']['engVillageName']} , ${lst[index]['talukaData']['engTalukaName']} , ${lst[index]['districtData']['engDistrictName']}",
                              style: allCardSubTextStyle,
                            )
                          ],
                        )
                      : Container()
                ],
              ))
            ],
          ),
        ));
  }
}

Future<void> openWhatsapp(String phoneNumber, BuildContext context) async {
  String msg = "Hyyy";
  try {
    if (Platform.isAndroid) {
      await launchUrl(
          Uri.parse("whatsapp://send?phone=+91$phoneNumber+&text=$msg"));
    } else if (Platform.isIOS) {
      await launchUrl(Uri.parse("https://wa.me/+91$phoneNumber+&text=$msg"));
    }
  } catch (e) {
    showSnackBar(context, "Error in Opening Whatsapp");
  }
}

showSnackBar(BuildContext context, String value) {
  var snackBar = SnackBar(
    content: Text(
      value,
      style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
    ),
    backgroundColor: primaryColor,
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

makingPhoneCall(String PhoneNumber, BuildContext context) async {
  final Uri launchUri = Uri(
    scheme: 'tel',
    path: PhoneNumber,
  );
  await launchUrl(launchUri);
}
