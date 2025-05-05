import 'package:va_bot_admin/presentation/authentication/create_new_pass_screen/controller/create_new_pass_controller.dart';
import 'package:va_bot_admin/core/utils/common_widgets/common_title_with_image.dart';
import 'package:va_bot_admin/core/utils/common_widgets/common_text_field.dart';
import 'package:va_bot_admin/core/utils/common_widgets/common_button.dart';
import 'package:va_bot_admin/core/constant/app_extension.dart';
import 'package:va_bot_admin/core/constant/app_strings.dart';
import 'package:va_bot_admin/routes/navigation_routes.dart';
import 'package:va_bot_admin/core/theme/text_styles.dart';
import 'package:va_bot_admin/routes/app_routes.dart';
import 'package:va_bot_admin/core/theme/colors.dart';
import 'package:va_bot_admin/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';

class CreateNewPassDesktopView extends StatelessWidget {
  final String? email;
  const CreateNewPassDesktopView({super.key, this.email});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CreateNewPassController>(
      init: CreateNewPassController(),
      initState: (i) {
        Future.delayed(
          Duration.zero,
          () {
            CreateNewPassController controller = Get.find();
            controller.email = email;
          },
        );
      },
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
                        key: controller.createNewPassKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  AppStrings.createNewPass,
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
                                  AppStrings.chooseNewPAss,
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
                              AppStrings.newPass,
                              style: TextStyles.semiBold(
                                12,
                              ),
                            ),
                            spaceH(5),
                            CommonTextField(
                              obscureText: controller.isPasswordSecure,
                              hintText: AppStrings.enterNewPass,
                              controller: controller.passwordController,
                              validator: (p0) {
                                if (p0 == null || p0.isEmpty) {
                                  return AppStrings.pleaseEnterNewPass;
                                } else if (p0.length < 8) {
                                  return AppStrings.pleaseEnter8Chars;
                                }

                                return null;
                              },
                              suffixIcon: IconButton(
                                onPressed: () {
                                  if (controller.isPasswordSecure) {
                                    controller.isPasswordSecure = false;
                                  } else {
                                    controller.isPasswordSecure = true;
                                  }
                                  controller.update();
                                },
                                icon: (controller.isPasswordSecure == false)
                                    ? Assets.icons.icCloseEye.svg(
                                        colorFilter: const ColorFilter.mode(
                                            AppColors.grey6D6D6D,
                                            BlendMode.srcIn),
                                      )
                                    : Assets.icons.icOpenEye.svg(),
                              ).paddingOnly(right: 10),
                            ),
                            spaceH(12),
                            Text(
                              AppStrings.confirmNewPass,
                              style: TextStyles.semiBold(
                                12,
                              ),
                            ),
                            spaceH(5),
                            CommonTextField(
                              obscureText: controller.isConfirmPasswordSecure,
                              hintText: AppStrings.enterYourConfirmPass,
                              controller: controller.confirmPasswordController,
                              validator: (p0) {
                                if (p0 == null || p0.isEmpty) {
                                  return AppStrings.pleaseEnterConfirmPass;
                                } else if (p0 !=
                                    controller.passwordController.text) {
                                  return AppStrings.passDoesNotMatch;
                                }

                                return null;
                              },
                              suffixIcon: IconButton(
                                onPressed: () {
                                  if (controller.isConfirmPasswordSecure) {
                                    controller.isConfirmPasswordSecure = false;
                                  } else {
                                    controller.isConfirmPasswordSecure = true;
                                  }
                                  controller.update();
                                },
                                icon: (controller.isConfirmPasswordSecure ==
                                        false)
                                    ? Assets.icons.icCloseEye.svg(
                                        colorFilter: const ColorFilter.mode(
                                            AppColors.grey6D6D6D,
                                            BlendMode.srcIn),
                                      )
                                    : Assets.icons.icOpenEye.svg(),
                              ).paddingOnly(right: 10),
                            ),
                            spaceH(25),
                            CommonButton(
                              buttonWidth: context.screenWidth,
                              onPressed: () {
                                if (controller.createNewPassKey.currentState
                                        ?.validate() ==
                                    true) {
                                  if (controller.isLoading == false) {
                                    controller.resetPassword(context);
                                  }
                                }
                              },
                              child: (controller.isLoading == false)
                                  ? Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          AppStrings.changePass,
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
                                  : CircularProgressIndicator(),
                            ),
                            spaceH(15),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  AppStrings.rememberPass,
                                  style: TextStyles.regular(11.5,
                                      fontColor: AppColors.grey888888),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    NavigatorRoute.navigateTo(context,
                                        page: AppRoutes.login);
                                  },
                                  child: Text(
                                    AppStrings.login,
                                    style: TextStyles.bold(11.5,
                                        fontColor: AppColors.black141414),
                                  ),
                                ),
                              ],
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
