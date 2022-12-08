import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:family_app/screen/gallery/gallery_image/gallery_image_album.dart';
import 'package:family_app/screen/gallery/gallery_video/gallery_play_video.dart';
import 'package:family_app/screen/gallery/gallery_video/gallery_video_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;
import 'package:youtube/youtube_thumbnail.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../constant/constant.dart';
import '../../../constant/set_pref.dart';
import '../../../constant/snack_bar.dart';
import '../../../getx_controller/getx.dart';

class GalleryVideoAlbum extends StatefulWidget {
  const GalleryVideoAlbum({Key? key}) : super(key: key);

  @override
  State<GalleryVideoAlbum> createState() => _GalleryVideoState();
}

class _GalleryVideoState extends State<GalleryVideoAlbum> {
  FamilyGetController familyGetController = Get.put(FamilyGetController());
  bool loading = true;

  @override
  void initState() {
    super.initState();
    showConnectivity(context).then((value) {
      if (value) {
        familyGetController.galleryVideoAlbum.clear();
        getVideoAlbum();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => familyGetController.galleryVideoAlbum.isNotEmpty
          ? GridView.builder(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.vertical,
              itemCount: familyGetController.galleryVideoAlbum.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () {
                    familyGetController.galleryVideoThumbnail.clear();
                    getThumbNail(index);
                  },
                  child: GalleryImageVideoContainer(
                    eventName: familyGetController.galleryVideoAlbum[index]
                        ['engEventName'],
                    imageUrl:
                        "$imageUrl=${familyGetController.galleryVideoAlbum[index]['banner']}",
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

  void getVideoAlbum() {
    try {
      getStringPref('token').then((token) async {
        final response =
            await http.get(Uri.parse("$apiUrl/viewVideoList"), headers: {
          'Authorization': token,
        });
        var data = jsonDecode(response.body);
        if (data['code'] == 200) {
          familyGetController.galleryVideoAlbum.addAll(data['data']);
        }
        setState(() {
          loading = false;
        });
      });
    } catch (e) {
      snackBar(context, "Something went wrong", Colors.red);
    }
  }

  void getThumbNail(int index) {
    List lst = familyGetController.galleryVideoAlbum[index]['videoData'];
    lst.forEach((element) {
      String? videoId = YoutubePlayer.convertUrlToId(element['videoUrl']);
      if (videoId != null) {
        familyGetController.galleryVideoThumbnail.add({
          'videoId': videoId,
        });
      }
    });
    pushMethod(
        context,
        GalleryVideoList(
          eventEngName: familyGetController.galleryVideoAlbum[index]
              ['engEventName'],
          eventGujName: familyGetController.galleryVideoAlbum[index]
              ['gujEventName'],
        ));
  }
}
