import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:family_app/getx_controller/getx.dart';
import 'package:family_app/screen/search_member/search_member_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../constant/constant.dart';

class FilterDialogScreen extends StatefulWidget {
  const FilterDialogScreen({Key? key}) : super(key: key);

  @override
  State<FilterDialogScreen> createState() => _FilterDialogScreenState();
}

class _FilterDialogScreenState extends State<FilterDialogScreen> {
  FamilyGetController familyGetController = Get.put(FamilyGetController());

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Apply Filter",
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                    color: primaryColor),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "District :",
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                  ),
                  dropDown(familyGetController.distList,
                      familyGetController.selectedDist, "Select District")
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Taluka :",
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                  ),
                  dropDown(familyGetController.talukaList,
                      familyGetController.selectedTaluka, "Select Taluka")
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Village :",
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                  ),
                  dropDown(familyGetController.villageList,
                      familyGetController.selectedVillage, "Select Village")
                ],
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () {
                  if (familyGetController.selectedVillage.isNotEmpty ||
                      familyGetController.selectedDist.isNotEmpty ||
                      familyGetController.selectedTaluka.isNotEmpty) {
                    showConnectivity(context).then((value) {
                      if (value) {
                        Navigator.pop(context);
                        search_member_dialog_open_time++;
                        pushMethod(context, SearchMemberScreen(pushFromOuterScreen: false,));
                      } else {
                        showToast("Check Internet");
                      }
                    });
                  } else {
                    showToast("Select name");
                  }
                },
                child: Text("Filter"),
                style: ElevatedButton.styleFrom(primary: primaryColor),
              )
            ],
          ),
        ),
      ),
    );
  }

  dropDown(List<dynamic> lst, RxString string, String hint) {
    return Obx(() => Container(
          decoration: BoxDecoration(
              border: Border.all(color: Color(0xff5D92C1).withOpacity(0.08)),
              borderRadius: BorderRadius.circular(10)),
          height: 48,
          width: getScreenWidth(
            context,
            0.5,
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton2(
              buttonDecoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(10)),
              dropdownDecoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(10)),
              hint: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  hint,
                  style: TextStyle(color: Color(0xff5D92C1).withOpacity(0.8)),
                ),
              ),
              items: lst
                  .map((item) => DropdownMenuItem<String>(
                        value:
                            familyGetController.searchMemberOnOff.value == false
                                ? item['engName']
                                : item['gujName'],
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: Text(
                            familyGetController.searchMemberOnOff.value == false
                                ? item['engName']
                                : item['gujName'],
                          ),
                        ),
                      ))
                  .toList(),
              value: string.isNotEmpty ? string.value : null,
              onChanged: (value) {
                string.value = value as String;
              },
              buttonHeight: 40,
              itemHeight: 40,
            ),
          ),
        ));
  }
}
