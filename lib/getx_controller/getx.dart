import 'package:get/get.dart';

class FamilyGetController extends GetxController {
  //login screen
  RxBool loginLoading = false.obs;

  //OtpVerifyScreen
  RxBool otpVerifyLogin = false.obs;

  //profile page Screen
  RxString profileSelectedBloodGroupValue = "".obs;
  RxBool profileOnOff = false.obs;
  RxMap profileData = {}.obs;

  //edit profile screen

  //My Family screen
  RxList familyDataList = [].obs;
  RxString familySelectedBloodGroupValue = "".obs;
  RxBool myFamilyOnOff = false.obs;

  //home screen
  RxList imageList = [].obs;
}
