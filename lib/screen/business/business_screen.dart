import 'package:flutter/material.dart';

import '../../constant/constant.dart';
import '../profile/edit_my_profile_page.dart';
import 'business_detail_list.dart';

class BusinessScreen extends StatefulWidget {
  const BusinessScreen({Key? key}) : super(key: key);

  @override
  State<BusinessScreen> createState() => _BusinessScreenState();
}

class _BusinessScreenState extends State<BusinessScreen> {
  List<String> businessList = [
    "IT (Information Technology)",
    "Computer",
    "Construction",
    "Diamond",
    "Textile",
    "Real Asstet",
    "Gold jewellery",
    "Restaurant",
    "Handloom",
    "Tobaco",
    "Electric",
    "Imitation jewellery",
    "Cloth Shop",
    "Advocate",
    "Doctor"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          allScreenStatusBarPadding(context),
          AllPageTitle(
            text: "Business Type",
          ),
          Expanded(
              child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  physics: BouncingScrollPhysics(),
                  itemCount: businessList.length,
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        pushMethod(context, BusinessDetailList());
                      },
                      child: Container(
                        width: double.infinity,
                        margin: EdgeInsets.only(bottom: 10),
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6.0),
                          border: Border.all(
                              color: primaryColor.withOpacity(0.3), width: 0.1),
                          color: index % 2 == 0
                              ? Color(0xff01559E)
                              : Color(0xff688BAB),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                physics: BouncingScrollPhysics(),
                                child: Text(
                                  businessList[index],
                                  maxLines: 1,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 5),
                              child: Icon(Icons.arrow_forward_ios,
                                  size: 18, color: Colors.white),
                            )
                          ],
                        ),
                      ),
                    );
                  })),
        ],
      ),
    );
  }
}
