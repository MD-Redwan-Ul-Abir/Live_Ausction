import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:live_auction_marketplace/infrastructure/theme/text_styles.dart';
import 'package:live_auction_marketplace/presentation/shared/widgets/appbar/custom_appbar.dart';

import '../../../../infrastructure/navigation/routes.dart';
import '../../../../infrastructure/theme/app_colors.dart';
import '../../../../infrastructure/utils/app_images.dart';
import '../scheduleShow/controllers/schedule_show.controller.dart';

class Onbording2 extends StatelessWidget {
  const Onbording2({super.key});

  @override
  Widget build(BuildContext context) {
    ScheduleShowController scheduleShowController =Get.find<ScheduleShowController>();

    return Scaffold(
      appBar: CustomAppBar(
        title: '',
        onBackPressed: (){
          scheduleShowController.previousStep();
        },
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 24.w),
            child: GestureDetector(
              onTap: () {
                Get.offAllNamed(Routes.MAIN_APP);
              },
              child: SvgPicture.asset(
                AppImages
                    .interfaceDelete1RemoveAddButtonButtonsDeleteStreamlineCore,
                color: AppColors.neutral50,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 9.w, vertical: 9.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              AppImages.liveColab,
              height: 239.h,
              width: double.infinity,
            ),
            Text(
              'Let’s practice going live with\nRehearsal Mode',
              style: AppTextStyles.H6_Regular,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 32.h),
            _rules(
              svgPath: AppImages.gameController,
              data: 'Learn the ropes in Private',
            ),
            SizedBox(height: 16.h),
            _rules(
              svgPath: AppImages
                  .entertainmentVolumeLevelHighSpeakerHighVolumeControlAudioMusicStreamlineCore,
              data: 'Preview your sound and videos',
            ),
            SizedBox(height: 16.h),
            _rules(svgPath: AppImages.offers, data: 'Practice Running actions'),
            SizedBox(height: 100.h),
          ],
        ),
      ),
    );
  }

  Widget _rules({String? data, String? svgPath}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 65.5.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SvgPicture.asset(
            svgPath!,
            height: 24.h,
            width: 24.w,
            color: AppColors.primary1000,
          ),
          SizedBox(width: 12.w),

          Expanded(
            child: Text(
              data ?? "",
              maxLines: 2,
              softWrap: true,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.paragraph_2_Regular.copyWith(
                color: AppColors.neutral200,
                height: 1.5.h,
              ),
            ),
          )

        ],
      ),
    );
  }
}
