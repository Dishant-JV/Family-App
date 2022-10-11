import 'package:flutter/material.dart';

import '../../constant/constant.dart';
import '../profile/edit_my_profile_page.dart';

class DonorDetailScreen extends StatefulWidget {
  const DonorDetailScreen({Key? key}) : super(key: key);

  @override
  State<DonorDetailScreen> createState() => _DonorDetailScreenState();
}

class _DonorDetailScreenState extends State<DonorDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          allScreenStatusBarPadding(context),
          AllPageTitle(
            text: "Doner's detail List",
          ),
          Expanded(
              child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  physics: BouncingScrollPhysics(),
                  itemCount: 15,
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Container(
                      width: double.infinity,
                      margin: EdgeInsets.all(5),
                      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 15),
                      decoration: containerDecoration,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                Text(
                                  "Name : ",
                                  style: allCardSubTextStyle,
                                ),
                                Text(
                                  "DineshBhai Dudhat",
                                  style: TextStyle(color: Colors.grey.shade800, fontWeight: FontWeight.w500, fontSize: 16),
                                )
                              ],
                            ),
                          ),
                          SizedBox(height: 8,),
                          Row(
                            children: [
                              Text(
                                "Amount : ",
                                style: allCardSubTextStyle,
                              ),
                              Text(
                                "\u{20B9} 1,11,111",
                                style: TextStyle(color: Colors.grey.shade800, fontWeight: FontWeight.w500, fontSize: 16),
                              )
                            ],
                          )
                        ],
                      ),
                    );
                  })),

        ],
      ),
    );
  }
}
