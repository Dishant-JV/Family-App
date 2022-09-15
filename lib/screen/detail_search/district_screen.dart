import 'package:flutter/material.dart';

import '../../constant/constant.dart';
import '../profile/my_profile_page.dart';
import 'detail_search_member_screen.dart';

class DistrictScreen extends StatefulWidget {
  const DistrictScreen({Key? key}) : super(key: key);

  @override
  State<DistrictScreen> createState() => _CityScreenState();
}

class _CityScreenState extends State<DistrictScreen> {
  List districtList = [
    "Amreli",
    "Bhavnagar",
    "Junagadh",
    "Jamnagar",
    "Rajkot",
    "Bhuj",
    "Mahesana",
    "Porbandar",
    "Morbi",
    "Gir-Somnath",
    "Devbhoomi Dwarka"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          allScreenStatusBarPadding(context),
          AllPageTitle(
            text: "District",
          ),
          Expanded(
              child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  physics: BouncingScrollPhysics(),
                  itemCount: districtList.length,
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        pushMethod(context, DetailSearchMemberScreen());
                      },
                      child: Container(
                        margin: EdgeInsets.only(bottom: 10),
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        alignment: Alignment.centerLeft,
                        decoration: containerDecoration,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              districtList[index],
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
                                      Text(
                                        "District - ",
                                        style: TextStyle(
                                            color:
                                                primaryColor.withOpacity(0.8),
                                            fontWeight: FontWeight.w500,
                                            fontSize: 15),
                                      ),
                                      Text(
                                        "20",
                                        style: cityTextStyle,
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 15,
                                      ),
                                      Text(
                                        "Village - ",
                                        style: TextStyle(
                                            color:
                                            primaryColor.withOpacity(0.8),
                                            fontWeight: FontWeight.w500,
                                            fontSize: 15),
                                      ),
                                      Text(
                                        "46",
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
