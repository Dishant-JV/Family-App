import 'package:flutter/material.dart';

import '../../constant/constant.dart';
import '../profile/my_profile_page.dart';
import 'detail_search_member_screen.dart';

class SurnameScreen extends StatefulWidget {
  const SurnameScreen({Key? key}) : super(key: key);

  @override
  State<SurnameScreen> createState() => _SurnameScreenState();
}

class _SurnameScreenState extends State<SurnameScreen> {
  List surnameList = [
    "Dudhat",
    "Vaghasiya",
    "Vekariya",
    "Savani",
    "Koladiya",
    "Paladiya",
    "Sorathiya",
    "Gadhiya",
    "Katrodiya",
    "Gondaliya",
    "Ramani",
    "Bhimani"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          allScreenStatusBarPadding(context),
          AllPageTitle(
            text: "Surname",
          ),
          Expanded(
              child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  physics: BouncingScrollPhysics(),
                  itemCount: surnameList.length,
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        pushMethod(context, DetailSearchMemberScreen());
                      },
                      child: Container(
                        margin: EdgeInsets.only(bottom: 10),
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        alignment: Alignment.centerLeft,
                        height: 50,
                        decoration: containerDecoration,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              surnameList[index],
                              style: searchCardTextStyle,
                            ),
                            forwardIcon
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
