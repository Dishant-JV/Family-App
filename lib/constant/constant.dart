import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:family_app/constant/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../screen/show_image/show_image.dart';


 // String apiUrl="http://192.168.126.198:3008";
String apiUrl="http://192.168.43.124:3008";
String imageUrl="https://drive.google.com/uc?export=view&id";


allScreenStatusBarPadding(BuildContext context) {
  return SizedBox(
    height: MediaQuery.of(context).padding.top + 10,
  );
}

getScreenHeight(BuildContext context, double height) {
  return MediaQuery.of(context).size.height * height;
}

getScreenWidth(BuildContext context, double width) {
  return MediaQuery.of(context).size.width * width;
}

pushRemoveUntilMethod(BuildContext context, Widget name) {
  Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => name),
      (Route<dynamic> route) => false);
}

pushMethod(BuildContext context, Widget name) {
  Navigator.of(context).push(MaterialPageRoute(builder: (context) => name));
}

//color
Color primaryColor = Color(0xff28156E);

//String
String familyName = "Dudhat Parivar";

//text_style
TextStyle familyTextStyle = TextStyle(
    color: primaryColor,
    letterSpacing: 2,
    fontSize: 28,
    fontWeight: FontWeight.w700);

//Profilepage
TextStyle profilePageSubTextStyle = TextStyle(
    color: Colors.grey.shade700, fontSize: 18, fontWeight: FontWeight.w500);
TextStyle profilePageMainTextStyle =
    TextStyle(fontWeight: FontWeight.w500, fontSize: 18);

TextStyle hintTextStyle = TextStyle(
    color: Colors.grey.withOpacity(0.5),
    fontSize: 15,
    fontWeight: FontWeight.w500);
TextStyle textFieldTextStyle =
    TextStyle(color: Colors.grey.shade600, fontWeight: FontWeight.w500);
TextStyle allCardMainTextStyle =
    TextStyle(fontWeight: FontWeight.w500, fontSize: 20);
TextStyle allCardSubTextStyle = TextStyle(
    color: Colors.grey.shade600, fontWeight: FontWeight.w500, fontSize: 16);
TextStyle searchCardTextStyle = TextStyle(
    color: Colors.grey.shade700,
    fontSize: 16,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.5);
TextStyle cityTextStyle = TextStyle(
    color: Colors.blueGrey, fontWeight: FontWeight.w500, fontSize: 15);

//icon

Icon wpIcon = Icon(
  Icons.whatsapp,
  color: Colors.green,
  size: 25,
);
Icon locationIcon = Icon(
  Icons.location_on_sharp,
  size: 24,
  color: primaryColor,
);
Icon forwardIcon =
    Icon(Icons.arrow_forward_ios, size: 18, color: Colors.grey.shade700);

BoxDecoration containerDecoration = BoxDecoration(
  borderRadius: BorderRadius.circular(6.0),
  border: Border.all(color: primaryColor.withOpacity(0.1), width: 0.2),
  color: Colors.grey.shade100,
  shape: BoxShape.rectangle,
  boxShadow: [
    BoxShadow(
        color: Colors.grey.shade200, blurRadius: 3, offset: Offset(3.0, 3.0)),
    BoxShadow(
        color: Colors.grey.shade300, blurRadius: 3, offset: Offset(3.0, 3.0)),
    BoxShadow(
        color: Colors.white,
        spreadRadius: 2.0,
        blurRadius: 3,
        offset: Offset(-3.0, -3.0)),
    BoxShadow(
        color: Colors.white,
        spreadRadius: 2.0,
        blurRadius: 3,
        offset: Offset(-3.0, -3.0)),
  ],
);

callContainer() {
  return Container(
    padding: EdgeInsets.all(4),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: primaryColor.withOpacity(0.5)),
    child: Icon(
      Icons.call,
      color: primaryColor,
      size: 17,
    ),
  );
}

Future<DateTime?> pickedDate(BuildContext context) async {
  final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime.now());
  return picked;
}
showToast(String text) {
  return Fluttertoast.showToast(
    msg: text,
    backgroundColor: primaryColor,
    timeInSecForIosWeb: 2,
    fontSize: 17,
  );
}

textFieldWidget(
    String hint,
    TextEditingController controller,
    bool isObscureText,
    bool isDense,
    Color color,
    TextInputType textInputType,
    Color focusedBorderColor,
    int maxLine,
    bool isMobileNumber) {
  return TextFormField(
    obscureText: isObscureText,
    maxLines: maxLine,
    validator: (value) {
      if (value!.isEmpty) {
        return "Enter Detail";
      }
      if (isMobileNumber == true && value.length != 10) {
        return "Enter 10 digit mobile number";
      }
      return null;
    },
    keyboardType: textInputType,
    maxLength: isMobileNumber == true ? 10 : 200,
    controller: controller,
    decoration: InputDecoration(
        isDense: isDense,
        hintText: hint,
        counterStyle: TextStyle(
          height: double.minPositive,
        ),
        counterText: "",
        hintStyle: TextStyle(color: Color(0xff5D92C1).withOpacity(0.8)),
        filled: true,
        fillColor: color,
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.red.shade300)
        ),
        errorStyle: TextStyle(color: Colors.red.shade300,fontSize: 12),
        border: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xff5D92C1).withOpacity(0.05)),
            borderRadius: BorderRadius.circular(10)),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xff5D92C1).withOpacity(0.05)),
            borderRadius: BorderRadius.circular(10)),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xff5D92C1).withOpacity(0.8)),
            borderRadius: BorderRadius.circular(10))),
  );
}

advertiseDialog(BuildContext context) {
  return Dialog(
    elevation: 0,
    backgroundColor: Colors.transparent,
    child: Container(
      height: getScreenHeight(context, 0.45) + 15,
      alignment: Alignment.center,
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          InkWell(
            onTap: () {
              pushMethod(
                  context,
                  ShowImageScreen(
                    imageUrl: "assets/images/laxicon.jpeg",
                    isAssetImage: true,
                  ));
            },
            child: Container(
              margin: EdgeInsets.only(top: 15, right: 15),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: primaryColor, width: 1.5)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(18),
                child: Image.asset(
                  "assets/images/laxicon.jpeg",
                  height: getScreenHeight(context, 0.45),
                  width: getScreenWidth(context, 0.5),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              padding: EdgeInsets.all(5),
              decoration:
                  BoxDecoration(shape: BoxShape.circle, color: primaryColor),
              child: Icon(
                Icons.cancel_outlined,
                size: 26,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    ),
  );
}

circularProgress() {
  return SizedBox(
    height: 30,
    width: 30,
    child: CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
      strokeWidth: 3.2,
    ),
  );
}

Widget primaryBtn(String text, double horizontalMargin) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: horizontalMargin),
    alignment: Alignment.center,
    height: 43,
    width: double.infinity,
    decoration: BoxDecoration(
      color: primaryColor,
      borderRadius: BorderRadius.circular(10),
      gradient: LinearGradient(
        colors: [primaryColor, primaryColor.withOpacity(0.68), primaryColor],
      ),
    ),
    child: Text(
      text,
      style: TextStyle(
          fontSize: 17,
          letterSpacing: 1.5,
          fontWeight: FontWeight.w600,
          color: Colors.white),
    ),
  );
}

Future<bool> showConnectivity(BuildContext context) async {
  final results = await Connectivity().checkConnectivity();
  if (results == ConnectivityResult.bluetooth ||
      results == ConnectivityResult.none) {
    snackBar(context, "Check Internet Connection !", Colors.red);
    return false;
  } else {
    return true;
  }
}
