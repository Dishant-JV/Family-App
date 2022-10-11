import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:family_app/constant/constant.dart';
import 'package:family_app/constant/dialog.dart';
import 'package:family_app/constant/set_pref.dart';
import 'package:family_app/getx_controller/getx.dart';
import 'package:family_app/screen/login/login_screen.dart';
import 'package:family_app/screen/show_image/show_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;
import '../business/business_screen.dart';
import '../committee/committee_screen.dart';
import '../detail_search/detail_search.dart';
import '../donor/donor_screen.dart';
import '../event/event_screen.dart';
import '../my_family/family_list.dart';
import '../profile/my_profile_page.dart';
import '../search_member/search_member_screen.dart';
import 'home_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  FamilyGetController familyGetController = Get.put(FamilyGetController());


  @override
  void initState() {
    super.initState();
    showConnectivity(context).then((value) {
      if (value) {
        familyGetController.imageList.clear();
        loadImage();
      }
    });
    // Future.delayed(Duration.zero, () {
    //   showDialog(
    //       context: context,
    //       builder: (BuildContext context) => advertiseDialog(context));
    // });
  }

  int _current = 0;
  final List<String> imgList = [
    'https://thumbs.gfycat.com/CriminalWhichEasteuropeanshepherd-size_restricted.gif',
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
                InkWell(
                  onTap: () async {
                    ExitDialog(context);
                  },
                  child: Icon(
                    Icons.logout,
                    size: 30,
                    color: primaryColor.withOpacity(0.7),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Obx(() => CarouselSlider.builder(
                  itemCount: familyGetController.imageList.isNotEmpty
                      ? familyGetController.imageList.length
                      : imgList.length,
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
                            context,
                            ShowImageScreen(
                                imageUrl:
                                    familyGetController.imageList.isNotEmpty
                                        ? familyGetController.imageList[index]
                                        : imgList[index]));
                      },
                      child: Container(
                        width:double.infinity,
                        child: CachedNetworkImage(
                          imageUrl: familyGetController.imageList.isNotEmpty
                              ? familyGetController.imageList[index]
                              : imgList[index],
                          fit: BoxFit.cover,
                          errorWidget: (context, url, error) => Icon(Icons.error_outline_outlined,size: 40,color: primaryColor,),
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
                )),
            Obx(() => Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: familyGetController.imageList
                      .asMap()
                      .entries
                      .map((entry) {
                    return Container(
                      width: 8.0,
                      height: 8.0,
                      margin:
                          EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _current == entry.key
                              ? primaryColor.withOpacity(0.8)
                              : Colors.grey.withOpacity(0.8)),
                    );
                  }).toList(),
                )),
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

  Future<void> loadImage() async {
    getStringPref('token').then((token) async {
      final response = await http.get(Uri.parse('$apiUrl/viewBannerList'),headers: {'Authorization': token});
      var data = jsonDecode(response.body);
      if (data['code'] == 200) {
        List lst = data['data'];
        lst.forEach((e) {
          familyGetController.imageList.add("${imageUrl}=${e['imageUrl']}");
        });
      }
    });
  }
}
