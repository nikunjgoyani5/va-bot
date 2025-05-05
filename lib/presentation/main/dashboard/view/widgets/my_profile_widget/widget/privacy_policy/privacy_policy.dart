import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:va_bot_admin/core/theme/colors.dart';
import 'package:va_bot_admin/core/theme/text_styles.dart';
import 'package:va_bot_admin/core/utils/common_widgets/common_button.dart';
import 'package:va_bot_admin/presentation/main/dashboard/controller/dashboard_controller.dart';
import 'package:va_bot_admin/routes/navigation_routes.dart';

class PrivacyPolicyTab extends StatelessWidget {
  const PrivacyPolicyTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: GetBuilder<DashboardScreenController>(builder: (controller) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Data Collection Overview',
              style: TextStyles.medium(
                16,
                fontColor: AppColors.black141414,
              ),
            ),
            Gap(20),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'View & manage collected data',
                        style: TextStyles.medium(14,
                            fontColor: AppColors.black141414),
                      ),
                      Text(
                        'Access and Manage Your Stored Information',
                        style: TextStyles.regular(12,
                            fontColor: AppColors.grey888888),
                      )
                    ],
                  ),
                ),
                Gap(20),
                Icon(Icons.chevron_right, color: AppColors.grey888888),
                Divider(color: AppColors.whiteF0F0F0, thickness: 1),
              ],
            ),
            Gap(20),
            Text(
              'Notification Channels',
              style: TextStyles.medium(
                16,
                fontColor: AppColors.black141414,
              ),
            ),
            Gap(20),
            privacyPolicyWidget(
              title: 'Export Your Data',
              subTitle: 'Download a Copy of Your Information Securely',
              buttonTitle: 'Request Export',
              onPressed: () {},
            ),
            Gap(10),
            privacyPolicyWidget(
              title: 'Delete Account',
              subTitle: 'Permanently Remove Your Profile and Data',
              buttonTitle: 'Delete Account',
              onPressed: () {
                NavigatorRoute.navigateBack(context: context);
                controller.openDeleteAccountDialog(context);
              },
            ),
          ],
        );
      }),
    );
  }

  Widget privacyPolicyWidget({
    required String title,
    required String subTitle,
    required String buttonTitle,
    required void Function() onPressed,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.whiteF8F8F8,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.all(13),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyles.medium(
                    14,
                    fontColor: AppColors.black141414,
                  ),
                ),
                Text(
                  subTitle,
                  style: TextStyles.regular(
                    12,
                    fontColor: AppColors.black141414,
                  ),
                ),
              ],
            ),
          ),
          Gap(20),
          CommonButton(
            onPressed: onPressed,
            buttonColor: AppColors.whiteFFFFFF,
            borderColor: AppColors.whiteE1E1E1,
            child: Text(
              buttonTitle,
              style: TextStyles.medium(
                12,
                fontColor: (buttonTitle.toLowerCase() == 'delete account')
                    ? AppColors.redEF4444
                    : AppColors.black141414,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
