import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sizer/sizer.dart';
import 'package:va_bot_admin/core/theme/colors.dart';
import 'package:va_bot_admin/core/theme/text_styles.dart';

class RecentCallWidget extends StatelessWidget {
  final String title;
  final String subTitle;
  final String date;
  const RecentCallWidget({
    super.key,
    required this.title,
    required this.subTitle,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyles.medium(
                14,
                fontColor: AppColors.black141414,
              ),
            ),
            Gap(5),
            Container(
              decoration: BoxDecoration(
                color: (subTitle.toLowerCase() == 'inbound (client-initiated)')
                    ? AppColors.greenD1FAE5
                    : AppColors.blueDBEAFE,
                borderRadius: BorderRadius.circular(5),
              ),
              padding: EdgeInsets.symmetric(horizontal: 0.5.w, vertical: 0.5.h),
              child: Center(
                child: Text(
                  subTitle,
                  style: TextStyles.medium(
                    11,
                    fontColor:
                        (subTitle.toLowerCase() == 'inbound (client-initiated)')
                            ? AppColors.green059669
                            : AppColors.primaryColor,
                  ),
                ),
              ),
            ),
          ],
        ),
        Gap(0.5.h),
        Row(
          children: [
            Text(
              date,
              style: TextStyles.medium(
                12,
                fontColor: AppColors.grey7F878E,
              ),
            ),
          ],
        ),
        Gap(12),
        Container(
          width: double.infinity,
          padding: EdgeInsets.only(right: 14, left: 7, top: 3, bottom: 3),
          decoration: BoxDecoration(
            color: AppColors.greyF3F5F7,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Row(
            children: [
              Icon(
                Icons.play_arrow,
              ),
              Gap(0.5.w),
              Text(
                '0:00 / 1:23',
                style: TextStyles.regular(
                  11,
                  fontColor: AppColors.black141414,
                ),
              ),
              Gap(0.5.w),
              Expanded(
                child: LinearProgressIndicator(
                  value: 0.3,
                  color: AppColors.black141414,
                  backgroundColor: AppColors.greyD8DEE4,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
