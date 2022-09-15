import 'package:flutter/material.dart';

import '../../constant/constant.dart';
import '../profile/my_profile_page.dart';

class BusinessDetailList extends StatefulWidget {
  const BusinessDetailList({Key? key}) : super(key: key);

  @override
  State<BusinessDetailList> createState() => _BusinessDetailListState();
}

class _BusinessDetailListState extends State<BusinessDetailList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          allScreenStatusBarPadding(context),
          AllPageTitle(
            text: "Business List",
          ),
          Expanded(
              child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  physics: BouncingScrollPhysics(),
                  itemCount: 10,
                  padding: EdgeInsets.symmetric(vertical: 5),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6.0),
                        border: Border.all(
                            color: primaryColor.withOpacity(0.1), width: 0.2),
                        color: index % 2 == 0
                            ? Color(0xff605B83).withOpacity(0.5)
                            : Color(0xffC9C4A3),
                      ),
                      child: Row(
                        children: [
                          profilePhotoContainer(35),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "ArvindBhai Dudhat",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: 0.5,
                                      fontSize: 20,
                                      color:Color(0xff605B83),),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "Flutter Developer",
                                  style: TextStyle(
                                      color: Color(0xff605B83),
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.call,
                                      color: Color(0xff605B83),
                                      size: 18,
                                    ),
                                    Text(
                                      "  9027283074",
                                      style: TextStyle(
                                          color: Color(0xff605B83),
                                          fontWeight: FontWeight.w500,
                                          fontSize: 15),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                SingleChildScrollView(
                                  physics: BouncingScrollPhysics(),
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.location_on,
                                        color: Color(0xff605B83),
                                        size: 18,
                                      ),
                                      Text(
                                        "  422 - Apple Square, Yogichowk, Varachha, Surat",
                                        style: TextStyle(
                                            color:
                                            Color(0xff605B83),
                                            fontWeight: FontWeight.w500,
                                            fontSize: 15),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  }))
        ],
      ),
    );
  }
}
