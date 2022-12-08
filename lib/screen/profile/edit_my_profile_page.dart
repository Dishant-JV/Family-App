import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:family_app/constant/constant.dart';
import 'package:family_app/getx_controller/getx.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:textfield_tags/textfield_tags.dart';
import 'package:http/http.dart' as http;

import '../../constant/set_pref.dart';
import '../../constant/snack_bar.dart';

class EditMyProfilePage extends StatefulWidget {
  const EditMyProfilePage({Key? key}) : super(key: key);

  @override
  State<EditMyProfilePage> createState() => _EditMyProfilePageState();
}

class _EditMyProfilePageState extends State<EditMyProfilePage> {
  TextEditingController detailController = TextEditingController();
  FamilyGetController familyGetController = Get.find();
  final formKey = GlobalKey<FormState>();
  String? selectedValue;
  List editTypeList = [];

  @override
  void initState() {
    super.initState();
    showConnectivity(context).then((value) {
      if (value) {
        getEditTypeList();
      }
    });
  } // String? selectedBloodGroupValue;
  // String? castSelection;
  // FamilyGetController familyGetController = Get.put(FamilyGetController());
  // List<String> educationList = ["BBA", "BCA", "B COM", "MBA", "MCA", "M COM"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          allScreenStatusBarPadding(context),
          AllPageTitle(
            text: "Edit Profile",
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            padding: EdgeInsets.only(left: 17),
            child: Text(
              "What detail do you want to update..",
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                  color: Colors.black.withOpacity(0.75)),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          InkWell(
            onTap: () {
              if (editTypeList.isEmpty) {
                showToast('Check Internet Connection');
              }
            },
            child: Container(
              margin: EdgeInsets.only(left: 17, right: 17),
              decoration: BoxDecoration(
                  border:
                      Border.all(color: Color(0xff5D92C1).withOpacity(0.08)),
                  borderRadius: BorderRadius.circular(10)),
              height: 48,
              width: getScreenWidth(
                context,
                0.92,
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
                      'Select Type',
                      style:
                          TextStyle(color: Color(0xff5D92C1).withOpacity(0.8)),
                    ),
                  ),
                  items: editTypeList
                      .map((item) => DropdownMenuItem<String>(
                            value: item['name'],
                            child: Padding(
                              padding: const EdgeInsets.only(left: 15),
                              child: Text(
                                item['name'],
                              ),
                            ),
                          ))
                      .toList(),
                  value: selectedValue,
                  onChanged: (value) {
                    setState(() {
                      selectedValue = value as String;
                    });
                  },
                  buttonHeight: 40,
                  itemHeight: 40,
                ),
              ),
            ),
          ),
          Form(
            key: formKey,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              child: textFieldWidget(
                  "Enter Detail",
                  detailController,
                  false,
                  true,
                  Colors.grey.shade100.withOpacity(0.5),
                  TextInputType.text,
                  Color(0xffFB578E).withOpacity(0.3),
                  4,
                  false),
            ),
          ),
          InkWell(
            onTap: () {
              if (formKey.currentState?.validate() == true) {
                if (selectedValue != null) {
                  submitDetail();
                } else {
                  showToast('select edit type');
                }
              }
            },
            child: primaryBtn("Submit", 15),
          )
          // profilePhotoContainer(45),
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 20),
          //   child: Column(
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children: [
          //       ProfilePageTextField(
          //         controller: nameController,
          //         hintText: 'Enter Name',
          //         textInputType: TextInputType.text,
          //       ),
          //       SizedBox(
          //         height: 5,
          //       ),
          //       ProfilePageTextField(
          //         controller: middleNameController,
          //         hintText: 'Enter Middle Name',
          //         textInputType: TextInputType.text,
          //       ),
          //       SizedBox(
          //         height: 5,
          //       ),
          //       ProfilePageTextField(
          //         controller: lastNameController,
          //         hintText: 'Enter Last Name',
          //         textInputType: TextInputType.text,
          //       ),
          //       SizedBox(
          //         height: 10,
          //       ),
          //       Row(
          //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //         children: [
          //           Text(
          //             "BirthDate   ",
          //             style: profilePageSubTextStyle,
          //           ),
          //           Container(
          //             width: getScreenWidth(context, 0.63),
          //             child: InkWell(
          //               onTap: () {
          //                 pickedDate(context).then((value) {
          //                   birthDate =
          //                       DateFormat('dd/MM/yyyy').format(value!);
          //                   setState(() {});
          //                 });
          //               },
          //               child: Container(
          //                 alignment: Alignment.centerLeft,
          //                 padding: EdgeInsets.symmetric(horizontal: 15),
          //                 decoration: BoxDecoration(
          //                     borderRadius: BorderRadius.circular(10),
          //                     border: Border.all(
          //                         color: primaryColor.withOpacity(0.8))),
          //                 height: 45,
          //                 width: getScreenWidth(context, 0.5),
          //                 child: Row(
          //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //                   children: [
          //                     Text(
          //                       birthDate.toString(),
          //                       style: TextStyle(
          //                           color: Colors.grey.shade600,
          //                           fontWeight: FontWeight.w700),
          //                     ),
          //                     Icon(
          //                       Icons.calendar_month,
          //                       color: primaryColor,
          //                     )
          //                   ],
          //                 ),
          //               ),
          //             ),
          //           )
          //         ],
          //       ),
          //       SizedBox(
          //         height: 5,
          //       ),
          //       Row(
          //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //         children: [
          //           Text(
          //             "Mobile1",
          //             style: profilePageSubTextStyle,
          //           ),
          //           Container(
          //             width: getScreenWidth(context, 0.63),
          //             child: ProfilePageTextField(
          //               controller: primaryMobileController,
          //               hintText: 'Enter Primary Number',
          //               textInputType: TextInputType.number,
          //             ),
          //           ),
          //         ],
          //       ),
          //       SizedBox(
          //         height: 5,
          //       ),
          //       Row(
          //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //         children: [
          //           Text(
          //             "Mobile2",
          //             style: profilePageSubTextStyle,
          //           ),
          //           Container(
          //             width: getScreenWidth(context, 0.63),
          //             child: ProfilePageTextField(
          //               controller: secondMobileController,
          //               hintText: 'Enter Second Number',
          //               textInputType: TextInputType.number,
          //             ),
          //           ),
          //         ],
          //       ),
          //       SizedBox(
          //         height: 5,
          //       ),
          //       ProfilePageTextField(
          //         controller: emailController,
          //         hintText: 'Enter Your E-mail',
          //         textInputType: TextInputType.text,
          //       ),
          //       SizedBox(
          //         height: 10,
          //       ),
          //       Text(
          //         "Education",
          //         style: profilePageSubTextStyle,
          //       ),
          //       tagedEducationTextfield(_controller!, educationList),
          //       SizedBox(
          //         height: 10,
          //       ),
          //       Text(
          //         "Blood Group",
          //         style: profilePageSubTextStyle,
          //       ),
          //       SizedBox(
          //         height: 10,
          //       ),
          //       bloodGroupDropDown(
          //           familyGetController.profileSelectedBloodGroupValue),
          //       SizedBox(
          //         height: 10,
          //       ),
          //       Row(
          //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //         children: [
          //           Text(
          //             "Gender",
          //             style: profilePageSubTextStyle,
          //           ),
          //           Container(
          //             width: getScreenWidth(context, 0.63),
          //             child: Row(
          //               children: [
          //                 Row(
          //                   children: [
          //                     Radio(
          //                         activeColor: primaryColor,
          //                         value: "Male",
          //                         groupValue: castSelection,
          //                         onChanged: (value) {
          //                           setState(() {
          //                             castSelection = value.toString();
          //                           });
          //                         }),
          //                     Text(
          //                       "Male",
          //                       style: profilePageSubTextStyle,
          //                     ),
          //                   ],
          //                 ),
          //                 Row(
          //                   children: [
          //                     Radio(
          //                         activeColor: primaryColor,
          //                         value: "Female",
          //                         groupValue: castSelection,
          //                         onChanged: (value) {
          //                           setState(() {
          //                             castSelection = value.toString();
          //                           });
          //                         }),
          //                     Text(
          //                       "Female",
          //                       style: profilePageSubTextStyle,
          //                     ),
          //                   ],
          //                 ),
          //               ],
          //             ),
          //           ),
          //         ],
          //       ),
          //       SizedBox(
          //         height: 10,
          //       ),
          //       saveElevatedButton(context, "Save")
          //     ],
          //   ),
          // ),
          // Padding(
          //     padding: EdgeInsets.only(
          //         bottom: MediaQuery.of(context).viewInsets.bottom + 10))
        ],
      ),
    );
  }

  void submitDetail() {
    showConnectivity(context).then((value) {
      if (value) {
        getStringPref('token').then((token) async {
          editTypeList.forEach((element) async {
            if (element['name'] == selectedValue) {
              print(element['id']);
              print(detailController.text);
              final response = await http.post(Uri.parse("$apiUrl/addRequest"),
                  headers: {
                    'Content-Type': 'application/json',
                    'Authorization': token
                  },
                  body: jsonEncode({
                    "requestTypeId": element['id'],
                    'requestDescription': detailController.text
                  }));
              print(response.body);
              var data = jsonDecode(response.body);
              if (data['code'] == 200) {
                snackBar(context, "Edit request sent successfully to admin",
                    Colors.green);
                Navigator.pop(context);
              } else {
                snackBar(context, data['message'], Colors.red);
              }
            }
          });
        });
      }
    });
  }

  void getEditTypeList() {
    try {
      getStringPref('token').then((token) async {
        final response = await http.get(
          Uri.parse("$apiUrl/viewRequestTypeList"),
          headers: {'Authorization': token},
        );
        var data = jsonDecode(response.body);
        if (data['code'] == 200) {
          List lst = data['data'];
          lst.forEach((element) {
            editTypeList.add({
              'name': element['requestName'],
              'id': element['requestTypeId']
            });
          });
          setState(() {});
        } else {
          snackBar(context, "Something went wrong", Colors.red);
        }
      });
    } catch (e) {
      snackBar(context, "Something went wrong", Colors.red);
    }
  }
}

Widget bloodGroupDropDown(RxString string) {
  return Obx(() => Container(
        width: double.infinity,
        height: 45,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: primaryColor.withOpacity(0.8))),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            items: <String>[
              'A RhD positive (A+)',
              ' A RhD negative (A-)',
              ' B RhD positive (B+)',
              ' B RhD negative (B-)',
              ' O RhD positive (O+)',
              ' O RhD negative (O-)',
              ' AB RhD positive (AB+)',
              ' AB RhD negative (AB-)'
            ].map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(value),
                ),
              );
            }).toList(),
            value: string.value == "" ? null : string.value,
            onChanged: (val) {
              string.value = val ?? "";
            },
            style: textFieldTextStyle,
            icon: Icon(
              Icons.arrow_drop_down_outlined,
              color: primaryColor,
            ),
            hint: Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  "Select Blood Group",
                  style: hintTextStyle,
                )),
          ),
        ),
      ));
}

tagedEducationTextfield(
    TextfieldTagsController _controller, List<String> educationList) {
  return Autocomplete<String>(
    optionsViewBuilder: (context, onSelected, options) {
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 4.0),
        child: Align(
          alignment: Alignment.topCenter,
          child: Material(
            elevation: 4.0,
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 200),
              child: ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemCount: options.length,
                itemBuilder: (BuildContext context, int index) {
                  final dynamic option = options.elementAt(index);
                  return InkWell(
                    onTap: () {
                      onSelected(option);
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 5),
                      child: Text('$option', style: profilePageSubTextStyle),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      );
    },
    optionsBuilder: (TextEditingValue textEditingValue) {
      if (textEditingValue.text == '') {
        return const Iterable<String>.empty();
      }
      return educationList.where((String option) {
        return option.toLowerCase().contains(textEditingValue.text);
      });
    },
    onSelected: (String selectedTag) {
      _controller.addTag = selectedTag;
    },
    fieldViewBuilder: (context, ttec, tfn, onFieldSubmitted) {
      return TextFieldTags(
        textEditingController: ttec,
        focusNode: tfn,
        textfieldTagsController: _controller,
        initialTags: const [],
        textSeparators: const [' ', ','],
        validator: (String tag) {
          if (_controller.getTags!.contains(tag)) {
            return 'You already entered that';
          }
          return null;
        },
        inputfieldBuilder: (context, tec, fn, error, onChanged, onSubmitted) {
          return ((context, sc, tags, onTagDelete) {
            return TextField(
              cursorColor: primaryColor,
              controller: tec,
              focusNode: fn,
              decoration: InputDecoration(
                border: UnderlineInputBorder(
                  borderSide: BorderSide(color: primaryColor.withOpacity(0.8)),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: primaryColor.withOpacity(0.8),
                  ),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: primaryColor.withOpacity(0.8),
                  ),
                ),
                hintText: _controller.hasTags ? '' : "Enter Education",
                hintStyle: hintTextStyle,
                errorText: error,
                prefixIcon: tags.isNotEmpty
                    ? SingleChildScrollView(
                        controller: sc,
                        scrollDirection: Axis.horizontal,
                        child: Row(
                            children: tags.map((String tag) {
                          return Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(20.0),
                              ),
                              color: primaryColor,
                            ),
                            margin: const EdgeInsets.only(right: 10.0),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 4.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  child: Text(
                                    tag,
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ),
                                const SizedBox(width: 4.0),
                                InkWell(
                                  child: const Icon(
                                    Icons.cancel,
                                    size: 14.0,
                                    color: Color.fromARGB(255, 233, 233, 233),
                                  ),
                                  onTap: () {
                                    onTagDelete(tag);
                                  },
                                )
                              ],
                            ),
                          );
                        }).toList()),
                      )
                    : null,
              ),
              onChanged: onChanged,
              onSubmitted: onSubmitted,
            );
          });
        },
      );
    },
  );
}

profilePhotoContainer(String photoUrl, {double? height, double? width}) {
  return CachedNetworkImage(
      imageUrl: "$imageUrl=${photoUrl}",
      fit: BoxFit.cover,
      imageBuilder: (context, imageProvider) => Container(
            width: height ?? 90.0,
            height: width ?? 90.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
              border:
                  Border.all(color: primaryColor.withOpacity(0.7), width: 1.5),
            ),
          ),
      placeholder: (context, url) =>
          skeletonRoundedContainer(context, height ?? 90, width ?? 90),
      errorWidget: (context, url, error) => Container(
            width: height ?? 90.0,
            height: width ?? 90.0,
            decoration: BoxDecoration(
                border: Border.all(
                    color: primaryColor.withOpacity(0.7), width: 1.5),
                shape: BoxShape.circle,
                color: Colors.grey.shade300),
            child: Icon(
              Icons.person,
              color: Colors.black54,
              size: 30,
            ),
          ));
}

class AllPageTitle extends StatelessWidget {
  final String text;

  const AllPageTitle({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Row(
        children: [
          InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.keyboard_arrow_left_outlined,
              size: 38,
            ),
          ),
          SizedBox(
            width: getScreenWidth(context, 0.03),
          ),
          Expanded(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              child: Text(
                text,
                style: TextStyle(fontSize: 23, fontWeight: FontWeight.w500),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ProfilePageTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final TextInputType textInputType;

  const ProfilePageTextField(
      {Key? key,
      required this.controller,
      required this.hintText,
      required this.textInputType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      cursorColor: primaryColor,
      style: textFieldTextStyle,
      keyboardType: textInputType,
      decoration: InputDecoration(
          // filled: true,
          //   fillColor: Colors.red,
          labelText: hintText,
          labelStyle: hintTextStyle,
          isDense: true,
          border: UnderlineInputBorder(
              borderSide: BorderSide(color: primaryColor.withOpacity(0.8))),
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: primaryColor.withOpacity(0.8))),
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: primaryColor.withOpacity(0.8)))),
    );
  }
}
