import 'package:flutter/cupertino.dart';
import 'package:va_bot_admin/presentation/authentication/otp_screen/controller/otp_controller.dart';
import 'package:va_bot_admin/core/utils/common_widgets/common_title_with_image.dart';
import 'package:va_bot_admin/core/utils/common_widgets/common_button.dart';
import 'package:va_bot_admin/core/constant/app_extension.dart';
import 'package:va_bot_admin/core/constant/app_strings.dart';
import 'package:va_bot_admin/core/theme/text_styles.dart';
import 'package:va_bot_admin/core/theme/colors.dart';
import 'package:va_bot_admin/gen/assets.gen.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';

class OtpDesktopView extends StatelessWidget {
  final String? email;
  final String? page;
  const OtpDesktopView({super.key, this.email, this.page});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OtpController>(
      init: OtpController(),
      initState: (c) {
        Future.delayed(
          Duration.zero,
          () {
            OtpController controller = Get.find();
            controller.email = email;
            controller.page = page;
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
                        key: controller.otpKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  AppStrings.checkMail,
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
                                  AppStrings.enter6DigitCode,
                                  style: TextStyles.regular(
                                    12,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  email ?? '',
                                  style: TextStyles.regular(
                                    12,
                                  ),
                                ),
                              ],
                            ),
                            spaceH(20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Pinput(
                                  separatorBuilder: (index) {
                                    if (index == 2) {
                                      return Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 10),
                                        height: 2,
                                        width: 5,
                                        color: AppColors.black141414,
                                      );
                                    } else {
                                      return SizedBox(
                                        width: 10,
                                      );
                                    }
                                  },
                                  errorTextStyle:
                                      TextStyle(height: 0, color: Colors.red),
                                  controller: controller.otpController,
                                  length: 6,
                                  validator: (p0) {
                                    if (p0 == null || p0.isEmpty) {
                                      return AppStrings.pleaseEnterOtp;
                                    } else if (p0.length < 6) {
                                      return AppStrings.pleaseEnter6Digit;
                                    }

                                    return null;
                                  },
                                  onCompleted: (value) {},
                                  keyboardType: TextInputType.number,
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  defaultPinTheme: PinTheme(
                                    width: 43,
                                    height: 43,
                                    textStyle: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          color: AppColors.whiteE1E1E1),
                                    ),
                                  ),
                                  focusedPinTheme: PinTheme(
                                    width: 50,
                                    height: 50,
                                    textStyle: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          color: AppColors.whiteE1E1E1),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            spaceH(7),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  AppStrings.resendOtp,
                                  style: TextStyles.regular(11.5,
                                      fontColor: AppColors.grey888888),
                                ),
                                Text(
                                  "${controller.formatTime(controller.secondsRemaining)}",
                                  style: TextStyles.bold(11.5,
                                      fontColor: AppColors.black141414),
                                ),
                              ],
                            ),
                            spaceH(25),
                            CommonButton(
                                buttonWidth: context.screenWidth,
                                onPressed: () {
                                  if (controller.otpKey.currentState
                                          ?.validate() ==
                                      true) {
                                    if (controller.isLoading == false) {
                                      controller.verifyOTP(context);
                                    }
                                  }
                                },
                                child: (controller.isLoading == false)
                                    ? Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            AppStrings.submit,
                                            style: TextStyles.bold(12,
                                                fontColor:
                                                    AppColors.whiteFFFFFF),
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
                                        color: AppColors.whiteFFFFFF)),
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
