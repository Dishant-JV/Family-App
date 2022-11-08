import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;

import '../../constant/constant.dart';
import '../../constant/member_container.dart';
import '../../constant/set_pref.dart';
import '../../constant/snack_bar.dart';
import '../../constant/switch.dart';
import '../../getx_controller/getx.dart';
import '../profile/edit_my_profile_page.dart';
import 'filter_dialog_screen.dart';

class SearchMemberScreen extends StatefulWidget {
  final bool pushFromOuterScreen;

  const SearchMemberScreen({Key? key, required this.pushFromOuterScreen})
      : super(key: key);

  @override
  State<SearchMemberScreen> createState() => _SearchMemberScreenState();
}

class _SearchMemberScreenState extends State<SearchMemberScreen> {
  FamilyGetController familyGetController = Get.put(FamilyGetController());
  bool loading = true;

  @override
  void initState() {
    super.initState();
    showConnectivity(context).then((value) {
      if (value) {
        familyGetController.searchMemberList.clear();
        if (widget.pushFromOuterScreen == true) {
          search_member_dialog_open_time=0;
          familyGetController.selectedDist.value = "";
          familyGetController.selectedTaluka.value = "";
          familyGetController.selectedVillage.value = "";
          clearList();
        } else {
          clearList();
        }
        getFamilyData('');
        getDistVillageList();
      }
    });
  }
  clearList(){
    familyGetController.distList.clear();
    familyGetController.talukaList.clear();
    familyGetController.villageList.clear();
  }

  TextEditingController searchController = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()=>popFunciton(),
      child: Scaffold(
        body: Column(
          children: [
            allScreenStatusBarPadding(context),
            Row(
              children: [
                Expanded(
                    child: allPageTitleRow(
                        "Search Member", familyGetController.searchMemberOnOff)),
                Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: InkWell(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (_) => FilterDialogScreen());
                      },
                      child: Icon(
                        Icons.filter_alt_sharp,
                        size: 28,
                      )),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: TextFormField(
                  controller: searchController,
                  onChanged: (val) {
                    setState(() {
                      familyGetController.searchMemberList.clear();
                      loading = true;
                      getFamilyData(val);
                    });
                  },
                  decoration: InputDecoration(
                      isDense: true,
                      hintText: "Search Member",
                      hintStyle:
                          TextStyle(color: Color(0xff5D92C1).withOpacity(0.8)),
                      filled: true,
                      fillColor: Colors.grey.shade100.withOpacity(0.5),
                      errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.red.shade300)),
                      errorStyle:
                          TextStyle(color: Colors.red.shade300, fontSize: 12),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color(0xff5D92C1).withOpacity(0.05)),
                          borderRadius: BorderRadius.circular(10)),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color(0xff5D92C1).withOpacity(0.05)),
                          borderRadius: BorderRadius.circular(10)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color(0xff5D92C1).withOpacity(0.8)),
                          borderRadius: BorderRadius.circular(10))),
                )),
            SizedBox(
              height: 10,
            ),
            Obx(() => Expanded(
                  child: familyGetController.searchMemberList.isNotEmpty
                      ? ListView.builder(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          physics: BouncingScrollPhysics(),
                          itemCount: familyGetController.searchMemberList.length,
                          itemBuilder: (context, index) {
                            return MemberContainer(
                              index: index,
                              lst: familyGetController.searchMemberList,
                              switchData: familyGetController.searchMemberOnOff,
                              commiteeScreen: false,
                            );
                          })
                      : loading == true
                          ? Center(
                              child: circularProgress(),
                            )
                          : centerNoRecordText(),
                ))
          ],
        ),
      ),
    );
  }

  void getFamilyData(String searchBy) {
    try {
      Map<String, dynamic> params = {'searchBy': searchBy};
      getStringPref('token').then((token) async {
        if (familyGetController.selectedDist.isNotEmpty) {
          params['district'] = familyGetController.selectedDist.value;
        }
        if (familyGetController.selectedTaluka.isNotEmpty) {
          params['taluka'] = familyGetController.selectedTaluka.value;
        }
        if (familyGetController.selectedVillage.isNotEmpty) {
          params['village'] = familyGetController.selectedVillage.value;
        }
        print(params);
        Uri uri = Uri.parse("$apiUrl/viewMainMemberList");
        final finalUri = uri.replace(queryParameters: params);
        final response = await http.get(finalUri, headers: {
          'Authorization': token,
        });
        var data = jsonDecode(response.body);
        if (data['code'] == 200) {
          familyGetController.searchMemberList.addAll(data['data']);
        }
        setState(() {
          loading = false;
        });
      });
    } catch (e) {
      snackBar(context, "Something went wrong", Colors.red);
    }
  }

  void getDistVillageList() {
    getStringPref('token').then((token) async {
      final responseDist =
          await http.get(Uri.parse("$apiUrl/viewDistrictList"), headers: {
        'Authorization': token,
      });
      final responseTaluka =
          await http.get(Uri.parse("$apiUrl/viewTalukaList"), headers: {
        'Authorization': token,
      });
      final responseVillage =
          await http.get(Uri.parse("$apiUrl/viewVillageList"), headers: {
        'Authorization': token,
      });
      var dataVillage = jsonDecode(responseVillage.body);
      if (dataVillage['code'] == 200) {
        familyGetController.villageList.addAll(dataVillage['data']);
      }

      var dataDist = jsonDecode(responseDist.body);
      if (dataDist['code'] == 200) {
        familyGetController.distList.addAll(dataDist['data']);
      }
      var dataTaluka = jsonDecode(responseTaluka.body);
      if (dataTaluka['code'] == 200) {
        familyGetController.talukaList.addAll(dataTaluka['data']);
      }
    });
  }

  popFunciton() {
    for(int i=0;i<=search_member_dialog_open_time;i++)
      Navigator.pop(context);
  }
}
