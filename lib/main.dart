import 'package:family_app/screen/home/home_screen.dart';
import 'package:family_app/screen/login/login_screen.dart';
import 'package:family_app/screen/login/otp_verify_screen.dart';
import 'package:family_app/screen/splash/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description: 'This channel is used for important notifications.',
    importance: Importance.max,
    playSound: true);
var androidInit = AndroidInitializationSettings("@mipmap/ic_launcher");
var iosInit = IOSInitializationSettings();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  // if (message.notification != null) {
  //   setNotification(message);
  // }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final initFuture = MobileAds.instance.initialize();
  await Firebase.initializeApp();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent, // status bar color
  ));
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: DemoScreen(),
  ));
}

class DemoScreen extends StatefulWidget {
  const DemoScreen({Key? key}) : super(key: key);

  @override
  State<DemoScreen> createState() => _DemoScreenState();
}

class _DemoScreenState extends State<DemoScreen> {
  // late BannerAd banner;
  // bool _isBottomBannerAdLoaded = false;
  //
  // @override
  // void initState() {
  //   super.initState();
  //   setState(() {
  //     // If adState.bannerAdUnitId is null don't create a BannerAd.
  //     banner = BannerAd(
  //       adUnitId: 'ca-app-pub-3940256099942544/6300978111',
  //       size: AdSize.banner,
  //       request: AdRequest(),
  //       listener: BannerAdListener(
  //       onAdLoaded: (_) {
  //           setState(() {
  //         _isBottomBannerAdLoaded = true;
  //       });
  //     },
  //       ),
  //     )..load();
  //   });
  //   // _createBottomBannerAd();
  // }
  late BannerAd _bannerAd;
  bool _isBannerAdReady = false;

  @override
  void initState() {
    super.initState();
    _loadBannerAd();
  }

  @override
  void dispose() {
    super.dispose();
    // _bottomBannerAd.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        height: 50,
        // color: Colors.green,
        child: _isBannerAdReady
            ? Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: _bannerAd.size.width.toDouble(),
                  height: _bannerAd.size.height.toDouble(),
                  child: AdWidget(ad: _bannerAd),
                ),
              )
            : Container(
                height: 50,
                color: Colors.grey,
              ),
      ),
    );
  }

  void _loadBannerAd() {
    _bannerAd = BannerAd(
      adUnitId: "ca-app-pub-3940256099942544/6300978111",
      request: AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (_) {
          setState(() {
            _isBannerAdReady = true;
          });
        },
        onAdFailedToLoad: (ad, err) {
          _isBannerAdReady = false;
          ad.dispose();
        },
      ),
    );

    _bannerAd.load();
  }

}


