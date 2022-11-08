import 'package:family_app/constant/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class GalleryPlayVideo extends StatefulWidget {
  final String videoUrl;
  final String engEventName;
  final String gujEventName;

  const GalleryPlayVideo(
      {Key? key,
      required this.videoUrl,
      required this.engEventName,
      required this.gujEventName})
      : super(key: key);

  @override
  State<GalleryPlayVideo> createState() => _GalleryPlayVideoState();
}

class _GalleryPlayVideoState extends State<GalleryPlayVideo> {
  late YoutubePlayerController controller;

  @override
  void initState() {
    super.initState();
    controller = YoutubePlayerController(initialVideoId: widget.videoUrl);
  }

  @override
  void deactivate() {
    controller.dispose();
    super.deactivate();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
      player: YoutubePlayer(
        controller: controller,
      ),
      builder: (BuildContext, player) {
        return Scaffold(
          backgroundColor: Colors.black,
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              allScreenStatusBarPadding(context),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(width: 10,),
                    Expanded(
                      child: SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            Text(
                              widget.engEventName,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 20),
                            ),
                            Text(
                              " ( ${widget.gujEventName} )",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 20),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Flexible(
                child: Container(
                  alignment: Alignment.center,
                  child: Center(
                    child: player,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
