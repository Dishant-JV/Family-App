import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:zoom_pinch_overlay/zoom_pinch_overlay.dart';

import '../../constant/constant.dart';

class ShowImageScreen extends StatelessWidget {
  final String imageUrl;
  final bool? isAssetImage;

  const ShowImageScreen({Key? key, required this.imageUrl, this.isAssetImage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: isAssetImage == true
            ? Image.asset(imageUrl)
            : ZoomOverlay(
                modalBarrierColor: Colors.black12,
                minScale: 0.5,
                maxScale: 3.0,
                animationCurve: Curves.fastOutSlowIn,
                animationDuration: Duration(milliseconds: 300),
                twoTouchOnly: true,
                // Defaults to false
                child: CachedNetworkImage(
                    imageUrl: imageUrl,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => skeletonContainer(context),
                    errorWidget: (context, url, error) =>
                        Image.asset('assets/images/noImage.png')),
              ),
      ),
    );
  }
}
