import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:va_bot_admin/core/theme/colors.dart';
import 'package:va_bot_admin/core/theme/text_styles.dart';
import 'package:va_bot_admin/core/utils/common_widgets/common_button.dart';
import 'package:va_bot_admin/core/utils/common_widgets/common_dialog.dart';
import 'package:va_bot_admin/core/utils/common_widgets/common_text_field.dart';
import 'package:va_bot_admin/gen/assets.gen.dart';
import 'package:va_bot_admin/presentation/main/dashboard/controller/dashboard_controller.dart';
import 'package:va_bot_admin/routes/navigation_routes.dart';

class DeleteAccountDialog extends StatelessWidget {
  const DeleteAccountDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonAppDialog(
      child: Container(
        width: 450,
        child: GetBuilder<DashboardScreenController>(builder: (controller) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                    onPressed: null,
                    icon: Icon(
                      Icons.close,
                      color: AppColors.transparent,
                    ),
                  ),
                  Assets.icons.icDeleteAccount.svg(height: 80, width: 80),
                  IconButton(
                    onPressed: () {
                      NavigatorRoute.navigateBack(context: context);
                    },
                    icon: Icon(
                      Icons.close,
                      color: AppColors.greyC3C3C3,
                    ),
                  ),
                ],
              ),
              Gap(20),
              Center(
                child: Text(
                  'Delete Account',
                  style: TextStyles.semiBold(
                    20,
                    fontColor: AppColors.black141414,
                  ),
                ),
              ),
              Gap(5),
              Center(
                child: Text(
                  'Deleting your account is permanent. Do you wish to continue?',
                  textAlign: TextAlign.center,
                  style: TextStyles.regular(
                    16,
                    fontColor: AppColors.grey888888,
                  ),
                ),
              ),
              Gap(24),
              Text(
                'Enter OTP sent to your email',
                style: TextStyles.medium(
                  12,
                  fontColor: AppColors.grey616161,
                ),
              ),
              Gap(10),
              CommonTextField(
                hintText: 'Enter OTP',
                controller: controller.otpController,
              ),
              Gap(24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CommonButton(
                    onPressed: () {
                      NavigatorRoute.navigateBack(context: context);
                    },
                    buttonColor: AppColors.whiteFFFFFF,
                    borderColor: AppColors.whiteE1E1E1,
                    child: Text(
                      'Cancel',
                      style: TextStyles.medium(
                        12,
                        fontColor: AppColors.grey6D6D6D,
                      ),
                    ),
                  ),
                  CommonButton(
                    onPressed: () {
                      NavigatorRoute.navigateBack(context: context);
                      controller.openErrorDialog(context);
                    },
                    buttonColor: AppColors.redEF4444,
                    child: Text(
                      'Confirm Delete',
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
      ),
    );
  }
}
