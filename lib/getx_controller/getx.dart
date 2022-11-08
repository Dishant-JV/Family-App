import 'package:get/get.dart';

class FamilyGetController extends GetxController {

  RxList villageList=[].obs;
  RxString selectedVillage="".obs;

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

  //searchMember
  RxList searchMemberList=[].obs;
  RxList distList=[].obs;
  RxList talukaList=[].obs;

  RxString selectedDist="".obs;
  RxString selectedTaluka="".obs;
  RxBool searchMemberOnOff = false.obs;


  //business screen
  RxList businessNameList=[].obs;
  RxBool businessOnOff = false.obs;
  RxList businessDetailList=[].obs;
  RxBool businessDetailOnOff = false.obs;

  //commitee member screen

  RxList commiteeMemberList=[].obs;
  RxBool commiteeMemberOnOff = false.obs;

  //event screen
  RxList allEventList=[].obs;
  RxBool allEventOnOff = false.obs;

  RxList eventComiteeList=[].obs;
  RxBool eventDetailOnOff = false.obs;

  RxBool commiteeDetailListOnOff = false.obs;

  //donor screen

  RxList donationTypeList=[].obs;
  RxBool donationTypeOnOff = false.obs;

  RxList donarList=[].obs;
  RxBool donarOnOff = false.obs;

  //Gallery

  RxList galleryImageAlbum=[].obs;
  RxList galleryVideoAlbum=[].obs;
  RxList galleryImage=[].obs;
  RxList galleryVideoThumbnail=[].obs;





















}
