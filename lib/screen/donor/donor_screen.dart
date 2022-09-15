import 'package:flutter/material.dart';
import '../../constant/constant.dart';
import '../profile/my_profile_page.dart';
import 'donor_detail_screen.dart';

class DonorScreen extends StatefulWidget {
  const DonorScreen({Key? key}) : super(key: key);

  @override
  State<DonorScreen> createState() => _DonorScreenState();
}

class _DonorScreenState extends State<DonorScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          allScreenStatusBarPadding(context),
          AllPageTitle(
            text: "Doner's List",
          ),
          Expanded(
              child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  physics: BouncingScrollPhysics(),
                  itemCount: 15,
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () async {
                        pushMethod(context, DonorDetailScreen());
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
                              ? Color(0xffDEDAD9)
                              : Color(0xffC4F0F1),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                physics: BouncingScrollPhysics(),
                                child: Text(
                                  "Doner Of Student Notebook",
                                  maxLines: 1,
                                  style: allCardSubTextStyle,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 5),
                              child: forwardIcon,
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
