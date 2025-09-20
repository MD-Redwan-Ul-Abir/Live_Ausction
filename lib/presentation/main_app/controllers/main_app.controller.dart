import 'package:get/get.dart';

import '../../../infrastructure/utils/api_content.dart';
import '../../../infrastructure/utils/secure_storage_helper.dart';
import '../../../main.dart';

class MainAppController extends GetxController {


  static AppController get to => Get.find();
  final currentIndex = 0.obs;
  // RxString currentRole = "".obs;
  late  bool buyerSelected = false;




  @override
  void onInit()   {
    super.onInit();
    //currentRole.value= AppController.to.role.value;

     if(AppController.to.role.value=="buyer"){
       buyerSelected= true;
     }else{
       buyerSelected= false;
     }
  }


  void changeTabIndex(int index) {
    currentIndex.value = index;
  }

}