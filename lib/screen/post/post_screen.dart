import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:family_app/constant/set_pref.dart';
import 'package:family_app/getx_controller/getx.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:family_app/constant/constant.dart';
import 'package:family_app/screen/profile/edit_my_profile_page.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../constant/snack_bar.dart';
import '../show_image/show_image.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({Key? key}) : super(key: key);

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  FamilyGetController familyGetController = Get.put(FamilyGetController());
  TextEditingController postTextController = TextEditingController();
  File? image;
  String? binaryImage;
  String? fileName;
  List<String> fileExtension = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    showConnectivity(context).then((value) {
      if (value) {
        familyGetController.postList.clear();
        getPostList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return LoaderOverlay(
      useDefaultLoading: false,
      overlayWidget: Center(
        child: circularProgress(),
      ),
      child: Scaffold(
        backgroundColor: Colors.white.withOpacity(0.9),
        body: Column(
          children: [
            allScreenStatusBarPadding(context),
            AllPageTitle(text: "Post"),
            Expanded(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: Column(
                  children: [
                    Container(
                      padding:
                          image != null ? EdgeInsets.all(8) : EdgeInsets.zero,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color:
                            image != null ? Colors.white60 : Colors.transparent,
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Flexible(
                                child: TextFormField(
                                  controller: postTextController,
                                  decoration: InputDecoration(
                                      hintText: "Write here",
                                      counterStyle: TextStyle(
                                        height: double.minPositive,
                                      ),
                                      counterText: "",
                                      suffixIcon: Padding(
                                        padding:
                                            const EdgeInsets.only(right: 10),
                                        child: RotationTransition(
                                          turns: new AlwaysStoppedAnimation(
                                              320 / 360),
                                          child: InkWell(
                                            onTap: () {
                                              FocusScope.of(context).unfocus();
                                              showImageOption();
                                            },
                                            child: Icon(
                                              Icons.attachment_outlined,
                                              color: primaryColor,
                                              size: 24,
                                            ),
                                          ),
                                        ),
                                      ),
                                      hintStyle: TextStyle(
                                          color: Color(0xff5D92C1)
                                              .withOpacity(0.8)),
                                      filled: true,
                                      isDense: true,
                                      fillColor:
                                          Colors.grey.shade100.withOpacity(0.5),
                                      errorBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                              color: Colors.red.shade300)),
                                      errorStyle: TextStyle(
                                          color: Colors.red.shade300,
                                          fontSize: 12),
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color(0xff5D92C1)
                                                  .withOpacity(0.05)),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color(0xff5D92C1)
                                                  .withOpacity(0.05)),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color(0xff5D92C1).withOpacity(0.8)),
                                          borderRadius: BorderRadius.circular(10))),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 15),
                                child: InkWell(
                                  onTap: () {
                                    if (postTextController.text.isNotEmpty) {
                                      FocusScope.of(context).unfocus();
                                      context.loaderOverlay.show();
                                      uploadImage();
                                    } else {
                                      showToast("Write some text");
                                    }
                                  },
                                  child: Icon(
                                    Icons.send,
                                    color: primaryColor,
                                  ),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          image != null
                              ? Column(
                                  children: [
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Selected Image :  ",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16),
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                            border:
                                                Border.all(color: primaryColor),
                                          ),
                                          child: Image.file(
                                            image!,
                                            height: 100,
                                            width: 100,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                )
                              : Container()
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Obx(() => Expanded(
                          child: familyGetController.postList.isNotEmpty
                              ? ListView.builder(
                                  padding: EdgeInsets.zero,
                                  shrinkWrap: true,
                                  itemCount:
                                      familyGetController.postList.length,
                                  scrollDirection: Axis.vertical,
                                  physics: BouncingScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return Container(
                                      width: double.infinity,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 10),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(
                                              color: Colors.grey.shade200),
                                          color: Colors.grey.shade100),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              profilePhotoContainer(
                                                  familyGetController
                                                          .postList[index]
                                                      ['memberData']['avatar'],height: 40,width: 40),
                                              SizedBox(
                                                width: 15,
                                              ),
                                              Flexible(
                                                child: Text(
                                                  familyGetController
                                                              .postList[index]
                                                          ['memberData']
                                                      ['memberName'],
                                                  style: allCardSubTextStyle,
                                                ),
                                              )
                                            ],
                                          ),
                                          Divider(),
                                          Text(
                                            familyGetController.postList[index]
                                                ['postTitle'],
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 17),
                                          ),
                                          familyGetController.postList[index]
                                                      ['postUrl'] !=
                                                  null
                                              ? Column(
                                                  children: [
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    InkWell(
                                                      onTap: () {
                                                        pushMethod(
                                                            context,
                                                            ShowImageScreen(
                                                              imageUrl:
                                                                  "$imageUrl=${familyGetController.postList[index]['postUrl']}",
                                                              isAssetImage:
                                                                  false,
                                                            ));
                                                      },
                                                      child: Container(
                                                        alignment:
                                                            Alignment.center,
                                                        child:
                                                            CachedNetworkImage(
                                                                imageUrl:
                                                                    "$imageUrl=${familyGetController.postList[index]['postUrl']}",
                                                                fit: BoxFit
                                                                    .cover,
                                                                height: 180,
                                                                width: 140,
                                                                placeholder: (context,
                                                                        url) =>
                                                                    skeletonContainer(
                                                                        context),
                                                                errorWidget:
                                                                    (context,
                                                                            url,
                                                                            error) =>
                                                                        Icon(
                                                                          Icons
                                                                              .person,
                                                                          color:
                                                                              Colors.black54,
                                                                          size:
                                                                              100,
                                                                        )),
                                                      ),
                                                    )
                                                  ],
                                                )
                                              : Container()
                                        ],
                                      ),
                                    );
                                  })
                              : loading == true
                                  ? Center(
                                      child: circularProgress(),
                                    )
                                  : centerNoRecordText(),
                        ))
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void showImageOption() {
    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        builder: (context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(
                height: 15,
              ),
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                  _getFromGallery(ImageSource.gallery);
                },
                child: modelSheetContainer("Gallery"),
              ),
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                  _getFromGallery(ImageSource.camera);
                },
                child: modelSheetContainer("Camera"),
              )
            ],
          );
        });
  }

  Future<void> _getFromGallery(ImageSource imageSource) async {
    var pickedFile = await ImagePicker().pickImage(source: imageSource);
    if (pickedFile != null) {
      setState(() {
        image = File(pickedFile.path);
      });
      fileName = (image?.path.split('/').last);
      fileExtension = image?.path.split('.') ?? [];
    }
  }

  modelSheetContainer(String text) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      alignment: Alignment.center,
      height: 50,
      width: double.infinity,
      decoration: BoxDecoration(
          border: Border.all(color: primaryColor.withOpacity(0.5), width: 0.8),
          color: primaryColor.withOpacity(0.7),
          borderRadius: BorderRadius.circular(20)),
      child: Text(
        text,
        style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
            fontSize: 19,
            letterSpacing: 1),
      ),
    );
  }

  void uploadImage() {
    showConnectivity(context).then((value) {
      if (value) {
        getStringPref('token').then((token) async {
          if (image != null) {
            var request = http.MultipartRequest(
              'POST',
              Uri.parse("$apiUrl/addPost"),
            );
            Map<String, String> headers = {
              "Authorization": "$token",
              "Content-type": "multipart/form-data",
            };
            request.files.add(
              http.MultipartFile('postImage', image!.readAsBytes().asStream(),
                  image!.lengthSync(),
                  filename: fileName,
                  contentType: new MediaType('image', fileExtension[1])),
            );
            request.fields.addAll({'postTitle': postTextController.text});
            request.headers.addAll(headers);
            print("request: " + request.toString());
            var res = await request.send();
            print("This is response:" + res.toString());
            var response = await http.Response.fromStream(res);
            postAdd(response);
          } else {
            var res = await http.post(Uri.parse("$apiUrl/addPost"),
                body: jsonEncode({'postTitle': postTextController.text}),
                headers: {
                  "Authorization": "$token",
                  'Content-Type': 'application/json',
                });
            postAdd(res);
          }
        });
      } else {
        showToast('Connect to Internet');
      }
    });
  }

  postAdd(var response) {
    var data = jsonDecode(response.body);
    if (data['code'] == 200) {
      showToast('Post Added SuccessFully');
    } else {
      showToast('Try Again After Some Time');
    }
    context.loaderOverlay.hide();

    familyGetController.postList.clear();
    setState(() {
      loading = true;
      image = null;
    });
    postTextController.clear();
    getPostList();
  }

  void getPostList() {
    try {
      getStringPref('token').then((token) async {
        final response =
            await http.get(Uri.parse("$apiUrl/viewPostList"), headers: {
          'Authorization': token,
        });
        var data = jsonDecode(response.body);
        if (data['code'] == 200) {
          familyGetController.postList.addAll(data['data']);
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
