import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:environment_sensors/environment_sensors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:family_app/constant/constant.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';

class DemoProvider2 extends StatefulWidget {
  const DemoProvider2({Key? key}) : super(key: key);

  @override
  State<DemoProvider2> createState() => _DemoProvider2State();
}

class _DemoProvider2State extends State<DemoProvider2> {
  double val = 0;
  int curIndex = 0;
  List<Color> colors = [
    Colors.black,
    Colors.red,
    Colors.orange,
    Colors.pink,
    Colors.blue,
    Colors.yellow,
    Colors.green,
    Colors.indigo
  ];
  XFile? _pickedFile;
  CroppedFile? _croppedFile;
  ScreenshotController screenshotController = ScreenshotController();
  final environmentSensors = EnvironmentSensors();

  snak(String text) {
    var snackBar = SnackBar(content: Text(text));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: InkWell(onTap: () async {
          print("pressed");
         await environmentSensors.humidity.listen((pressure) {
            print(pressure);
          });
        }, child: Text("Image Cropper")),
        backgroundColor: primaryColor,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: InkWell(
              onTap: () {
                setState(() {
                  _croppedFile = null;
                });
              },
              child: Icon(
                Icons.lock_reset,
                size: 30,
              ),
            ),
          ),
          InkWell(
              onTap: () async {
                if (_croppedFile != null || _pickedFile != null) {
                  screenshot();
                } else {
                  snak("Upload Image");
                }
              },
              child: Icon(
                Icons.download,
                size: 30,
              ))
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Screenshot(
                child: _pickedFile == null
                    ? ElevatedButton(
                        onPressed: () {
                          _uploadImage();
                        },
                        child: Text("UPLOAD"))
                    : _croppedFile == null
                        ? Image.file(
                            File(_pickedFile?.path ?? ""),
                            color: colors[curIndex].withOpacity(val / 100),
                            fit: BoxFit.cover,
                            colorBlendMode: BlendMode.color,
                            filterQuality: FilterQuality.high,
                            height: 500,
                          )
                        : Image.file(
                            File(_croppedFile?.path ?? ""),
                            color: colors[curIndex].withOpacity(val / 100),
                            fit: BoxFit.cover,
                            colorBlendMode: BlendMode.color,
                            filterQuality: FilterQuality.high,
                            height: 500,
                          ),
                controller: screenshotController),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 50,
              child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: colors.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        setState(() {
                          curIndex = index;
                          val = 0;
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 5),
                        height: curIndex == index ? 50 : 40,
                        width: curIndex == index ? 50 : 40,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: colors[index]),
                      ),
                    );
                  }),
            ),
            SizedBox(
              width: 5,
            ),
            Slider(
                value: val,
                min: 0,
                max: 100,
                onChanged: (value) {
                  val = value;
                  setState(() {});
                }),
            SizedBox(height: 5),
            InkWell(
                onTap: () {
                  _cropImage();
                },
                child: Icon(
                  Icons.crop,
                  size: 35,
                ))
          ],
        ),
      ),
    );
  }

  Future<void> _cropImage() async {
    final croppedFile = await ImageCropper().cropImage(
      sourcePath: _pickedFile!.path,
      compressFormat: ImageCompressFormat.jpg,
      compressQuality: 100,
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Crop Image',
          toolbarColor: primaryColor,
          toolbarWidgetColor: Colors.white,
          hideBottomControls: true,
          initAspectRatio: CropAspectRatioPreset.original,
          statusBarColor: primaryColor,
        ),
        IOSUiSettings(
          title: 'Cropper',
        ),
      ],
    );
    if (croppedFile != null) {
      setState(() {
        _croppedFile = croppedFile;
      });
    }
  }

  Future<void> _uploadImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _pickedFile = pickedFile;
      });
    }
  }

  Future<void> saveImage(Uint8List bytes) async {
    final time = DateTime.now()
        .toIso8601String()
        .replaceAll(".", "-")
        .replaceAll(":", "-");
    await ImageGallerySaver.saveImage(bytes,
        name: "Screenshot - ${time}", quality: 100);
    snak("Image downloaded");
  }

  Future<void> screenshot() async {
    await screenshotController.capture().then((Uint8List? bytes) async {
      if (bytes != null) {
        saveImage(bytes);
      } else {
        print("Else");
      }
    });
  }
}
