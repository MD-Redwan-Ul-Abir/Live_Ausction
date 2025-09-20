import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:live_auction_marketplace/infrastructure/theme/app_colors.dart';
import 'package:live_auction_marketplace/infrastructure/utils/log_helper.dart';
import 'package:live_auction_marketplace/presentation/auth/successScreen/controllers/success_screen.controller.dart';
import 'package:live_auction_marketplace/presentation/shared/widgets/imagePicker/imagePickerController.dart';

import 'infrastructure/navigation/navigation.dart';
import 'infrastructure/navigation/routes.dart';
import 'infrastructure/utils/secure_storage_helper.dart';

class AppController extends GetxController {
  static AppController get to => Get.find();


  final RxString role = ''.obs;
  final RxString userToken = ''.obs;
  final RxBool isLoggedIn = false.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    role.value = await SecureStorageHelper.getString("userRole");
    LoggerHelper.info(role.value);
  }

  // Methods to update variables
  void setRole(String newRole) {
    role.value = newRole;
  }

  void setUserToken(String token) {
    userToken.value = token;
  }

  void setLoginStatus(bool status) {
    isLoggedIn.value = status;
  }
}

void main() async {
  var initialRoute = await Routes.initialRoute;

  Get.put(AppController(), permanent: true);

  runApp(Phoenix(child: Main(initialRoute)));
}

class Main extends StatelessWidget {
  final String initialRoute;

  Main(this.initialRoute);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(376, 812),
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: initialRoute,
          getPages: Nav.routes,
          theme: ThemeData(
            scaffoldBackgroundColor: AppColors.neutral950,
            appBarTheme: AppBarTheme(
              backgroundColor: AppColors.neutral950,
              elevation: 0,
              scrolledUnderElevation: 0,
            ),
            indicatorColor: AppColors.primary1000
          ),
        );
      },
    );
  }
}




// Column(
// children: [
// CountdownTimer(
// key: _timer1Key,
// initialSeconds: 12,
// size: 48.w,
// progressColor: AppColors.primary1000,
// backgroundColor: AppColors.neutral800,
// strokeWidth: 4.w, // Manual thickness
//
// textStyle: AppTextStyles.captionRegular.copyWith(color: AppColors.neutral50),
// onStart: () => print('Timer 1 started!'),
// onComplete: () => print('Timer 1 completed!'),
// onReset: () => print('Timer 1 reset!'),
// ),
// SizedBox(height: 20.h),
// Row(
// mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// children: [
// ElevatedButton(
// onPressed: () => _timer1Key.currentState?.start(),
// style: ElevatedButton.styleFrom(
// backgroundColor: Colors.green,
// padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
// ),
// child: Text('Start', style: TextStyle(fontSize: 14.sp)),
// ),
// ElevatedButton(
// onPressed: () => _timer1Key.currentState?.pause(),
// style: ElevatedButton.styleFrom(
// backgroundColor: Colors.orange,
// padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
// ),
// child: Text('Pause', style: TextStyle(fontSize: 14.sp)),
// ),
// ElevatedButton(
// onPressed: () => _timer1Key.currentState?.reset(),
// style: ElevatedButton.styleFrom(
// backgroundColor: Colors.red,
// padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
// ),
// child: Text('Reset', style: TextStyle(fontSize: 14.sp)),
// ),
// ],
// ),
// ],
// ),
