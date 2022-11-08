import 'package:flutter/material.dart';

import '../../constant/constant.dart';
import '../../constant/member_container.dart';
import '../profile/edit_my_profile_page.dart';

class DetailSearchMemberScreen extends StatefulWidget {
  const DetailSearchMemberScreen({Key? key}) : super(key: key);

  @override
  State<DetailSearchMemberScreen> createState() => _DetailSearchMemberScreenState();
}

class _DetailSearchMemberScreenState extends State<DetailSearchMemberScreen> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          allScreenStatusBarPadding(context),
          AllPageTitle(
            text: "Search Member",
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: textFieldWidget(
                "Search Member",
                searchController,
                false,
                true,
                Colors.grey.shade100.withOpacity(0.5),
                TextInputType.text,
                Color(0xffFB578E).withOpacity(0.3),
                1,
                false),
          ),
          SizedBox(
            height: 10,
          ),
          // Expanded(
          //   child: ListView.builder(
          //       padding: EdgeInsets.symmetric(horizontal: 15),
          //       shrinkWrap: true,
          //       scrollDirection: Axis.vertical,
          //       physics: BouncingScrollPhysics(),
          //       itemCount: 10,
          //       itemBuilder: (context, index) {
          //         return MemberContainer();
          //       }),
          // )
        ],
      ),
    );
  }
}
