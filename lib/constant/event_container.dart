import 'package:cached_network_image/cached_network_image.dart';
import 'package:family_app/constant/constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:intl/intl.dart';

class EventContainer extends StatelessWidget {
  final List<dynamic> lst;
  final int index;
  final RxBool switchData;

  const EventContainer(
      {Key? key,
      required this.lst,
      required this.index,
      required this.switchData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => Container(
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(
                      color: Colors.grey.shade600.withOpacity(0.3),
                      width: 1.2))),
          child: Row(
            children: [
              CachedNetworkImage(
                  imageUrl: "$imageUrl=${lst[index]['banner']}",
                  height: 130,
                  width: 130,
                  placeholder: (context, url) => Center(
                        child: CircularProgressIndicator(
                          color: primaryColor,
                        ),
                      ),
                  errorWidget: (context, url, error) =>
                      Image.asset('assets/images/noImage.png')),
              SizedBox(
                width: 5,
              ),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    switchData == false
                        ? "::  ${lst[index]['engName']}  ::"
                        : "::  ${lst[index]['gujName']}  ::",
                    style: allCardMainTextStyle,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                    Text(
                      switchData == false
                          ? "${lst[index]['engPlace']} , ${lst[index]['engDistrictName']}"
                          : "${lst[index]['gujPlace']} , ${lst[index]['gujDistrictName']}",
                      style: allCardSubTextStyle,
                    ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.date_range,
                        size: 18,
                        color: Colors.grey.shade500,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "${dateFormat(lst[index]['startDate'].toString())} - ${dateFormat(lst[index]['endDate'].toString())}",
                        style: TextStyle(
                            color: Colors.grey.shade500,
                            fontWeight: FontWeight.w500,
                            fontSize: 15),
                      ),
                    ],
                  )
                ],
              ))
            ],
          ),
        ));
  }
}
