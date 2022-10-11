import 'dart:io';

import 'package:family_app/screen/profile/edit_my_profile_page.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'constant.dart';

class MemberContainer extends StatelessWidget {
  const MemberContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 20, bottom: 10),
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  color: Colors.grey.shade600.withOpacity(0.3), width: 1.2))),
      child: Row(
        children: [
          profilePhotoContainer(30),
          SizedBox(
            width: 10,
          ),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Kanubhai K Dudhat",
                    style: allCardMainTextStyle,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: primaryColor.withOpacity(0.3)),
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Text(
                      "1302",
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 3,
              ),
              Row(
                children: [
                  Text(
                    "Mo : 9099233354",
                    style: allCardSubTextStyle,
                  ),
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: InkWell(
                          onTap: () {
                            openWhatsapp("9099233354", context);
                          },
                          child: wpIcon)),
                  InkWell(
                    onTap: () {
                      makingPhoneCall("9099233354", context);
                    },
                    child: callContainer(),
                  )
                ],
              ),
              SizedBox(
                height: 3,
              ),
              Row(
                children: [
                  locationIcon,
                  Text(
                    "Juna Janjariya, Bagsara, Amreli",
                    style: allCardSubTextStyle,
                  )
                ],
              )
            ],
          ))
        ],
      ),
    );
  }
}

Future<void> openWhatsapp(String phoneNumber, BuildContext context) async {
  String msg = "Hyyy";
  try {
    if (Platform.isAndroid) {
      await launchUrl(
          Uri.parse("whatsapp://send?phone=+91$phoneNumber+&text=$msg"));
    } else if (Platform.isIOS) {
      await launchUrl(Uri.parse("https://wa.me/+91$phoneNumber+&text=$msg"));
    }
  } catch (e) {
    showSnackBar(context, "Error in Opening Whatsapp");
  }
}

showSnackBar(BuildContext context, String value) {
  var snackBar = SnackBar(
    content: Text(
      value,
      style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
    ),
    backgroundColor: primaryColor,
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

makingPhoneCall(String PhoneNumber, BuildContext context) async {
  final Uri launchUri = Uri(
    scheme: 'tel',
    path: PhoneNumber,
  );
  await launchUrl(launchUri);
}
