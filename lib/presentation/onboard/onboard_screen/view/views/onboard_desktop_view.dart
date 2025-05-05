import 'package:va_bot_admin/presentation/onboard/onboard_screen/controller/onboard_controller.dart';
import 'package:va_bot_admin/core/utils/common_widgets/common_appbar.dart';
import 'package:va_bot_admin/core/utils/common_widgets/common_button.dart';
import 'package:va_bot_admin/core/constant/app_strings.dart';
import 'package:va_bot_admin/core/theme/text_styles.dart';
import 'package:va_bot_admin/core/theme/colors.dart';
import 'package:va_bot_admin/gen/assets.gen.dart';

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class OnBoardDesktopView extends StatelessWidget {
  OnBoardDesktopView({super.key});
  final OnBoardController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppbar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Assets.icons.vaBotLogo.svg(
                  height: 38,
                  width: 38,
                ),
                Gap(0.8.w),
                Text(
                  AppStrings.vaBoat,
                  style: TextStyles.medium(
                    16,
                    fontColor: AppColors.black141414,
                  ),
                ),
              ],
            ),
            Expanded(
              child: Center(
                child: GetBuilder<OnBoardController>(builder: (ctrl) {
                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(controller.steps.length, (index) {
                        return Row(
                          children: [
                            Row(
                              children: [
                                Container(
                                  height: 26,
                                  width: 26,
                                  decoration: BoxDecoration(
                                    color: controller.currentStep == index
                                        ? AppColors.primaryColor
                                        : (index < controller.currentStep)
                                            ? AppColors.green33B764
                                            : AppColors.whiteF5F5F5,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Center(
                                    child: (index < controller.currentStep)
                                        ? Assets.icons.icChecked
                                            .svg(fit: BoxFit.scaleDown)
                                        : Text(
                                            "${index + 1}",
                                            style: TextStyles.medium(
                                              12,
                                              fontColor:
                                                  (controller.currentStep ==
                                                          index)
                                                      ? AppColors.whiteFFFFFF
                                                      : AppColors.grey888888,
                                            ),
                                          ),
                                  ),
                                ),
                                Gap(0.8.w),
                                Text(
                                  controller.steps[index],
                                  style: TextStyles.semiBold(
                                    13,
                                    fontColor: controller.currentStep >= index
                                        ? AppColors.black141414
                                        : AppColors.grey888888,
                                  ),
                                ),
                              ],
                            ),
                            if (index < controller.steps.length - 1)
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8),
                                child: Icon(Icons.chevron_right,
                                    color: Colors.grey),
                              ),
                          ],
                        );
                      }),
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Divider(
              color: AppColors.whiteF0F0F0,
              thickness: 1,
            ),
            Expanded(
              child: GetBuilder<OnBoardController>(
                builder: (ctrl) {
                  /// ===== ===== ===== SIZE TRANSITION ===== ===== ===== ///
                  /*return AnimatedSwitcher(
                    duration: Duration(milliseconds: 300),
                    transitionBuilder:
                        (Widget child, Animation<double> animation) {
                      return SizeTransition(
                        sizeFactor: animation,
                        axis: Axis.horizontal,
                        child: child,
                      );
                    },
                    child: controller.getStepWidget(controller.currentStep),
                  );*/

                  /// ===== ===== ===== FADE ANIMATION ===== ===== ===== ///
                  return AnimatedSwitcher(
                    duration: Duration(milliseconds: 300),
                    transitionBuilder:
                        (Widget child, Animation<double> animation) {
                      return FadeTransition(
                        opacity: animation,
                        child: child,
                      );
                    },
                    child: controller.getStepWidget(controller.currentStep),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 10.h,
        decoration: BoxDecoration(color: AppColors.transparent),
        child: GetBuilder<OnBoardController>(builder: (ctrl) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Divider(
                      color: (controller.currentStep >= 0)
                          ? AppColors.primaryColor
                          : AppColors.whiteF5F5F5,
                      thickness: 5.sp,
                    ),
                  ),
                  Gap(0.3.w),
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          child: Divider(
                            color: (controller.currentStep > 0)
                                ? AppColors.primaryColor
                                : AppColors.whiteF5F5F5,
                            thickness: 5.sp,
                          ),
                        ),
                        Expanded(
                          child: Divider(
                            color: (controller.currentStep > 0 &&
                                    controller.twoCurrentPage > 1)
                                ? AppColors.primaryColor
                                : AppColors.whiteF5F5F5,
                            thickness: 5.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Gap(0.3.w),
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          child: Divider(
                            color: (controller.currentStep > 1)
                                ? AppColors.primaryColor
                                : AppColors.whiteF5F5F5,
                            thickness: 5.sp,
                          ),
                        ),
                        Expanded(
                          child: Divider(
                            color: (controller.currentStep > 1 &&
                                    controller.threeCurrentPage > 1)
                                ? AppColors.primaryColor
                                : AppColors.whiteF5F5F5,
                            thickness: 5.sp,
                          ),
                        ),
                        Expanded(
                          child: Divider(
                            color: (controller.currentStep > 1 &&
                                    controller.threeCurrentPage > 2)
                                ? AppColors.primaryColor
                                : AppColors.whiteF5F5F5,
                            thickness: 5.sp,
                          ),
                        ),
                        Expanded(
                          child: Divider(
                            color: (controller.currentStep > 1 &&
                                    controller.threeCurrentPage > 3)
                                ? AppColors.primaryColor
                                : AppColors.whiteF5F5F5,
                            thickness: 5.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Gap(0.3.w),
                  Expanded(
                    child: Divider(
                      color: (controller.currentStep > 2)
                          ? AppColors.primaryColor
                          : AppColors.whiteF5F5F5,
                      thickness: 5.sp,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CommonButton(
                      onPressed: () {
                        if (controller.currentStep != 3) {
                          controller
                              .changeStepIndex(controller.currentStep + 1);
                        }
                      },
                      buttonColor: AppColors.whiteFFFFFF,
                      borderColor: AppColors.whiteE1E1E1,
                      child: Text(
                        AppStrings.skipIt,
                        style: TextStyles.medium(
                          12,
                          fontColor: AppColors.grey6D6D6D,
                        ),
                      ),
                    ),
                    CommonButton(
                      onPressed: () {
                        if (controller.currentStep == 0) {
                          controller
                              .changeStepIndex(controller.currentStep + 1);
                        } else if (controller.currentStep == 1) {
                          if (controller.twoPageController.page == 1) {
                            controller
                                .changeStepIndex(controller.currentStep + 1);
                          }
                        } else if (controller.currentStep == 2) {
                          if (controller.threePageController.page ==
                                  3 /* &&
                              (controller.threeFormKe3.currentState
                                      ?.validate() ??
                                  false)*/
                              ) {
                            controller
                                .changeStepIndex(controller.currentStep + 1);
                          }
                        } else {
                          if (controller.currentStep != 3) {
                            controller
                                .changeStepIndex(controller.currentStep + 1);
                          }
                        }
                        controller.update();
                      },
                      buttonColor: (controller.currentStep == 0)
                          ? AppColors.primaryColor
                          : (controller.currentStep == 1 &&
                                  controller.twoCurrentPage == 1)
                              ? AppColors.primaryColor.withValues(alpha: 0.5)
                              : (controller.currentStep == 2 &&
                                      (controller.threeCurrentPage == 1 ||
                                          controller.threeCurrentPage == 2 ||
                                          controller.threeCurrentPage == 3))
                                  ? AppColors.primaryColor
                                      .withValues(alpha: 0.5)
                                  : AppColors.primaryColor,
                      // borderColor: (controller.currentStep == 0)
                      //     ? AppColors.primaryColor.withValues(alpha: 0.5)
                      //     : (controller.currentStep == 1 &&
                      //             controller.twoCurrentPage == 1)
                      //         ? AppColors.primaryColor.withValues(alpha: 0.5)
                      //         : (controller.currentStep == 2 &&
                      //                 (controller.threeCurrentPage == 1 ||
                      //                     controller.threeCurrentPage == 2 ||
                      //                     controller.threeCurrentPage == 3))
                      //             ? AppColors.primaryColor
                      //                 .withValues(alpha: 0.5)
                      //             : AppColors.primaryColor
                      //                 .withValues(alpha: 0.5),
                      child: Text(
                        (controller.currentStep == 3)
                            ? AppStrings.vaBotInAction
                            : (controller.currentStep == 2)
                                ? AppStrings.finishStartWithVABot
                                : AppStrings.continuE,
                        style: TextStyles.medium(
                          12,
                          fontColor: AppColors.whiteF5F5F5,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(),
            ],
          );
        }),
      ),
    );
  }
}
