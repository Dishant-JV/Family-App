import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:youtube/youtube_thumbnail.dart';

import '../../../constant/constant.dart';
import '../../../getx_controller/getx.dart';
import '../../profile/edit_my_profile_page.dart';
import 'gallery_play_video.dart';

class GalleryVideoList extends StatefulWidget {
  final String eventEngName;
  final String eventGujName;

  const GalleryVideoList(
      {Key? key, required this.eventEngName, required this.eventGujName})
      : super(key: key);

  @override
  State<GalleryVideoList> createState() => _GalleryVideoListState();
}

class _GalleryVideoListState extends State<GalleryVideoList> {
  FamilyGetController familyGetController = Get.put(FamilyGetController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          allScreenStatusBarPadding(context),
          AllPageTitle(
              text: "${widget.eventEngName} ( ${widget.eventGujName})"),
          Expanded(
            child:
                Obx(() => familyGetController.galleryVideoThumbnail.isNotEmpty
                    ? ListView.builder(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        itemCount:
                            familyGetController.galleryVideoThumbnail.length,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                            onTap: () {
                              pushMethod(
                                  context,
                                  GalleryPlayVideo(
                                    videoUrl: familyGetController
                                            .galleryVideoThumbnail[index]
                                        ['videoId'],
                                    engEventName: widget.eventEngName,
                                    gujEventName: widget.eventGujName,
                                  ));
                            },
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Container(
                                    margin: EdgeInsets.only(
                                        bottom: 5, left: 5, right: 5),
                                    width: double.infinity,
                                    height: getScreenHeight(context, 0.23),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.black, width: 0.7),
                                    ),
                                    child: CachedNetworkImage(
                                        imageUrl: YoutubeThumbnail(
                                                youtubeId: familyGetController
                                                        .galleryVideoThumbnail[
                                                    index]['videoId'])
                                            .hq(),
                                        fit: BoxFit.cover,
                                        placeholder: (context, url) => skeletonContainer(context),
                                        errorWidget: (context, url, error) =>
                                            Image.asset(
                                                'assets/images/noImage.png'))),
                                Icon(
                                  Icons.play_circle_fill,
                                  color: Colors.white,
                                  size: 33,
                                ),
                              ],
                            ),
                          );
                        },
                      )
                    : centerNoRecordText()),
          ),
        ],
      ),
    );
  }
}
