import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../constant/constant.dart';
import '../../../getx_controller/getx.dart';
import '../../profile/edit_my_profile_page.dart';
import '../../show_image/show_image.dart';

class GalleryImageDetail extends StatefulWidget {
  final String eventName;

  const GalleryImageDetail({Key? key, required this.eventName})
      : super(key: key);

  @override
  State<GalleryImageDetail> createState() => _GalleryImageDetailState();
}

class _GalleryImageDetailState extends State<GalleryImageDetail> {
  FamilyGetController familyGetController = Get.put(FamilyGetController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        allScreenStatusBarPadding(context),
          AllPageTitle(text: widget.eventName),
        Obx(() => familyGetController.galleryImage.isNotEmpty
            ? GridView.builder(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemCount: familyGetController.galleryImage.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, mainAxisSpacing: 5, crossAxisSpacing: 5),
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {
                      pushMethod(
                          context,
                          ShowImageScreen(
                            imageUrl:
                                "$imageUrl=${familyGetController.galleryImage[index]['imageUrl']}",
                            isAssetImage: false,
                          ));
                    },
                    child: Container(
                      width: getScreenWidth(context, 0.5),
                      height: getScreenWidth(context, 0.5),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 0.2),
                      ),
                      child: CachedNetworkImage(
                          imageUrl:
                              "$imageUrl=${familyGetController.galleryImage[index]['imageUrl']}",
                          fit: BoxFit.cover,
                          placeholder: (context, url) => skeletonContainer(context),
                          errorWidget: (context, url, error) =>
                              Image.asset('assets/images/noImage.png')),
                    ),
                  );
                },
              )
            : centerNoRecordText()),
      ],
    ));
  }
}
