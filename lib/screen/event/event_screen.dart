import 'dart:convert';

import 'package:family_app/screen/event/event_detail.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;
import '../../constant/constant.dart';
import '../../constant/event_container.dart';
import '../../constant/set_pref.dart';
import '../../constant/snack_bar.dart';
import '../../getx_controller/getx.dart';

class EventScreen extends StatefulWidget {
  const EventScreen({Key? key}) : super(key: key);

  @override
  State<EventScreen> createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  FamilyGetController familyGetController = Get.put(FamilyGetController());
  bool loading = true;

  @override
  void initState() {
    super.initState();
    showConnectivity(context).then((value) {
      if (value) {
        familyGetController.allEventList.clear();
        getAllEventData();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          allScreenStatusBarPadding(context),
          allPageTitleRow("Event", familyGetController.allEventOnOff),
          Expanded(
              child: Obx(() => familyGetController.allEventList.isNotEmpty
                  ? ListView.builder(
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      shrinkWrap: true,
                      itemCount: familyGetController.allEventList.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            pushMethod(
                                context,
                                EventDetailScreen(
                                    eventId: familyGetController
                                        .allEventList[index]['eventId']));
                          },
                          child: EventContainer(
                            lst: familyGetController.allEventList,
                            index: index,
                            switchData: familyGetController.allEventOnOff,
                          ),
                        );
                      })
                  : Center(
                      child: circularProgress(),
                    )))
        ],
      ),
    );
  }

  void getAllEventData() {
    try {
      getStringPref('token').then((token) async {
        final response =
            await http.get(Uri.parse("$apiUrl/viewEventList"), headers: {
          'Authorization': token,
        });
        var data = jsonDecode(response.body);
        if (data['code'] == 200) {
          familyGetController.allEventList.addAll(data['data']);
        }
        setState(() {
          loading = false;
        });
      });
    } catch (e) {
      snackBar(context, "Something went wrong", Colors.red);
    }
  }
}
