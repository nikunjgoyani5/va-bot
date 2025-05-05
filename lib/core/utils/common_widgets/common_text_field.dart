import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:va_bot_admin/core/theme/text_styles.dart';

import '../../theme/colors.dart';

class CommonTextField extends StatelessWidget {
  final String? hintText;
  final String? errorText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final double? height;
  final int? maxLength;
  final int? maxLines;
  final String? topLabel;
  final bool? obscureText;
  final bool? readOnly;
  final FormFieldSetter<String>? onSaved;
  final ValueChanged<String>? onSubmitted;
  final TextStyle? textStyle;
  final ValueChanged<String>? onChanged;
  final FormFieldValidator<String>? validator;
  final TextInputType? keyboardType;
  final Key? kKey;
  final TextEditingController? controller;
  final Color? fillColor;
  final Color? enableBorderColor;
  final String? kInitialValue;
  final List<TextInputFormatter>? inputFormatters;
  final Function()? onTap;
  final Color? cursorColor;
  final FocusNode? focusNode;
  final Iterable<String>? autoHints;
  final TextInputAction? textInputAction;
  final TextAlign textAlign;

  const CommonTextField({
    super.key,
    required this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.height = 48.0,
    this.topLabel = "",
    this.obscureText = false,
    this.readOnly = false,
    this.onSaved,
    this.onTap,
    this.keyboardType,
    this.errorText,
    this.maxLength,
    this.maxLines = 1,
    this.onChanged,
    this.validator,
    this.fillColor,
    this.enableBorderColor,
    this.kKey,
    required this.controller,
    this.kInitialValue,
    this.inputFormatters,
    this.onSubmitted,
    this.focusNode,
    this.textStyle,
    this.cursorColor,
    this.autoHints,
    this.textInputAction,
    this.textAlign = TextAlign.start,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textInputAction: textInputAction ?? TextInputAction.next,
      autofillHints: autoHints ?? [],
      onFieldSubmitted: onSubmitted,
      inputFormatters: inputFormatters ?? [],
      readOnly: readOnly ?? false,
      initialValue: kInitialValue,
      controller: controller,
      key: kKey,
      keyboardType: keyboardType ?? TextInputType.text,
      onSaved: onSaved,
      maxLength: maxLength,
      maxLines: maxLines,
      onChanged: onChanged,
      onTap: onTap,
      validator: validator,
      obscureText: obscureText!,
      cursorColor: cursorColor ?? AppColors.black141414,
      // cursorHeight: 10,
      textAlign: textAlign,
      style: /*textStyle ??*/
          TextStyles.regular(14, fontColor: AppColors.black141414),
      decoration: InputDecoration(
          // isDense: true,
          fillColor: fillColor,
          filled: fillColor != null ? true : false,
          counter: const SizedBox.shrink(),
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: enableBorderColor ?? AppColors.greyE5E5E5,
                width: 1.5,
              ),
              borderRadius: BorderRadius.circular(10)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: enableBorderColor ?? AppColors.greyE5E5E5,
                width: 1.5,
              ),
              borderRadius: BorderRadius.circular(10)),
          errorStyle: TextStyle(height: 0, color: Colors.red),
          errorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.red,
              ),
              borderRadius: BorderRadius.circular(10)),
          focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.error,
              ),
              borderRadius: BorderRadius.circular(10)),
          hintText: hintText,
          hintStyle:
              TextStyles.regular(/*10.6*/ 14, fontColor: AppColors.grey888888),
          errorText: errorText),
    );
  }
}
