import 'package:family_app/constant/constant.dart';
import 'package:family_app/getx_controller/getx.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:textfield_tags/textfield_tags.dart';

class MyProfilePage extends StatefulWidget {
  const MyProfilePage({Key? key}) : super(key: key);

  @override
  State<MyProfilePage> createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController middleNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController primaryMobileController = TextEditingController();
  TextEditingController secondMobileController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  String birthDate = "";
  int? selectedEducation;
  TextfieldTagsController? _controller = TextfieldTagsController();

  // String? selectedBloodGroupValue;
  String? castSelection;
  FamilyGetController familyGetController = Get.put(FamilyGetController());
  List<String> educationList = ["BBA", "BCA", "B COM", "MBA", "MCA", "M COM"];

  @override
  void initState() {
    super.initState();
    _controller = TextfieldTagsController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        reverse: true,
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            allScreenStatusBarPadding(context),
            AllPageTitle(
              text: "My Profile",
            ),
            profilePhotoContainer(45),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                        style: textFieldMainTextStyle,
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
                                  birthDate.toString() ?? "",
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
                        style: textFieldMainTextStyle,
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
                        style: textFieldMainTextStyle,
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
                    style: textFieldMainTextStyle,
                  ),
                  tagedEducationTextfield(_controller!, educationList),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Blood Group",
                    style: textFieldMainTextStyle,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  bloodGroupDropDown(
                      familyGetController.profileSelectedBloodGroupValue),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Gender",
                        style: textFieldMainTextStyle,
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
                                  style: textFieldMainTextStyle,
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
                                  style: textFieldMainTextStyle,
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
                  saveElevatedButton(context, "Save")
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
                      child: Text('$option', style: textFieldMainTextStyle),
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

profilePhotoContainer(double radius) {
  return Container(
    decoration: BoxDecoration(
        border: Border.all(color: primaryColor.withOpacity(0.7), width: 2),
        shape: BoxShape.circle),
    child: CircleAvatar(
      radius: radius,
      backgroundImage: AssetImage(("assets/images/profile_photo.jpg")),
    ),
  );
}

saveElevatedButton(BuildContext context, String text) {
  return Align(
    alignment: Alignment.center,
    child: Container(
      alignment: Alignment.center,
      height: 45,
      width: getScreenWidth(context, 0.4),
      decoration: BoxDecoration(
          color: primaryColor.withOpacity(0.5),
          border: Border.all(color: primaryColor.withOpacity(0.3), width: 1),
          borderRadius: BorderRadius.circular(20)),
      child: Text(
        text,
        style: TextStyle(
            letterSpacing: 0.5,
            fontWeight: FontWeight.w500,
            color: Colors.white,
            fontSize: 19),
      ),
    ),
  );
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
            width: getScreenWidth(context, 0.05),
          ),
          Text(
            text,
            style: TextStyle(
                color: Colors.black, fontSize: 23, fontWeight: FontWeight.w500),
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
