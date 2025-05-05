import 'package:va_bot_admin/presentation/main/dashboard/controller/dashboard_controller.dart';
import 'package:va_bot_admin/core/utils/common_widgets/common_text_field.dart';
import 'package:va_bot_admin/core/utils/common_widgets/common_switch.dart';
import 'package:va_bot_admin/core/theme/text_styles.dart';
import 'package:va_bot_admin/core/theme/colors.dart';
import 'package:va_bot_admin/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class NotificationTab extends StatelessWidget {
  const NotificationTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: GetBuilder<DashboardScreenController>(builder: (controller) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Choose Verification Method',
              style: TextStyles.medium(
                16,
                fontColor: AppColors.black141414,
              ),
            ),
            Gap(20),
            notificationWidget(
              title: 'SMS',
              subTitle:
                  'Instant Messaging for Quick and Reliable Communication',
              switchValue: controller.isSMSNotification,
              onSwitch: (newValue) {
                controller.isSMSNotification = newValue;
                controller.update();
              },
            ),
            Divider(color: AppColors.whiteF0F0F0, thickness: 1),
            notificationWidget(
              title: 'Email',
              subTitle: 'Stay Connected with Seamless Communication',
              switchValue: controller.isEmailNotification,
              onSwitch: (newValue) {
                controller.isEmailNotification = newValue;
                controller.update();
              },
            ),
            Divider(color: AppColors.whiteF0F0F0, thickness: 1),
            notificationWidget(
              title: 'In-App Alerts',
              subTitle:
                  'Stay Updated with Real-Time Notifications Within the App',
              switchValue: controller.isInAppAlertsNotification,
              onSwitch: (newValue) {
                controller.isInAppAlertsNotification = newValue;
                controller.update();
              },
            ),
            Gap(40),
            Text(
              'Quite Hours',
              style: TextStyles.medium(
                16,
                fontColor: AppColors.black141414,
              ),
            ),
            Gap(20),
            notificationWidget(
              title: 'Quiet Hours',
              subTitle:
                  'When enabled, it mutes all Teams notifications on the device during specified hours',
              switchValue: controller.isQuiteHoursNotification,
              onSwitch: (newValue) {
                controller.isQuiteHoursNotification = newValue;
                controller.update();
              },
            ),
            Gap((controller.isQuiteHoursNotification) ? 20 : 0),
            Visibility(
              visible: controller.isQuiteHoursNotification,
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Start Time',
                          style: TextStyles.medium(
                            12,
                            fontColor: AppColors.black141414,
                          ),
                        ),
                        Gap(10),
                        CommonTextField(
                          hintText: '--:-- --',
                          controller: controller.startTimeController,
                          suffixIcon:
                              Assets.icons.icTimer.svg(fit: BoxFit.scaleDown),
                          readOnly: true,
                          onTap: () {
                            controller.selectStartTime(context);
                          },
                        ),
                      ],
                    ),
                  ),
                  Gap(20),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'End Time',
                          style: TextStyles.medium(
                            12,
                            fontColor: AppColors.black141414,
                          ),
                        ),
                        Gap(10),
                        CommonTextField(
                          hintText: '--:-- --',
                          controller: controller.endTimeController,
                          suffixIcon:
                              Assets.icons.icTimer.svg(fit: BoxFit.scaleDown),
                          readOnly: true,
                          onTap: () {
                            controller.selectEndTime(context);
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Divider(color: AppColors.whiteF0F0F0, thickness: 1),
            Gap(20),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Sound',
                        style: TextStyles.medium(
                          14,
                          fontColor: AppColors.black141414,
                        ),
                      ),
                      Text(
                        'How often you want to receive notifications',
                        style: TextStyles.regular(
                          12,
                          fontColor: AppColors.grey888888,
                        ),
                      ),
                    ],
                  ),
                ),
                Gap(20),
                PopupMenuButton<int>(
                  color: AppColors.whiteFFFFFF,
                  onOpened: () {},
                  itemBuilder: (context) {
                    return [
                      PopupMenuItem(
                        height: 30,
                        child: Text(
                          'Sound 1',
                          style: TextStyles.medium(11,
                              fontColor: AppColors.black141414),
                        ),
                        onTap: () {},
                      ),
                      PopupMenuDivider(),
                      PopupMenuItem(
                        height: 30,
                        child: Text(
                          'Sound 1',
                          style: TextStyles.medium(11,
                              fontColor: AppColors.black141414),
                        ),
                        onTap: () {},
                      ),
                    ];
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.whiteFFFFFF,
                      border: Border.all(color: AppColors.whiteE1E1E1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 11),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Automatic (default)',
                          style: TextStyles.medium(11,
                              fontColor: AppColors.black141414),
                        ),
                        Gap(10),
                        Assets.icons.icDropdownArrow.svg(
                          height: 6,
                          width: 6,
                          colorFilter: ColorFilter.mode(
                            AppColors.grey5D5D5D,
                            BlendMode.srcIn,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Divider(color: AppColors.whiteF0F0F0, thickness: 1),
          ],
        );
      }),
    );
  }

  Widget notificationWidget({
    required String title,
    required String subTitle,
    required bool switchValue,
    required Function(bool) onSwitch,
  }) {
    return InkWell(
      onTap: () {
        onSwitch(!switchValue);
      },
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
                    fontColor: AppColors.grey888888,
                  ),
                ),
              ],
            ),
          ),
          Gap(20),
          CommonSwitchButton(
            value: switchValue,
            onChanged: onSwitch,
          ),
        ],
      ),
    );
  }
}
