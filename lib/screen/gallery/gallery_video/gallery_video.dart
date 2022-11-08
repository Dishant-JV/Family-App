import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:family_app/screen/gallery/gallery_video/gallery_play_video.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;
import 'package:youtube/youtube_thumbnail.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../constant/constant.dart';
import '../../../constant/set_pref.dart';
import '../../../constant/snack_bar.dart';
import '../../../getx_controller/getx.dart';

class GalleryVideo extends StatefulWidget {
  const GalleryVideo({Key? key}) : super(key: key);

  @override
  State<GalleryVideo> createState() => _GalleryVideoState();
}

class _GalleryVideoState extends State<GalleryVideo> {
  FamilyGetController familyGetController = Get.put(FamilyGetController());
  bool loading = true;

  @override
  void initState() {
    super.initState();
    showConnectivity(context).then((value) {
      if (value) {
        familyGetController.galleryVideoThumbnail.clear();
        getVideoList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => familyGetController.galleryVideoThumbnail.isNotEmpty
          ? ListView.builder(
              padding: EdgeInsets.zero,
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.vertical,
              itemCount: familyGetController.galleryVideoThumbnail.length,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () {
                    pushMethod(
                        context,
                        GalleryPlayVideo(
                          videoUrl:
                              familyGetController.galleryVideoThumbnail[index]['videoId'],
                          engEventName: familyGetController
                              .galleryVideoThumbnail[index]['engEventName'],
                          gujEventName: familyGetController
                              .galleryVideoThumbnail[index]['gujEventName'],
                        ));
                  },
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                          margin: EdgeInsets.only(bottom: 5),
                          width: double.infinity,
                          height: getScreenHeight(context, 0.23),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 0.7),
                          ),
                          child: CachedNetworkImage(
                              imageUrl: YoutubeThumbnail(
                                      youtubeId: familyGetController
                                              .galleryVideoThumbnail[index]
                                          ['videoId'])
                                  .hq(),
                              fit: BoxFit.cover,
                              placeholder: (context, url) => Center(
                                    child: CircularProgressIndicator(
                                      color: primaryColor,
                                    ),
                                  ),
                              errorWidget: (context, url, error) =>
                                  Image.asset('assets/images/noImage.png'))),
                      Icon(
                        Icons.play_circle_fill,
                        color: Colors.white,
                        size: 33,
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        child: Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(3),
                          margin: EdgeInsets.only(bottom: 10, left: 10),
                          decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(5)),
                          child: Text(
                            familyGetController.galleryVideoThumbnail[index]
                                ['engEventName'],
                            style: TextStyle(
                                color: Colors.white.withOpacity(0.85),
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      )
                    ],
                  ),
                );
              },
            )
          : loading == true
              ? Center(
                  child: circularProgress(),
                )
              : centerNoRecordText()),
    );
  }

  void getVideoList() {
    try {
      getStringPref('token').then((token) async {
        final response =
            await http.get(Uri.parse("$apiUrl/viewVideoList"), headers: {
          'Authorization': token,
        });
        var data = jsonDecode(response.body);
        if (data['code'] == 200) {
          List lst = data['data'];
          lst.forEach((element) {
            String? videoId = YoutubePlayer.convertUrlToId(element['videoUrl']);
            if (videoId != null) {
              familyGetController.galleryVideoThumbnail.add({
                'videoId': videoId,
                'engEventName': element['engEventName'],
                'gujEventName': element['gujEventName']
              });
            }
          });
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
