import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;

import '../../constant/constant.dart';
import '../../constant/set_pref.dart';
import '../../constant/snack_bar.dart';
import '../../getx_controller/getx.dart';

class DonorDetailScreen extends StatefulWidget {
  final int donationId;

  const DonorDetailScreen({Key? key, required this.donationId})
      : super(key: key);

  @override
  State<DonorDetailScreen> createState() => _DonorDetailScreenState();
}

class _DonorDetailScreenState extends State<DonorDetailScreen> {
  FamilyGetController familyGetController = Get.put(FamilyGetController());
  bool loading = true;

  @override
  void initState() {
    super.initState();
    showConnectivity(context).then((value) {
      if (value) {
        familyGetController.donarList.clear();
        getDonar();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          allScreenStatusBarPadding(context),
          InkWell(
            onTap: (){
              print(familyGetController.donationTypeList);
            },
            child: allPageTitleRow(
                "Doner's detail List", familyGetController.donarOnOff),
          ),
          Obx(() => Expanded(
              child: familyGetController.donarList.isNotEmpty
                  ? ListView.builder(
                      scrollDirection: Axis.vertical,
                      physics: BouncingScrollPhysics(),
                      itemCount: familyGetController.donarList.length,
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Container(
                          width: double.infinity,
                          margin: EdgeInsets.all(5),
                          padding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 15),
                          decoration: containerDecoration,
                          child: Obx(()=>Column(
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
                                      familyGetController.donarOnOff.value ==
                                          false
                                          ? familyGetController.donarList[index]
                                      ['engName']
                                          : familyGetController.donarList[index]
                                      ['gujName'],
                                      style: TextStyle(
                                          color: Colors.grey.shade800,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Amount : ",
                                    style: allCardSubTextStyle,
                                  ),
                                  Text(
                                    "\u{20B9} ${familyGetController.donarList[index]['amount'].toString()}",
                                    style: TextStyle(
                                        color: Colors.grey.shade800,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                familyGetController.donarList[index]['description'],
                                style: TextStyle(
                                    color: Colors.grey.shade800,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16),
                              )
                            ],
                          )),
                        );
                      })
                  : loading == true
                      ? Center(
                          child: circularProgress(),
                        )
                      : centerNoRecordText())),
        ],
      ),
    );
  }

  void getDonar() {
    try {
      getStringPref('token').then((token) async {
        final response = await http.get(
            Uri.parse(
                "$apiUrl/viewDonarList?donationTypeId=${widget.donationId}"),
            headers: {
              'Authorization': token,
            });
        var data = jsonDecode(response.body);
        if (data['code'] == 200) {
          familyGetController.donarList.addAll(data['data']);
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
