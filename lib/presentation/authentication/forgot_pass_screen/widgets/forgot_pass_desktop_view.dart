import 'package:flutter/cupertino.dart';
import 'package:va_bot_admin/presentation/authentication/forgot_pass_screen/controller/forgot_pass_controller.dart';
import 'package:va_bot_admin/core/utils/common_widgets/common_title_with_image.dart';
import 'package:va_bot_admin/core/utils/common_widgets/common_text_field.dart';
import 'package:va_bot_admin/core/utils/common_widgets/common_button.dart';
import 'package:va_bot_admin/core/constant/app_extension.dart';
import 'package:va_bot_admin/core/constant/app_strings.dart';
import 'package:va_bot_admin/routes/navigation_routes.dart';
import 'package:va_bot_admin/core/theme/text_styles.dart';
import 'package:va_bot_admin/core/theme/colors.dart';
import 'package:va_bot_admin/routes/app_routes.dart';
import 'package:va_bot_admin/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';

class ForgotPassDesktopView extends StatelessWidget {
  const ForgotPassDesktopView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ForgotPassController>(
      init: ForgotPassController(),
      builder: (controller) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Stack(
            children: [
              Row(
                children: [
                  Spacer(),
                  Container(
                    alignment: Alignment.center,
                    width: context.screenWidth * 0.3,
                    child: SingleChildScrollView(
                      child: Form(
                        key: controller.forgotPassKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  AppStrings.forgotYorPass,
                                  style: TextStyles.bold(
                                    13,
                                  ),
                                ),
                              ],
                            ),
                            spaceH(6),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  AppStrings.enterEmailBelow,
                                  style: TextStyles.regular(
                                    12,
                                    fontColor: AppColors.grey5D5D5D,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                            spaceH(20),
                            Text(
                              AppStrings.emailAddress,
                              style: TextStyles.semiBold(
                                12,
                              ),
                            ),
                            spaceH(5),
                            CommonTextField(
                              validator: (p0) {
                                if (p0 == null || p0.isEmpty) {
                                  return AppStrings.pleaseEnterEmail;
                                }
                                if (!p0.isEmail) {
                                  return AppStrings.pleaseEnterValidEmail;
                                }
                                return null;
                              },
                              hintText: AppStrings.enterEmail,
                              controller: controller.emailController,
                            ),
                            spaceH(25),
                            CommonButton(
                              buttonWidth: context.screenWidth,
                              onPressed: () {
                                if (controller.forgotPassKey.currentState
                                        ?.validate() ??
                                    false) {
                                  if (controller.isLoading == false) {
                                    controller.sendOTP(context);
                                  }
                                }
                              },
                              child: (controller.isLoading == false)
                                  ? Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          AppStrings.sendInstruction,
                                          style: TextStyles.bold(12,
                                              fontColor: AppColors.whiteFFFFFF),
                                        ),
                                        spaceW(5),
                                        Icon(
                                          Icons.arrow_right,
                                          color: AppColors.whiteFFFFFF,
                                          size: 30,
                                        ),
                                      ],
                                    )
                                  : CupertinoActivityIndicator(
                                      color: AppColors.whiteFFFFFF),
                            ),
                            spaceH(15),
                            GestureDetector(
                              onTap: () {
                                NavigatorRoute.navigateTo(context,
                                    page: AppRoutes.login);
                              },
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  AppStrings.backToLogin,
                                  style: TextStyles.light(11,
                                      fontColor: AppColors.grey888888),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Spacer(),
                  Stack(
                    children: [
                      Image.asset(
                        Assets.images.loginBg.path,
                        width: context.screenWidth * 0.43,
                        height: context.screenHeight,
                        fit: BoxFit.fill,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 4.w, top: 4.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              AppStrings.meetYourAIPowered,
                              style: TextStyles.semiBold(16,
                                  fontColor: AppColors.whiteFFFFFF),
                            ),
                            spaceH(10),
                            Text(
                              AppStrings.generateOffers,
                              style: TextStyles.light(12,
                                  fontColor: AppColors.whiteFFFFFF),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                children: [
                  spaceW(10),
                  CommonTitleWithImage(),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
