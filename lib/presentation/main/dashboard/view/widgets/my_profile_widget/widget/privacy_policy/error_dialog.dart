import 'package:va_bot_admin/core/utils/common_widgets/common_button.dart';
import 'package:va_bot_admin/core/utils/common_widgets/common_dialog.dart';
import 'package:va_bot_admin/routes/navigation_routes.dart';
import 'package:va_bot_admin/core/theme/text_styles.dart';
import 'package:va_bot_admin/core/theme/colors.dart';
import 'package:va_bot_admin/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ErrorDialog extends StatelessWidget {
  const ErrorDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonAppDialog(
      child: Column(
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
              Assets.icons.icError.svg(height: 70, width: 70),
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
          Text(
            'Error',
            style: TextStyles.semiBold(20, fontColor: AppColors.black141414),
          ),
          Gap(5),
          Text(
            'Something went wrong. Please try again',
            style: TextStyles.regular(16, fontColor: AppColors.grey888888),
          ),
          Gap(24),
          CommonButton(
            onPressed: () {
              NavigatorRoute.navigateBack(context: context);
            },
            child: Text(
              'Go back',
              style: TextStyles.medium(
                11,
                fontColor: AppColors.whiteFFFFFF,
              ),
            ),
          )
        ],
      ),
    );
  }
}
