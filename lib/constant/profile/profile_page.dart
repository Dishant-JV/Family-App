import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../getx_controller/getx.dart';
import '../../screen/profile/edit_my_profile_page.dart';
import '../constant.dart';
import '../switch.dart';

class ProfilePageUI extends StatelessWidget {
  final String screenName;
  final RxBool switchData;
  final Map map;
  final bool showEditBtn;

  ProfilePageUI(
      {Key? key,
      required this.screenName,
      required this.switchData,
      required this.map,
      required this.showEditBtn})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          body: map.isNotEmpty
              ? SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      allScreenStatusBarPadding(context),
                      Row(
                        children: [
                          Expanded(child: AllPageTitle(text: screenName)),
                          Padding(
                            padding: EdgeInsets.only(right: 15),
                            child: engGujSwitch(switchData),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Column(
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: profilePhotoContainer(45),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              FaIcon(
                                FontAwesomeIcons.idCard,
                                size: 15,
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Text(
                                map['memberId'].toString(),
                                style: TextStyle(fontWeight: FontWeight.w500),
                              )
                            ],
                          ),
                          showEditBtn == true
                              ? FittedBox(
                                  child: InkWell(
                                    onTap: () {
                                      pushMethod(context, EditMyProfilePage());
                                    },
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(
                                              left: 10, top: 5, bottom: 5),
                                          decoration: BoxDecoration(
                                              color: Colors.blue,
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                "Edit Profile",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                              Icon(
                                                Icons.navigate_next,
                                                color: Colors.white,
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              : Container(),
                          SizedBox(
                            height: 15,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Column(
                              children: [
                                profilePageRow(
                                    Icons.person,
                                    27,
                                    switchData == true
                                        ? "${map['titleData']['gujTitle']} ${map['gujFirstName']} ${map['gujMiddleName']} ${map['gujLastName']}"
                                        : "${map['titleData']['engTitle']} ${map['engFirstName']} ${map['engMiddleName']} ${map['engLastName']}",
                                    5,
                                    5),
                                SizedBox(
                                  height: 15,
                                ),
                                profilePageRow(
                                    Icons.date_range,
                                    26,
                                    DateFormat('dd/MM/yyyy').format(
                                        DateTime.parse(map['dob']
                                            .toString()
                                            .substring(0, 10))),
                                    10,
                                    5),
                                SizedBox(
                                  height: 15,
                                ),
                                profilePageRow(
                                    Icons.phone,
                                    25,
                                    "${map['primaryContact']} / ${map['alternateContact']}",
                                    10,
                                    3),
                                SizedBox(
                                  height: 15,
                                ),
                                profilePageRow(
                                    Icons.email, 25, map['email'], 10, 2),
                                SizedBox(
                                  height: 15,
                                ),
                                profilePageRow(
                                    FontAwesomeIcons.graduationCap,
                                    22,
                                    "${map['educationData']['courseData']['courseName']} [ ${map['educationData']['standardData']['standardName']} (${map['educationData']['standardData']['standardType']})  ] ",
                                    7,
                                    3),
                                SizedBox(
                                  height: 15,
                                ),
                                profilePageRow(
                                    Icons.bloodtype,
                                    26,
                                    "${map['bloodGroup']} , ${map['engGender']}",
                                    10,
                                    1),
                                SizedBox(
                                  height: 15,
                                ),
                                profilePageRow(
                                    FontAwesomeIcons.ring,
                                    25,
                                    switchData.value == true
                                        ? map['gujMaritalStatus']
                                        : map['engMaritalStatus'],
                                    10,
                                    5),
                                SizedBox(
                                  height: 15,
                                ),
                                profilePageRow(
                                    Icons.home,
                                    26,
                                    switchData.value == true
                                        ? "${map['memberAddress']['gujAddress']} , ${map['memberAddress']['gujArea']} , ${map['memberAddress']['gujCity']}"
                                        : "${map['memberAddress']['engAddress']} , ${map['memberAddress']['engArea']} , ${map['memberAddress']['engCity']}",
                                    10,
                                    5),
                                SizedBox(
                                  height: 15,
                                ),
                                profilePageRow(
                                    Icons.home_work,
                                    25.5,
                                    switchData.value == true
                                        ? "${map['villageData']['gujVillageName']} , ${map['talukaData']['gujTalukaName']} , ${map['districtData']['gujDistrictName']}"
                                        : "${map['villageData']['engVillageName']} , ${map['talukaData']['engTalukaName']} , ${map['districtData']['engDistrictName']}",
                                    10,
                                    5)
                              ],
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                )
              : Center(
                  child: circularProgress(),
                ),
        ));
  }
}

Widget profilePageRow(
    IconData icon, double iconSize, String name, double sizeBox, double pad) {
  return Container(
    padding: EdgeInsets.only(bottom: 15),
    decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey, width: 0.5))),
    child: Row(
      children: [
        FaIcon(
          icon,
          size: iconSize,
          color: Colors.black.withOpacity(0.75),
        ),
        SizedBox(
          width: sizeBox,
        ),
        Expanded(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: EdgeInsets.only(top: pad),
              child: Text(
                name,
                style: TextStyle(
                    color: Colors.black.withOpacity(0.75),
                    fontSize: 18,
                    fontWeight: FontWeight.w400),
              ),
            ),
          ),
        )
      ],
    ),
  );
}
