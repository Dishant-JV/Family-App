import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:family_app/screen/show_image/show_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;
import '../../../constant/constant.dart';
import '../../../constant/set_pref.dart';
import '../../../constant/snack_bar.dart';
import '../../../getx_controller/getx.dart';

class GalleryImageAlbum extends StatefulWidget {
  const GalleryImageAlbum({Key? key}) : super(key: key);

  @override
  State<GalleryImageAlbum> createState() => _GalleryImagesState();
}

class _GalleryImagesState extends State<GalleryImageAlbum> {
  FamilyGetController familyGetController = Get.put(FamilyGetController());
  bool loading = true;

  @override
  void initState() {
    super.initState();
    showConnectivity(context).then((value) {
      if (value) {
        familyGetController.galleryImageAlbum.clear();
        getImageList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Obx(() => familyGetController.galleryImageAlbum.isNotEmpty
            ? GridView.builder(
                padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemCount: familyGetController.galleryImageAlbum.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
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
                    child: Stack(
                      alignment: Alignment.bottomLeft,
                      children: [
                        Container(
                          width: getScreenWidth(context, 0.5),
                          height: getScreenWidth(context, 0.5),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 2),
                          ),
                          child: CachedNetworkImage(
                              imageUrl:
                                  "$imageUrl=${familyGetController.galleryImageAlbum[index]['banner']}",
                              fit: BoxFit.cover,
                              color: Color.fromRGBO(100, 100, 100, 0.8),
                              colorBlendMode: BlendMode.modulate,
                              placeholder: (context, url) => Center(
                                    child: CircularProgressIndicator(
                                      color: primaryColor,
                                    ),
                                  ),
                              errorWidget: (context, url, error) =>
                                  Image.asset('assets/images/noImage.png')),
                        ),
                        Container(
                          padding: EdgeInsets.all(3),
                          margin: EdgeInsets.only(left: 5,bottom: 5),
                          decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(5)),
                          child: Text(
                            familyGetController.galleryImageAlbum[index]
                                ['engEventName'],
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
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
                : centerNoRecordText()));
  }

  void getImageList() {
    try {
      getStringPref('token').then((token) async {
        final response =
            await http.get(Uri.parse("$apiUrl/viewImageList"), headers: {
          'Authorization': token,
        });
        var data = jsonDecode(response.body);
        if (data['code'] == 200) {
          familyGetController.galleryImageAlbum.addAll(data['data']);
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
