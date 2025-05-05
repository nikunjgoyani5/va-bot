import 'package:va_bot_admin/core/utils/common_widgets/common_button.dart';
import 'package:va_bot_admin/core/constant/app_strings.dart';
import 'package:va_bot_admin/routes/navigation_routes.dart';
import 'package:va_bot_admin/core/theme/text_styles.dart';
import 'package:va_bot_admin/services/pref_service.dart';
import 'package:va_bot_admin/core/theme/colors.dart';
import 'package:va_bot_admin/routes/app_routes.dart';
import 'package:va_bot_admin/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:gap/gap.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Assets.icons.vaBotLogo.svg(
                  height: 42,
                  width: 42,
                ),
                Gap(0.8.w),
                Text(
                  AppStrings.vaBoat,
                  style: TextStyles.medium(
                    15,
                    fontColor: AppColors.black141414,
                  ),
                ),
              ],
            ),
            Gap(1.h),
            Text(
              AppStrings.welcomeToVABot,
              style: TextStyles.bold(20, fontColor: AppColors.black141414),
            ),
            Gap(1.h),
            Text(
              AppStrings.manageCallsMeetingsTrackOffers,
              textAlign: TextAlign.center,
              style: TextStyles.regular(15, fontColor: AppColors.grey5D5D5D),
            ),
            Gap(2.h),
            Assets.images.welcomeImage.image(height: 50.h, width: 60.w),
            Gap(2.h),
            CommonButton(
              onPressed: () {
                NavigatorRoute.navigateTo(
                  context,
                  page: (PrefService.getString(PrefService.token).isEmpty)
                      ? AppRoutes.login
                      : AppRoutes.dashboard,
                );
              },
              child: Text(
                AppStrings.letsStart,
                style: TextStyles.medium(15, fontColor: AppColors.whiteFFFFFF),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
