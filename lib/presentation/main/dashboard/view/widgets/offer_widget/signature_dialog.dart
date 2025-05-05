import 'package:va_bot_admin/presentation/main/dashboard/controller/dashboard_controller.dart';
import 'package:va_bot_admin/core/utils/common_widgets/common_button.dart';
import 'package:va_bot_admin/core/utils/common_widgets/common_dialog.dart';
import 'package:va_bot_admin/core/constant/app_constant.dart';
import 'package:va_bot_admin/routes/navigation_routes.dart';
import 'package:va_bot_admin/core/theme/text_styles.dart';
import 'package:va_bot_admin/core/theme/colors.dart';
import 'package:va_bot_admin/gen/assets.gen.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:signature/signature.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class SignatureDialog extends StatelessWidget {
  const SignatureDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonAppDialog(
      padding: EdgeInsets.symmetric(horizontal: 1.w, vertical: 1.h),
      child: GetBuilder<DashboardScreenController>(builder: (controller) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Create New Signature',
                  style: TextStyles.medium(
                    16,
                    fontColor: AppColors.black141414,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    NavigatorRoute.navigateBack(context: context);
                  },
                  icon: Icon(
                    Icons.close,
                    color: AppColors.greyC3C3C3,
                  ),
                )
              ],
            ),
            Container(
              height: 6.5.h,
              width: 45.w,
              decoration: BoxDecoration(color: AppColors.whiteF5F5F5),
              padding: EdgeInsets.symmetric(horizontal: 1.w),
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        controller.clearSignatureValues();
                        controller.selectedSignatureIndex = 0;
                        controller.signaturePageController.animateToPage(
                          0,
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeIn,
                        );
                        controller.update();
                      },
                      child: topWidget(
                        svgImagePath: Assets.icons.icDraw.path,
                        title: 'Draw',
                        backgroundColor:
                            (controller.selectedSignatureIndex == 0)
                                ? AppColors.whiteFFFFFF
                                : AppColors.transparent,
                        contentColor: (controller.selectedSignatureIndex == 0)
                            ? AppColors.black141414
                            : AppColors.grey6D6D6D,
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        controller.clearSignatureValues();
                        controller.selectedSignatureIndex = 1;
                        controller.signaturePageController.animateToPage(
                          1,
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeIn,
                        );
                        controller.update();
                      },
                      child: topWidget(
                        svgImagePath: Assets.icons.icImage.path,
                        title: 'Image',
                        backgroundColor:
                            (controller.selectedSignatureIndex == 1)
                                ? AppColors.whiteFFFFFF
                                : AppColors.transparent,
                        contentColor: (controller.selectedSignatureIndex == 1)
                            ? AppColors.black141414
                            : AppColors.grey6D6D6D,
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        controller.clearSignatureValues();
                        controller.selectedSignatureIndex = 2;
                        controller.signaturePageController.animateToPage(
                          2,
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeIn,
                        );
                        controller.update();
                      },
                      child: topWidget(
                        svgImagePath: Assets.icons.icType.path,
                        title: 'Type',
                        backgroundColor:
                            (controller.selectedSignatureIndex == 2)
                                ? AppColors.whiteFFFFFF
                                : AppColors.transparent,
                        contentColor: (controller.selectedSignatureIndex == 2)
                            ? AppColors.black141414
                            : AppColors.grey6D6D6D,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Gap(1.5.h),
            Container(
              height: 50.h,
              width: 45.w,
              decoration: BoxDecoration(
                color: AppColors.whiteF5F5F5,
                borderRadius: BorderRadius.circular(12),
              ),
              child: PageView(
                controller: controller.signaturePageController,
                children: [
                  Container(
                    color: AppColors.whiteF5F5F5,
                    child: Column(
                      children: [
                        Expanded(
                          child: Signature(
                            controller: controller.signatureController,
                            backgroundColor: AppColors.whiteF5F5F5,
                          ),
                        ),
                        Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: () {
                                controller.signatureController.clear();
                              },
                              child: Text(
                                'Clear',
                                style: TextStyles.medium(
                                  12,
                                  fontColor: AppColors.redEF4444,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Gap(5.h),
                      ],
                    ),
                  ),
                  Container(
                    color: AppColors.whiteF5F5F5,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: (controller.pickedSignatureImage != null)
                              ? Image.memory(controller.pickedSignatureImage!,
                                  fit: BoxFit.cover)
                              : Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Assets.icons.icImage
                                        .svg(height: 5.h, width: 5.h),
                                    Text.rich(
                                      textAlign: TextAlign.center,
                                      TextSpan(
                                        text:
                                            'Drag and drop image files (JPG, JPEG or PNG)\n',
                                        style: TextStyles.medium(
                                          14,
                                          fontColor: AppColors.grey888888,
                                        ),
                                        children: [
                                          TextSpan(
                                            text: 'or ',
                                            style: TextStyles.medium(
                                              14,
                                              fontColor: AppColors.grey888888,
                                            ),
                                          ),
                                          TextSpan(
                                            text: 'browse file',
                                            style: TextStyles.medium(
                                              14,
                                              fontColor: AppColors.black141414,
                                            ),
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = () {
                                                controller.pickSignatureImage();
                                              },
                                          ),
                                        ],
                                      ),
                                    ),
                                    Gap(2.h),
                                  ],
                                ),
                        ),
                        (controller.pickedSignatureImage != null)
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      controller.pickSignatureImage();
                                    },
                                    child: Text(
                                      'Change Image',
                                      style: TextStyles.medium(
                                        12,
                                        fontColor: AppColors.redEF4444,
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : SizedBox.shrink(),
                        Gap(5.h),
                      ],
                    ),
                  ),
                  Container(
                    color: AppColors.whiteF5F5F5,
                    child: Column(
                      children: [
                        Expanded(
                          child: RepaintBoundary(
                            key: controller.signatureGlobalKey,
                            child: Container(
                              color: AppColors.transparent,
                              child: Center(
                                child: Text(
                                  controller.signatureEditingController.text,
                                  style: TextStyles.medium(
                                    13,
                                    fontColor: AppColors.black141414,
                                    fontFamily:
                                        controller.selectedSignatureFontFamily,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        TextField(
                          controller: controller.signatureEditingController,
                          textAlign: TextAlign.center,
                          style: TextStyles.medium(
                            11,
                            fontColor: AppColors.black141414,
                          ),
                          onChanged: (val) {
                            controller.update();
                          },
                          cursorColor: AppColors.primaryColor,
                          decoration: InputDecoration(
                            hintText: 'Type your signature here',
                            hintStyle: TextStyles.medium(
                              14,
                              fontColor: AppColors.grey888888,
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: AppColors.whiteEBEBEB, width: 2),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: AppColors.whiteEBEBEB, width: 2),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            PopupMenuButton<int>(
                              color: AppColors.whiteFFFFFF,
                              onOpened: () {},
                              itemBuilder: (context) {
                                return [
                                  PopupMenuItem(
                                    height: 4.h,
                                    child: Text(
                                      controller.signatureEditingController.text
                                              .isNotEmpty
                                          ? controller
                                              .signatureEditingController.text
                                          : 'Signature',
                                      style: TextStyles.medium(11,
                                          fontColor: AppColors.black141414,
                                          fontFamily: dancingScriptFonts),
                                    ),
                                    onTap: () async {
                                      controller.selectedSignatureFontFamily =
                                          dancingScriptFonts;
                                      controller.update();
                                    },
                                  ),
                                  PopupMenuDivider(),
                                  PopupMenuItem(
                                    height: 4.h,
                                    child: Text(
                                      controller.signatureEditingController.text
                                              .isNotEmpty
                                          ? controller
                                              .signatureEditingController.text
                                          : 'Signature',
                                      style: TextStyles.medium(11,
                                          fontColor: AppColors.black141414,
                                          fontFamily: autografFonts),
                                    ),
                                    onTap: () async {
                                      controller.selectedSignatureFontFamily =
                                          autografFonts;
                                      controller.update();
                                    },
                                  ),
                                ];
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'Change Style',
                                    style: TextStyles.medium(12,
                                        fontColor: AppColors.black141414),
                                  ),
                                  Gap(0.5.w),
                                  Assets.icons.icDropdownArrow.svg(
                                    height: 10,
                                    width: 10,
                                    colorFilter: ColorFilter.mode(
                                        AppColors.black141414, BlendMode.srcIn),
                                  ),
                                ],
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                controller.signatureEditingController.clear();
                                controller.update();
                              },
                              child: Text(
                                'Clear',
                                style: TextStyles.medium(
                                  12,
                                  fontColor: AppColors.redEF4444,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Gap(5.h),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Gap(1.5.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CommonButton(
                  onPressed: () {
                    controller.onSignatureCancelPressed(context);
                  },
                  borderColor: AppColors.whiteE1E1E1,
                  buttonColor: AppColors.whiteFFFFFF,
                  child: Text(
                    'Cancel',
                    style: TextStyles.medium(
                      12,
                      fontColor: AppColors.black141414,
                    ),
                  ),
                ),
                CommonButton(
                  onPressed: () {
                    controller.onSignatureApplyPressed(context);
                  },
                  child: Text(
                    'Apply',
                    style: TextStyles.medium(
                      12,
                      fontColor: AppColors.whiteFFFFFF,
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      }),
    );
  }

  topWidget({
    required String svgImagePath,
    required String title,
    required Color backgroundColor,
    required Color contentColor,
  }) {
    return Container(
      height: 5.h,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            svgImagePath,
            colorFilter: ColorFilter.mode(
              contentColor,
              BlendMode.srcIn,
            ),
          ),
          Gap(1.w),
          Text(
            title,
            style: TextStyles.medium(
              12,
              fontColor: contentColor,
            ),
          ),
        ],
      ),
    );
  }
}
