import 'package:flutter/material.dart';
import 'package:va_bot_admin/core/constant/app_extension.dart';
import 'package:va_bot_admin/core/constant/app_strings.dart';
import 'package:va_bot_admin/core/theme/colors.dart';
import 'package:va_bot_admin/core/theme/text_styles.dart';
import 'package:va_bot_admin/gen/assets.gen.dart';

class CommonTitleWithImage extends StatelessWidget {
  const CommonTitleWithImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Image.asset(
        Assets.images.logo.path,
        height: 26,
        width: 26,
        fit: BoxFit.fill,
      ),
      spaceW(10),
      Text(
        AppStrings.vaBoat,
        style: TextStyles.semiBold(11, fontColor: AppColors.black141414),
      ),
    ]);
  }
}
