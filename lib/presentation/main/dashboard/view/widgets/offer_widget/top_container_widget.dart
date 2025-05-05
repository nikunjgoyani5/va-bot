import 'package:va_bot_admin/core/theme/text_styles.dart';
import 'package:va_bot_admin/core/theme/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:gap/gap.dart';

class TopContainerWidget extends StatelessWidget {
  final int offerValue;
  final String offerType;
  final String imagePath;
  final Color iconBgColor;
  const TopContainerWidget({
    super.key,
    required this.offerValue,
    required this.offerType,
    required this.imagePath,
    required this.iconBgColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.whiteFFFFFF,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.whiteEBEBEB),
      ),
      padding: EdgeInsets.only(left: 1.w, right: 1.w, top: 1.h, bottom: 1.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${offerValue}',
                style: TextStyles.semiBold(
                  20,
                  fontColor: AppColors.black141414,
                ),
              ),
              Gap(10),
              Text(
                offerType,
                style: TextStyles.medium(
                  12,
                  fontColor: AppColors.black141414,
                ),
              ),
            ],
          ),
          Container(
            height: 3.w,
            width: 3.w,
            decoration: BoxDecoration(
              color: iconBgColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: SvgPicture.asset(imagePath),
            ),
          ),
        ],
      ),
    );
  }
}
