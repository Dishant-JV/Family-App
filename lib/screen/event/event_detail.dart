import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;

import '../../constant/constant.dart';
import '../../constant/set_pref.dart';
import '../../constant/snack_bar.dart';
import '../../getx_controller/getx.dart';
import 'commitee_member_list_screen.dart';

class EventDetailScreen extends StatefulWidget {
  final int eventId;

  const EventDetailScreen({Key? key, required this.eventId}) : super(key: key);

  @override
  State<EventDetailScreen> createState() => _EventDetailScreenState();
}

class _EventDetailScreenState extends State<EventDetailScreen> {
  FamilyGetController familyGetController = Get.put(FamilyGetController());
  bool loading = true;
  Map eventDetailData = {};
  List? eventCommitteeList;

  @override
  void initState() {
    super.initState();
    showConnectivity(context).then((value) {
      if (value) {
        familyGetController.eventCommitteeList.clear();
        getEventDetailData();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          allScreenStatusBarPadding(context),
          allPageTitleRow("Event Detail", familyGetController.eventDetailOnOff),
          eventDetailData.length != 0
              ? Obx(() => Container(
                    padding: EdgeInsets.all(15),
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      children: [
                        Center(
                            child: Text(
                          familyGetController.eventDetailOnOff.value == false
                              ? ":: ${eventDetailData['engName']} ::"
                              : ":: ${eventDetailData['gujName']} ::",
                          style: familyTextStyle,
                        )),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          familyGetController.eventDetailOnOff.value == false
                              ? eventDetailData['engDescription']
                              : eventDetailData['gujDescription'],
                          style: profilePageSubTextStyle,
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              FontAwesomeIcons.locationDot,
                              size: 18,
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Expanded(
                              child: Text(
                                familyGetController.eventDetailOnOff.value ==
                                        false
                                    ? "${eventDetailData['engPlace']} , ${eventDetailData['engDistrictName']}."
                                    : "${eventDetailData['gujPlace']} , ${eventDetailData['gujDistrictName']}.",
                                style: allCardSubTextStyle,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.timer,
                              size: 18,
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Text(
                              eventDetailData['eventTime'],
                              style: allCardSubTextStyle,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.date_range,
                              size: 18,
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Text(
                              "${dateFormat(eventDetailData['startDate'].toString())} - ${dateFormat(eventDetailData['endDate'].toString())}",
                              style: allCardSubTextStyle,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        familyGetController.eventCommitteeList.isNotEmpty
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Comitee :",
                                    style: allCardMainTextStyle,
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: familyGetController
                                          .eventCommitteeList.length,
                                      padding: EdgeInsets.zero,
                                      itemBuilder: (context, index) {
                                        return InkWell(
                                          onTap: () {
                                            pushMethod(
                                                context,
                                                committeeMemberListScreen(
                                                  comiteeId: familyGetController
                                                          .eventCommitteeList[
                                                      index]['comiteeId'],
                                                ));
                                          },
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 8, vertical: 5),
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                                color: Colors.grey
                                                    .withOpacity(0.2),
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "${familyGetController.eventDetailOnOff.value == false ? familyGetController.eventCommitteeList[index]['engComiteeName'] : familyGetController.eventCommitteeList[index]['gujComiteeName']}",
                                                  style:
                                                      profilePageSubTextStyle,
                                                ),
                                                SizedBox(
                                                  height: 3,
                                                ),
                                                Text(
                                                  familyGetController
                                                          .eventCommitteeList[
                                                      index]['comiteeType'],
                                                  style: cityTextStyle,
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      })
                                ],
                              )
                            : Container()
                      ],
                    ),
                  ))
              : loading == true
                  ? Expanded(
                      child: Center(
                      child: circularProgress(),
                    ))
                  : Expanded(
                      child: Center(
                      child: centerNoRecordText(),
                    ))
        ],
      ),
    );
  }

  void getEventDetailData() {
    try {
      getStringPref('token').then((token) async {
        final response = await http
            .get(Uri.parse("$apiUrl/viewEvent/${widget.eventId}"), headers: {
          'Authorization': token,
        });
        var data = jsonDecode(response.body);
        if (data['code'] == 200) {
          eventDetailData.addAll(data['data']);
          eventCommitteeList = data['data']['comiteeData'];
          if (eventCommitteeList != null) {
            familyGetController.eventCommitteeList.addAll(eventCommitteeList ?? []);
          }
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
