import 'package:flutter/material.dart';

import '../../constant/constant.dart';
import '../profile/my_profile_page.dart';
import 'detail_search_member_screen.dart';

class VillageScreen extends StatefulWidget {
  const VillageScreen({Key? key}) : super(key: key);

  @override
  State<VillageScreen> createState() => _VillageScreenState();
}

class _VillageScreenState extends State<VillageScreen> {
  List villageList = [
    "Amrapur",
    "Vaghaniya",
    "Chital",
    "Jaliya",
    "Janjariya",
    "Kathma",
    "Monpur",
    "Paniya",
    "Timba",
    "Hadala",
    "Kunkavav",
    "Vaghaniya"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          allScreenStatusBarPadding(context),
          AllPageTitle(
            text: "Village",
          ),
          Expanded(
              child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  physics: BouncingScrollPhysics(),
                  itemCount: villageList.length,
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        pushMethod(context, DetailSearchMemberScreen());
                      },
                      child: Container(
                        margin: EdgeInsets.only(bottom: 10),
                        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                        alignment: Alignment.centerLeft,
                        decoration: containerDecoration,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              villageList[index],
                              style: searchCardTextStyle,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            SingleChildScrollView(
                              physics: BouncingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.location_on,
                                        size: 20,
                                        color: primaryColor.withOpacity(0.8),
                                      ),
                                      Text(
                                        " Amreli",
                                        style: cityTextStyle,
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 15,
                                      ),
                                      Icon(
                                        Icons.location_city,
                                        size: 20,
                                        color: primaryColor.withOpacity(0.8),
                                      ),
                                      Text(
                                        " Bagasara",
                                        style: cityTextStyle,
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 15,
                                      ),
                                      Icon(
                                        Icons.home,
                                        size: 20,
                                        color: primaryColor.withOpacity(0.8),
                                      ),
                                      Text(" 20", style: cityTextStyle)
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 15,
                                      ),
                                      Icon(
                                        Icons.person,
                                        size: 20,
                                        color: primaryColor.withOpacity(0.8),
                                      ),
                                      Text(
                                        " 145",
                                        style: cityTextStyle,
                                      )
                                    ],
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  }))
        ],
      ),
    );
  }
}
