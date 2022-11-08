import 'package:flutter/cupertino.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../getx_controller/getx.dart';

Widget engGujSwitch(RxBool onOff) {
  FamilyGetController familyGetController = Get.put(FamilyGetController());

  return Obx(() => FlutterSwitch(
        width: 65.0,
        height: 34.0,
        valueFontSize: 15.0,
        toggleSize: 15.0,
        value: onOff.value,
        borderRadius: 30.0,
        padding: 8.0,
        showOnOff: true,
        inactiveText: "Eng",
        activeText: "Guj",
        onToggle: (val) {
          familyGetController.selectedDist.value="";
          familyGetController.selectedVillage.value="";
          familyGetController.selectedTaluka.value="";
          onOff.value = val;
        },
      ));
}
