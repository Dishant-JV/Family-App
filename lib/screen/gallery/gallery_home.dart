import 'package:family_app/screen/gallery/gallery_image/gallery_image_album.dart';
import 'package:family_app/screen/gallery/gallery_video/gallery_video_album.dart';
import 'package:family_app/screen/profile/edit_my_profile_page.dart';
import 'package:flutter/material.dart';

import '../../constant/constant.dart';

class GalleryHome extends StatefulWidget {
  const GalleryHome({Key? key}) : super(key: key);

  @override
  State<GalleryHome> createState() => _GalleryHomeState();
}

class _GalleryHomeState extends State<GalleryHome> {
  PageController page = PageController(initialPage: 0);
  int pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          allScreenStatusBarPadding(context),
          AllPageTitle(text: 'Gallery'),
          Container(
            child: Row(
              children: [
                imageTextContainer("Images", 0),
                Container(
                  height: 25,
                  width: 1,
                  color: primaryColor.withOpacity(0.5),
                ),
                imageTextContainer("Video", 1),
              ],
            ),
          ),
          Expanded(
              child: PageView(
            controller: page,
            pageSnapping: true,
            children: [GalleryImageAlbum(), GalleryVideoAlbum()],
          ))
        ],
      ),
    );
  }

  imageTextContainer(String name, int index) {
    return Expanded(
      child: InkWell(
        onTap: () {
          setState(() {
            pageIndex = index;
            page.animateToPage(pageIndex,
                duration: Duration(milliseconds: 500),
                curve: Curves.linearToEaseOut);
          });
        },
        child: Container(
            alignment: Alignment.center,
            height: 40,
            decoration: BoxDecoration(
                border: pageIndex == index
                    ? Border(bottom: BorderSide(color: primaryColor, width: 2))
                    : Border()),
            child: Text(
              name,
              style: TextStyle(
                  color: index == pageIndex
                      ? primaryColor
                      : primaryColor.withOpacity(0.6),
                  fontWeight: FontWeight.w500,
                  fontSize: 17),
            )),
      ),
    );
  }
}
