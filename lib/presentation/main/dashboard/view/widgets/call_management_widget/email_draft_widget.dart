import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:va_bot_admin/core/theme/colors.dart';
import 'package:va_bot_admin/core/theme/text_styles.dart';
import 'package:va_bot_admin/core/utils/common_widgets/common_button.dart';
import 'package:va_bot_admin/presentation/main/dashboard/controller/dashboard_controller.dart';

class EmailDraftWidget extends StatelessWidget {
  const EmailDraftWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardScreenController>(builder: (controller) {
      return ListView.separated(
        itemCount: controller.emailDraftDetails.length,
        shrinkWrap: true,
        separatorBuilder: (BuildContext context, int index) {
          return Gap(1.h);
        },
        itemBuilder: (BuildContext context, int index) {
          Map<String, dynamic> data = controller.emailDraftDetails[index];
          return Container(
            decoration: BoxDecoration(
              color: AppColors.whiteFFFFFF,
              border: Border.all(color: AppColors.greyE6E8EA),
              borderRadius: BorderRadius.circular(12),
            ),
            padding: EdgeInsets.symmetric(horizontal: 1.w, vertical: 1.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Dear ${data['name']}',
                  style: TextStyles.medium(
                    14,
                    fontColor: AppColors.grey7F878E,
                  ),
                ),
                Gap(1.h),
                Text(
                  '${data['description']}',
                  style: TextStyles.medium(
                    14,
                    fontColor: AppColors.grey7F878E,
                  ),
                ),
                Gap(1.h),
                Row(
                  children: [
                    CommonButton(
                      onPressed: () {},
                      buttonColor: AppColors.whiteFFFFFF,
                      borderColor: AppColors.greyE6E8EA,
                      child: Text(
                        'Approve & Send',
                        style: TextStyles.medium(
                          11,
                          fontColor: AppColors.black141414,
                        ),
                      ),
                    ),
                    Gap(0.7.w),
                    CommonButton(
                      onPressed: () {},
                      buttonColor: AppColors.whiteFFFFFF,
                      borderColor: AppColors.greyE6E8EA,
                      child: Text(
                        'Edit',
                        style: TextStyles.medium(
                          11,
                          fontColor: AppColors.black141414,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      );
    });
  }
}
