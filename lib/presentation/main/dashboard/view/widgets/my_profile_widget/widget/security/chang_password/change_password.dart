import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:va_bot_admin/core/theme/colors.dart';
import 'package:va_bot_admin/core/theme/text_styles.dart';
import 'package:va_bot_admin/core/utils/common_widgets/common_button.dart';
import 'package:va_bot_admin/core/utils/common_widgets/common_text_field.dart';
import 'package:va_bot_admin/gen/assets.gen.dart';
import 'package:va_bot_admin/presentation/main/dashboard/controller/dashboard_controller.dart';

class ChangePassword extends StatelessWidget {
  const ChangePassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: GetBuilder<DashboardScreenController>(builder: (controller) {
        return ScrollConfiguration(
          behavior: ScrollBehavior().copyWith(scrollbars: false),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Old Password',
                  style: TextStyles.medium(
                    12,
                    fontColor: AppColors.black141414,
                  ),
                ),
                Gap(10),
                CommonTextField(
                  hintText: 'Old Password',
                  controller: controller.oldPasswordController,
                  enableBorderColor: AppColors.greyE5E5E5,
                  obscureText: !controller.isOldPasswordShow,
                  suffixIcon: IconButton(
                    onPressed: () {
                      controller.isOldPasswordShow =
                          !controller.isOldPasswordShow;
                      controller.update();
                    },
                    icon: (controller.isOldPasswordShow)
                        ? Assets.icons.icCloseEye.svg(height: 20)
                        : Assets.icons.icOpenEye.svg(height: 12),
                  ),
                ),
                Gap(15),
                Text(
                  'New Password',
                  style: TextStyles.medium(
                    12,
                    fontColor: AppColors.black141414,
                  ),
                ),
                Gap(10),
                CommonTextField(
                  hintText: 'New Password',
                  controller: controller.newPasswordController,
                  enableBorderColor: AppColors.greyE5E5E5,
                  obscureText: !controller.isNewPasswordShow,
                  suffixIcon: IconButton(
                    onPressed: () {
                      controller.isNewPasswordShow =
                          !controller.isNewPasswordShow;
                      controller.update();
                    },
                    icon: (controller.isNewPasswordShow)
                        ? Assets.icons.icCloseEye.svg(height: 20)
                        : Assets.icons.icOpenEye.svg(height: 12),
                  ),
                ),
                Gap(15),
                Text(
                  'Confirm New Password',
                  style: TextStyles.medium(
                    12,
                    fontColor: AppColors.black141414,
                  ),
                ),
                Gap(10),
                CommonTextField(
                  hintText: 'Confirm New Password',
                  controller: controller.confirmNewPasswordController,
                  enableBorderColor: AppColors.greyE5E5E5,
                  obscureText: !controller.isConfirmNewPassShow,
                  suffixIcon: IconButton(
                    onPressed: () {
                      controller.isConfirmNewPassShow =
                          !controller.isConfirmNewPassShow;
                      controller.update();
                    },
                    icon: (controller.isConfirmNewPassShow)
                        ? Assets.icons.icCloseEye.svg(height: 20)
                        : Assets.icons.icOpenEye.svg(height: 12),
                  ),
                ),
                Gap(5),
                Row(
                  children: [
                    Container(
                      height: 5,
                      width: 5,
                      decoration: BoxDecoration(
                          color: AppColors.grey888888, shape: BoxShape.circle),
                    ),
                    Gap(10),
                    Text(
                      'Must meet password strength requirements',
                      style: TextStyles.medium(
                        12,
                        fontColor: AppColors.grey888888,
                      ),
                    ),
                  ],
                ),
                Gap(15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CommonButton(
                      onPressed: () {},
                      buttonColor: (controller
                                  .oldPasswordController.text.isEmpty ||
                              controller.newPasswordController.text.isEmpty ||
                              controller
                                  .confirmNewPasswordController.text.isEmpty)
                          ? AppColors.primaryColor.withValues(alpha: 0.5)
                          : AppColors.primaryColor,
                      child: Text(
                        'Update Password',
                        style: TextStyles.medium(
                          12,
                          fontColor: AppColors.whiteFFFFFF,
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}
