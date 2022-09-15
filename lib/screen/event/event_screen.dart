import 'package:flutter/material.dart';

import '../../constant/constant.dart';
import '../../constant/event_container.dart';
import '../profile/my_profile_page.dart';

class EventScreen extends StatefulWidget {
  const EventScreen({Key? key}) : super(key: key);

  @override
  State<EventScreen> createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          allScreenStatusBarPadding(context),
          AllPageTitle(
            text: "Event",
          ),
          Expanded(
            child: ListView.builder(
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.vertical,
                padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                shrinkWrap: true,
                itemCount: 12,
                itemBuilder: (context, index) {
                  return EventContainer();
                }),
          )

        ],
      ),
    );
  }
}
