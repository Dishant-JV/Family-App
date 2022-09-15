import 'package:family_app/screen/goole%20map/goole_map.dart';
import 'package:family_app/screen/home/home_screen.dart';
import 'package:family_app/screen/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'demo/demo_provide.dart';
import 'demo/demo_provider1.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent, // status bar color
  ));
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: DemoProvider2(),
  ));
}
