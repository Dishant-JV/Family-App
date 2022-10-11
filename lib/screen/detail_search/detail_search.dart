import 'package:family_app/screen/detail_search/surname_screen.dart';
import 'package:family_app/screen/detail_search/taluka_screen.dart';
import 'package:family_app/screen/detail_search/village_screen.dart';
import 'package:flutter/material.dart';

import '../../constant/constant.dart';
import '../profile/edit_my_profile_page.dart';
import 'district_screen.dart';

class DetailSearchScreen extends StatefulWidget {
  const DetailSearchScreen({Key? key}) : super(key: key);

  @override
  State<DetailSearchScreen> createState() => _DetailSearchScreenState();
}

class _DetailSearchScreenState extends State<DetailSearchScreen> {
  List<String> searchMenu = ["District", "Taluka", "Village", "Surname"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          allScreenStatusBarPadding(context),
          AllPageTitle(
            text: "Detail Search",
          ),
          ListView.builder(
              itemCount: searchMenu.length,
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    if (index == 0) {
                      pushMethod(context, DistrictScreen());
                    } else if (index == 1) {
                      pushMethod(context, TalukaScreen());
                    } else if (index == 2) {
                      pushMethod(context, VillageScreen());
                    } else if (index == 3) {
                      pushMethod(context, SurnameScreen());
                    }
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
                          searchMenu[index],
                          style: searchCardTextStyle,
                        ),
                        forwardIcon
                      ],
                    ),
                  ),
                );
              })
        ],
      ),
    );
  }
}
