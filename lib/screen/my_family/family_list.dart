import 'package:flutter/material.dart';

import '../../constant/constant.dart';
import '../profile/my_profile_page.dart';
import 'family_form_screen.dart';

class FamilyListScreen extends StatefulWidget {
  const FamilyListScreen({Key? key}) : super(key: key);

  @override
  State<FamilyListScreen> createState() => _FamilyListScreenState();
}

class _FamilyListScreenState extends State<FamilyListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          allScreenStatusBarPadding(context),
          AllPageTitle(
            text: "My Family",
          ),
          Expanded(
            child: ListView.builder(
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.vertical,
              padding: EdgeInsets.symmetric(vertical: 10),
                shrinkWrap: true,
                itemCount: 12,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: (){
                      pushMethod(context, FamilyFormScreen());
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: Row(
                        children: [
                          profilePhotoContainer(40),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Kalpesh Dudhat",
                                  style: allCardMainTextStyle,
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "Relation : ",
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Text("Son",
                                        style: TextStyle(
                                            color: Colors.grey.shade700,
                                            fontWeight: FontWeight.w500))
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }
}
