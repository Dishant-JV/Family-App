import 'package:flutter/material.dart';

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
              : Image.network(imageUrl)),
    );
  }
}
