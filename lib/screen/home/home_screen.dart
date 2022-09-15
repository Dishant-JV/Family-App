import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:family_app/constant/constant.dart';
import 'package:family_app/screen/profile/my_profile_page.dart';
import 'package:family_app/screen/show_image/show_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../business/business_screen.dart';
import '../committee/committee_screen.dart';
import '../detail_search/detail_search.dart';
import '../donor/donor_screen.dart';
import '../event/event_screen.dart';
import '../my_family/family_list.dart';
import '../search_member/search_member_screen.dart';
import 'home_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      showDialog(
          context: context,
          builder: (BuildContext context) => advertiseDialog(context));
    });
  }

  int _current = 0;
  final List<String> imgList = [
    'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
    'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
    'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
    'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
  ];
  List<HomeMenuModel> menuList = [
    HomeMenuModel(menuName: "My Profile", menuIcon: Icons.person),
    HomeMenuModel(menuName: "My Family", menuIcon: Icons.family_restroom),
    HomeMenuModel(
        menuName: "Search Member", menuIcon: Icons.person_search_sharp),
    HomeMenuModel(
        menuName: "Committee ", menuIcon: FontAwesomeIcons.codeCommit),
    HomeMenuModel(menuName: "Event", menuIcon: Icons.event),
    HomeMenuModel(
        menuName: "Donor", menuIcon: FontAwesomeIcons.circleDollarToSlot),
    HomeMenuModel(menuName: "Business", menuIcon: Icons.add_business),
    HomeMenuModel(menuName: "Result", menuIcon: Icons.add_card),
    HomeMenuModel(menuName: "Feedback", menuIcon: Icons.feedback),
    HomeMenuModel(
        menuName: "Detail Search", menuIcon: Icons.manage_search_sharp),
    HomeMenuModel(menuName: "Gallery", menuIcon: FontAwesomeIcons.photoFilm),
    HomeMenuModel(menuName: "Main Menu", menuIcon: Icons.menu_open_rounded),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            allScreenStatusBarPadding(context),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Icon(
                  Icons.compass_calibration,
                  size: 30,
                  color: primaryColor.withOpacity(0.7),
                ),
                Expanded(
                  child: Text(
                    familyName,
                    style: familyTextStyle,
                    textAlign: TextAlign.center,
                  ),
                ),
                Icon(
                  Icons.settings,
                  size: 30,
                  color: primaryColor.withOpacity(0.7),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            CarouselSlider.builder(
              itemCount: imgList.length,
              options: CarouselOptions(
                  autoPlay: true,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _current = index;
                    });
                  },
                  height: 170,
                  enlargeCenterPage: true,
                  viewportFraction: 1,
                  scrollPhysics: BouncingScrollPhysics()),
              itemBuilder: (context, index, realIdx) {
                return InkWell(
                  onTap: () {
                    pushMethod(
                        context, ShowImageScreen(imageUrl: imgList[index]));
                  },
                  child: Container(
                    width: double.infinity,
                    child: CachedNetworkImage(
                      imageUrl: imgList[index],
                      fit: BoxFit.cover,
                      progressIndicatorBuilder:
                          (context, url, downloadProgress) => Center(
                        child: CircularProgressIndicator(
                          color: primaryColor,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: imgList.asMap().entries.map((entry) {
                return Container(
                  width: 8.0,
                  height: 8.0,
                  margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _current == entry.key
                          ? primaryColor.withOpacity(0.8)
                          : Colors.grey.withOpacity(0.8)),
                );
              }).toList(),
            ),
            SizedBox(
              height: 15,
            ),
            Expanded(
              child: GridView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemCount: menuList.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10),
                itemBuilder: (context, index) {
                  HomeMenuModel menu = menuList[index];
                  return InkWell(
                    onTap: () {
                      if (index == 0) {
                        pushMethod(context, MyProfilePage());
                      } else if (index == 1) {
                        pushMethod(context, FamilyListScreen());
                      } else if (index == 2) {
                        pushMethod(context, SearchMemberScreen());
                      } else if (index == 3) {
                        pushMethod(context, CommmitteeScreen());
                      } else if (index == 4) {
                        pushMethod(context, EventScreen());
                      } else if (index == 5) {
                        pushMethod(context, DonorScreen());
                      } else if (index == 6) {
                        pushMethod(context, BusinessScreen());
                      } else if (index == 9) {
                        pushMethod(context, DetailSearchScreen());
                      }
                    },
                    child: Container(
                      decoration: containerDecoration,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            menu.menuIcon,
                            color: primaryColor,
                            size: 35,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          FittedBox(
                              child: Text(
                            menu.menuName.toString(),
                            style: TextStyle(
                                color: primaryColor,
                                fontWeight: FontWeight.w500),
                          ))
                        ],
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
