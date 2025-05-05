import 'package:flutter/cupertino.dart';
import 'package:gap/gap.dart';
import 'package:va_bot_admin/presentation/authentication/login_screen/controller/login_controller.dart';
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

class LoginDeskTopView extends StatelessWidget {
  const LoginDeskTopView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
      init: LoginController(),
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
                    child: Form(
                      key: controller.loginKey,
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  AppStrings.signInToVABoat,
                                  style: TextStyles.bold(20),
                                ),
                              ],
                            ),
                            spaceH(6),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  AppStrings.welcomeBack,
                                  style: TextStyles.regular(14),
                                ),
                              ],
                            ),
                            Gap(30),
                            Text(
                              AppStrings.emailAddress,
                              style: TextStyles.medium(12),
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
                            Gap(20),
                            Text(
                              AppStrings.password,
                              style: TextStyles.medium(12),
                            ),
                            spaceH(5),
                            CommonTextField(
                              obscureText: controller.isPasswordSecure,
                              hintText: AppStrings.enterPassword,
                              controller: controller.passController,
                              validator: (p0) {
                                if (p0 == null || p0.isEmpty) {
                                  return AppStrings.pleaseEnterPass;
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
                              onSubmitted: (val) {
                                if (controller.loginKey.currentState
                                        ?.validate() ??
                                    false) {
                                  if (controller.isLoading == false) {
                                    controller.signIn(context);
                                  }
                                }
                              },
                            ),
                            spaceH(5),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                InkWell(
                                  onTap: () {
                                    NavigatorRoute.navigateTo(context,
                                        page: AppRoutes.forgotPassword);
                                    controller.emailController.clear();
                                    controller.passController.clear();
                                  },
                                  child: Text(
                                    AppStrings.forgotPass,
                                    style: TextStyles.regular(12,
                                        fontColor: AppColors.grey888888),
                                  ),
                                ),
                              ],
                            ),
                            Gap(15),
                            Row(
                              children: [
                                Expanded(
                                    child: Container(
                                  height: 1,
                                  color: AppColors.greyE5E5E5,
                                )),
                                spaceW(10),
                                Text(
                                  AppStrings.or,
                                  style: TextStyles.regular(11,
                                      fontColor: AppColors.grey888888),
                                ),
                                spaceW(10),
                                Expanded(
                                    child: Container(
                                  height: 1,
                                  color: AppColors.greyE5E5E5,
                                )),
                              ],
                            ),
                            Gap(15),
                            InkWell(
                              onTap: () {
                                controller.googleSignIn(context);
                              },
                              child: Container(
                                alignment: Alignment.center,
                                height: 50,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                    10,
                                  ),
                                  border:
                                      Border.all(color: AppColors.whiteE1E1E1),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      Assets.icons.icGoogle.path,
                                      height: 24,
                                      width: 24,
                                    ),
                                    spaceW(10),
                                    Text(
                                      AppStrings.continueWithGoogle,
                                      style: TextStyles.medium(14,
                                          fontColor: AppColors.grey6D6D6D),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Gap(10),
                            Container(
                              alignment: Alignment.center,
                              height: 50,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                  10,
                                ),
                                border:
                                    Border.all(color: AppColors.whiteE1E1E1),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    Assets.icons.icApple.path,
                                    height: 24,
                                    width: 24,
                                  ),
                                  spaceW(10),
                                  Text(
                                    AppStrings.continueWithApple,
                                    style: TextStyles.medium(14,
                                        fontColor: AppColors.grey6D6D6D),
                                  ),
                                ],
                              ),
                            ),
                            spaceH(30),
                            CommonButton(
                              buttonWidth: context.screenWidth,
                              onPressed: () {
                                if (controller.loginKey.currentState
                                        ?.validate() ??
                                    false) {
                                  if (controller.isLoading == false) {
                                    controller.signIn(context);
                                  }
                                }
                              },
                              child: (controller.isLoading == false)
                                  ? Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          AppStrings.signIn,
                                          style: TextStyles.semiBold(14,
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
                            spaceH(20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  AppStrings.doNotHaveAccount,
                                  style: TextStyles.regular(12,
                                      fontColor: AppColors.grey888888),
                                ),
                                InkWell(
                                  onTap: () {
                                    NavigatorRoute.navigateTo(context,
                                        page: AppRoutes.signUp);
                                    controller.emailController.clear();
                                    controller.passController.clear();
                                  },
                                  child: Text(
                                    AppStrings.createAccount,
                                    style: TextStyles.semiBold(12,
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

                      // Image.asset('assets/images/chats.png'),
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
