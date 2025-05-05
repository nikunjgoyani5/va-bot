import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:va_bot_admin/core/theme/colors.dart';
import 'package:va_bot_admin/core/theme/text_styles.dart';
import 'package:va_bot_admin/core/utils/common_widgets/common_switch.dart';
import 'package:va_bot_admin/presentation/main/dashboard/controller/dashboard_controller.dart';

class MultiFactor extends StatelessWidget {
  const MultiFactor({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: GetBuilder<DashboardScreenController>(builder: (controller) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Multi-Factor Authentication(MFA)',
              style: TextStyles.medium(
                16,
                fontColor: AppColors.black141414,
              ),
            ),
            Gap(10),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text('MFA Status'),
              titleTextStyle: TextStyles.medium(
                14,
                fontColor: AppColors.black141414,
              ),
              subtitle: Text(
                  'Monitor and Manage Multi-Factor Authentication Settings'),
              subtitleTextStyle: TextStyles.regular(
                11,
                fontColor: AppColors.grey888888,
              ),
              trailing: CommonSwitchButton(
                value: controller.isMultiFactorAuthentication,
                onChanged: (val) {
                  controller.isMultiFactorAuthentication = val;
                  controller.update();
                },
              ),
            ),
            Gap(20),
            Text(
              'Choose Verification method',
              style: TextStyles.medium(
                16,
                fontColor: AppColors.black141414,
              ),
            ),
            Gap(15),
            ListTile(
              minVerticalPadding: 0,
              contentPadding: EdgeInsets.zero,
              title: Text('SMS'),
              titleTextStyle: TextStyles.medium(
                14,
                fontColor: AppColors.black141414,
              ),
              subtitle: Text(
                  'Instant Messaging for Quick and Reliable Communication'),
              subtitleTextStyle: TextStyles.regular(
                11,
                fontColor: AppColors.grey888888,
              ),
              trailing: CommonSwitchButton(
                value: controller.iuSMSEnable,
                onChanged: (val) {
                  controller.iuSMSEnable = val;
                  controller.update();
                },
              ),
              minTileHeight: 24,
            ),
            Divider(
              color: AppColors.whiteF0F0F0,
              thickness: 1,
            ),
            ListTile(
              minVerticalPadding: 0,
              contentPadding: EdgeInsets.zero,
              title: Text('Email'),
              titleTextStyle: TextStyles.medium(
                14,
                fontColor: AppColors.black141414,
              ),
              subtitle: Text('Stay Connected with Seamless Communication'),
              subtitleTextStyle: TextStyles.regular(
                11,
                fontColor: AppColors.grey888888,
              ),
              trailing: CommonSwitchButton(
                value: controller.isEmailEnable,
                onChanged: (val) {
                  controller.isEmailEnable = val;
                  controller.update();
                },
              ),
              minTileHeight: 24,
            ),
            Divider(
              color: AppColors.whiteF0F0F0,
              thickness: 1,
            ),
            ListTile(
              minVerticalPadding: 0,
              contentPadding: EdgeInsets.zero,
              title: Text('Authenticator App'),
              titleTextStyle: TextStyles.medium(
                14,
                fontColor: AppColors.black141414,
              ),
              subtitle:
                  Text('Secure Your Account with Two-Factor Authentication'),
              subtitleTextStyle: TextStyles.regular(
                11,
                fontColor: AppColors.grey888888,
              ),
              minTileHeight: 24,
              trailing: CommonSwitchButton(
                value: controller.isAuthAppEnable,
                onChanged: (val) {
                  controller.isAuthAppEnable = val;
                  controller.update();
                },
              ),
            ),
          ],
        );
      }),
    );
  }
}
