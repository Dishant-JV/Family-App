import 'package:family_app/getx_controller/getx.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:textfield_tags/textfield_tags.dart';

import '../../constant/constant.dart';
import '../profile/edit_my_profile_page.dart';

class FamilyFormScreen extends StatefulWidget {
  const FamilyFormScreen({Key? key}) : super(key: key);

  @override
  State<FamilyFormScreen> createState() => _FamilyFormScreenState();
}

class _FamilyFormScreenState extends State<FamilyFormScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController middleNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController primaryMobileController = TextEditingController();
  TextEditingController secondMobileController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  String? selectedParentValue;
  String? castSelection;
  String birthDate = "";
  TextfieldTagsController? _controller = TextfieldTagsController();
  FamilyGetController familyGetController = Get.put(FamilyGetController());
  static const List<String> educationList = <String>[
    "BBA",
    "BCA",
    "B COM",
    "MBA",
    "MCA",
    "M COM"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        reverse: true,
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            allScreenStatusBarPadding(context),
            AllPageTitle(
              text: "My Family",
            ),
            // Padding(
            //   padding: EdgeInsets.symmetric(vertical: 10),
            //   child: profilePhotoContainer(45),
            // ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Member Id  ",
                        style: profilePageSubTextStyle,
                      ),
                      Container(
                        width: getScreenWidth(context, 0.55),
                        child: Row(
                          children: [
                            Container(
                              alignment: Alignment.center,
                              height: 30,
                              width: getScreenWidth(context, 0.2),
                              decoration: BoxDecoration(
                                  color: primaryColor.withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                      color: primaryColor.withOpacity(0.5),
                                      width: 0.5)),
                              child: Text(
                                "1024",
                                style: TextStyle(
                                    color: primaryColor.withOpacity(0.8),
                                    fontSize: 17,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Parent Name  ",
                        style: profilePageSubTextStyle,
                      ),
                      Container(
                        height: 45,
                        width: getScreenWidth(context, 0.55),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                                color: primaryColor.withOpacity(0.8))),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            items: <String>[
                              'Ramji Bhai',
                              'Keshav Bhai',
                              'Ramesh Bhai'
                            ].map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Text(value),
                                ),
                              );
                            }).toList(),
                            value: selectedParentValue,
                            onChanged: (val) {
                              selectedParentValue = val ;
                              setState(() {});
                            },
                            style: textFieldTextStyle,
                            icon: Icon(
                              Icons.arrow_drop_down_outlined,
                              color: primaryColor,
                            ),
                            hint: Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: Text(
                                  "Select Parent Name",
                                  style: hintTextStyle,
                                )),
                          ),
                        ),
                      ),
                    ],
                  ),
                  ProfilePageTextField(
                    controller: nameController,
                    hintText: 'Enter Name',
                    textInputType: TextInputType.text,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  ProfilePageTextField(
                    controller: middleNameController,
                    hintText: 'Enter Middle Name',
                    textInputType: TextInputType.text,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  ProfilePageTextField(
                    controller: lastNameController,
                    hintText: 'Enter Last Name',
                    textInputType: TextInputType.text,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "BirthDate   ",
                        style: profilePageSubTextStyle,
                      ),
                      Container(
                        width: getScreenWidth(context, 0.63),
                        child: InkWell(
                          onTap: () {
                            pickedDate(context).then((value) {
                              birthDate =
                                  DateFormat('dd/MM/yyyy').format(value!);
                              setState(() {});
                            });
                          },
                          child: Container(
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                    color: primaryColor.withOpacity(0.8))),
                            height: 45,
                            width: getScreenWidth(context, 0.5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  birthDate.toString() ,
                                  style: TextStyle(
                                      color: Colors.grey.shade600,
                                      fontWeight: FontWeight.w700),
                                ),
                                Icon(
                                  Icons.calendar_month,
                                  color: primaryColor,
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Mobile1",
                        style: profilePageSubTextStyle,
                      ),
                      Container(
                        width: getScreenWidth(context, 0.63),
                        child: ProfilePageTextField(
                          controller: primaryMobileController,
                          hintText: 'Enter Primary Number',
                          textInputType: TextInputType.number,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Mobile2",
                        style: profilePageSubTextStyle,
                      ),
                      Container(
                        width: getScreenWidth(context, 0.63),
                        child: ProfilePageTextField(
                          controller: secondMobileController,
                          hintText: 'Enter Second Number',
                          textInputType: TextInputType.number,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  ProfilePageTextField(
                    controller: emailController,
                    hintText: 'Enter Your E-mail',
                    textInputType: TextInputType.text,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Education",
                    style: profilePageSubTextStyle,
                  ),
                  tagedEducationTextfield(_controller!, educationList),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Blood Group",
                    style: profilePageSubTextStyle,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  bloodGroupDropDown(
                      familyGetController.familySelectedBloodGroupValue),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Gender",
                        style: profilePageSubTextStyle,
                      ),
                      Container(
                        width: getScreenWidth(context, 0.63),
                        child: Row(
                          children: [
                            Row(
                              children: [
                                Radio(
                                    activeColor: primaryColor,
                                    value: "Male",
                                    groupValue: castSelection,
                                    onChanged: (value) {
                                      setState(() {
                                        castSelection = value.toString();
                                      });
                                    }),
                                Text(
                                  "Male",
                                  style: profilePageSubTextStyle,
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Radio(
                                    activeColor: primaryColor,
                                    value: "Female",
                                    groupValue: castSelection,
                                    onChanged: (value) {
                                      setState(() {
                                        castSelection = value.toString();
                                      });
                                    }),
                                Text(
                                  "Female",
                                  style: profilePageSubTextStyle,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
            Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom + 10))
          ],
        ),
      ),
    );
  }
}
