import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:va_bot_admin/core/constant/app_constant.dart';
import 'package:va_bot_admin/core/theme/colors.dart';
import 'package:va_bot_admin/core/theme/text_styles.dart';

class AiActivityWidget extends StatelessWidget {
  final Color bgColor;
  final String icon;
  final String title;
  final String index;
  final int upValue;
  const AiActivityWidget({
    super.key,
    required this.bgColor,
    required this.icon,
    required this.title,
    required this.index,
    required this.upValue,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                height: 38,
                width: 38,
                decoration: BoxDecoration(
                  color: (isDarkTheme(context))
                      ? AppColors.black1C1C1C
                      : AppColors.whiteFFFFFF,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: SvgPicture.asset(icon, fit: BoxFit.scaleDown),
              ),
              Gap(10),
              Text(
                title,
                style: TextStyles.medium(
                  12,
                  fontColor: AppColors.grey5D5D5D,
                ),
              ),
            ],
          ),
          Gap(15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${index}',
                style: TextStyles.semiBold(20,
                    fontColor: (isDarkTheme(context))
                        ? AppColors.whiteFFFFFF
                        : AppColors.black141414),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.arrow_upward_rounded,
                    size: 18,
                    color: AppColors.green16A34A,
                  ),
                  Gap(1),
                  Text(
                    '${upValue}% ',
                    style: TextStyles.medium(
                      10,
                      fontColor: AppColors.green16A34A,
                    ),
                  ),
                  Text(
                    'vs last month',
                    style: TextStyles.medium(
                      10,
                      fontColor: AppColors.grey888888,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
