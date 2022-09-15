import 'package:cached_network_image/cached_network_image.dart';
import 'package:family_app/constant/constant.dart';
import 'package:flutter/material.dart';

class EventContainer extends StatelessWidget {
  const EventContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border(
              bottom:
                  BorderSide(color: Colors.grey.shade600.withOpacity(0.3), width: 1.2))),
      child: Row(
        children: [
          CachedNetworkImage(
            imageUrl:
                "https://img.freepik.com/free-vector/flat-world-blood-donor-day-illustration_23-2148951414.jpg?w=826&t=st=1659591087~exp=1659591687~hmac=154d9d2355e2bc628464e2ea114e77e0bce6eabd6cb713d98b467525859f51bd",
            height: 130,
            width: 130,
            placeholder: (context, url) => Center(
              child: CircularProgressIndicator(color: primaryColor,),
            ),
          ),
          SizedBox(
            width: 5,
          ),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "::  Blood Donation  ::",
                style: allCardMainTextStyle,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Patel samaj ni vadi, Minibazar, varachha road, surat",
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
                    "12 August, 2022",
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
    );
  }
}
