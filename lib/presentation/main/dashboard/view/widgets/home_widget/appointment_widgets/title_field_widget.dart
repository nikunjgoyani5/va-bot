import 'package:va_bot_admin/core/utils/common_widgets/common_text_field.dart';
import 'package:va_bot_admin/core/theme/text_styles.dart';
import 'package:va_bot_admin/core/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class TitleFieldWidget extends StatelessWidget {
  final String title;
  final String hintText;
  final TextEditingController controller;

  const TitleFieldWidget({
    super.key,
    required this.title,
    required this.hintText,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyles.medium(
            12,
            fontColor: AppColors.black141414,
          ),
        ),
        Gap(10),
        CommonTextField(
          hintText: hintText,
          controller: controller,
          fillColor: AppColors.whiteF8F8F8,
          enableBorderColor: AppColors.whiteF8F8F8,
        ),
      ],
    );
  }
}
