import 'package:get/get.dart';

class AustionSettingsController extends GetxController {
  List<Map<String, dynamic>> timeSelection = [
    {'buttonName': '5 Sec','value':'5'},
    {'buttonName': '7 Sec','value':'7'},
    {'buttonName': '10 Sec','value':'10'},
  ];
RxInt timeSelectionIndex = 0.obs;

RxBool active = false.obs;


  void onTimeSelection(int index){
    timeSelectionIndex.value=index;
  }
}
