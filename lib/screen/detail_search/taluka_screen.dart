import 'package:flutter/material.dart';

import '../../constant/constant.dart';
import '../profile/edit_my_profile_page.dart';
import 'detail_search_member_screen.dart';

class TalukaScreen extends StatefulWidget {
  const TalukaScreen({Key? key}) : super(key: key);

  @override
  State<TalukaScreen> createState() => _TalukaScreenState();
}

class _TalukaScreenState extends State<TalukaScreen> {
  List talukaList = [
    "Kunkavav",
    "Vadia",
    "Babra",
    "Lathi",
    "Lilia",
    "Bagasara",
    "Dhari",
    "Savar Kundla",
    "Khambha",
    "Jafrabad",
    "Rajula"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          allScreenStatusBarPadding(context),
          AllPageTitle(
            text: "Taluka",
          ),
          Expanded(
              child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  physics: BouncingScrollPhysics(),
                  itemCount: talukaList.length,
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
                              talukaList[index],
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
