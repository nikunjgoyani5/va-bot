import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:va_bot_admin/core/theme/colors.dart';
import 'package:va_bot_admin/core/theme/text_styles.dart';
import 'package:va_bot_admin/presentation/main/dashboard/controller/dashboard_controller.dart';

class AccountRecovery extends StatelessWidget {
  const AccountRecovery({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: GetBuilder<DashboardScreenController>(builder: (controller) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Account Recovery',
              style: TextStyles.medium(
                16,
                fontColor: AppColors.black141414,
              ),
            ),
            Gap(15),
            ListTile(
              onTap: () {},
              minVerticalPadding: 0,
              contentPadding: EdgeInsets.zero,
              title: Text('Recovery Phone'),
              titleTextStyle: TextStyles.medium(
                14,
                fontColor: AppColors.black141414,
              ),
              subtitle:
                  Text('Ensure Secure Access with a Backup Contact Number'),
              subtitleTextStyle: TextStyles.regular(
                11,
                fontColor: AppColors.grey888888,
              ),
              trailing: Icon(
                Icons.chevron_right,
                color: AppColors.grey888888,
              ),
              minTileHeight: 24,
            ),
            Divider(color: AppColors.whiteF0F0F0, thickness: 1),
            ListTile(
              onTap: () {},
              minVerticalPadding: 0,
              contentPadding: EdgeInsets.zero,
              title: Text('Recovery Email'),
              titleTextStyle: TextStyles.medium(
                14,
                fontColor: AppColors.black141414,
              ),
              subtitle: Text('Secure Your Account with a Backup Email Address'),
              subtitleTextStyle: TextStyles.regular(
                11,
                fontColor: AppColors.grey888888,
              ),
              trailing: Icon(
                Icons.chevron_right,
                color: AppColors.grey888888,
              ),
              minTileHeight: 24,
            ),
          ],
        );
      }),
    );
  }
}
