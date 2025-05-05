import 'package:va_bot_admin/presentation/main/dashboard/controller/dashboard_controller.dart';
import 'package:va_bot_admin/core/utils/common_widgets/common_button.dart';
import 'package:va_bot_admin/core/theme/text_styles.dart';
import 'package:va_bot_admin/core/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:va_bot_admin/routes/navigation_routes.dart';

class AppointmentLeadStatus extends StatelessWidget {
  AppointmentLeadStatus({super.key});
  final DashboardScreenController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PopupMenuButton<int>(
          color: AppColors.whiteFFFFFF,
          onOpened: () {},
          itemBuilder: (context) {
            return [
              PopupMenuItem(
                height: 30,
                child: Text(
                  'Value 1',
                  style:
                      TextStyles.medium(11, fontColor: AppColors.black141414),
                ),
                onTap: () {},
              ),
              PopupMenuDivider(),
              PopupMenuItem(
                height: 30,
                child: Text(
                  'Value 1',
                  style:
                      TextStyles.medium(11, fontColor: AppColors.black141414),
                ),
                onTap: () {},
              ),
            ];
          },
          child: Container(
            height: 45,
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.whiteFFFFFF,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: AppColors.greyE5E5E5,
              ),
            ),
            child: Row(
              children: [
                Gap(10),
                Text(
                  'Radio select (Select a single options) ',
                  style: TextStyles.regular(
                    14,
                    fontColor: AppColors.grey888888,
                  ),
                ),
                Spacer(),
                Icon(
                  Icons.keyboard_arrow_down,
                ),
                Gap(10),
              ],
            ),
          ),
        ),
        Gap(20),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            CommonButton(
              onPressed: () {
                NavigatorRoute.navigateBack(context: context);
                controller.openConfirmAppointmentDialog(context);
              },
              child: Text(
                'Save',
                style: TextStyles.medium(
                  13,
                  fontColor: AppColors.whiteFFFFFF,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
