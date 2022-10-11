import 'dart:convert';

import 'package:family_app/constant/set_pref.dart';
import 'package:family_app/getx_controller/getx.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../constant/constant.dart';
import '../../constant/profile/profile_page.dart';
import '../../constant/snack_bar.dart';

class MyProfilePage extends StatefulWidget {
  const MyProfilePage({Key? key}) : super(key: key);

  @override
  State<MyProfilePage> createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
  @override
  void initState() {
    super.initState();
    showConnectivity(context).then((value) {
      if (value) {
        familyGetController.profileData.clear();
        getProfileData();
      }
    });
  }

  FamilyGetController familyGetController = Get.put(FamilyGetController());

  @override
  Widget build(BuildContext context) {
    return ProfilePageUI(
      screenName: 'My Profile',
      map: familyGetController.profileData,
      switchData: familyGetController.profileOnOff,
      showEditBtn: true,
    );
  }

  Future<void> getProfileData() async {
    try {
      getStringPref('token').then((token) async {
        final response = await http.get(
          Uri.parse("$apiUrl/profile"),
          headers: {'Authorization': token},
        );
        var data = jsonDecode(response.body);
        if (data['code'] == 200) {
          familyGetController.profileData.addAll(data['data']);
        } else {
          snackBar(context, "Something went wrong", Colors.red);
        }
      });
    } catch (e) {
      snackBar(context, "Something went wrong", Colors.red);
    }
  }
}
