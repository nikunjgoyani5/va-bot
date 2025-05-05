import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../theme/colors.dart';

class CommonButton extends StatelessWidget {
  final void Function() onPressed;
  final void Function(bool)? onHover;
  final Widget child;
  final Color? buttonColor;
  final double? buttonHeight;
  final double? buttonWidth;
  final Color? borderColor;
  final double? radius;
  const CommonButton(
      {super.key,
      required this.onPressed,
      required this.child,
      this.buttonColor,
      this.buttonHeight,
      this.buttonWidth,
      this.radius,
      this.borderColor,
      this.onHover});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius ?? 8),
          side: borderColor != null
              ? BorderSide(
                  color: borderColor ?? AppColors.primaryColor,
                )
              : BorderSide.none,
        ),
        backgroundColor: buttonColor ?? AppColors.primaryColor,
        elevation: 0,
        padding: (buttonWidth != null || buttonHeight != null)
            ? EdgeInsets.zero
            : EdgeInsets.symmetric(horizontal: 1.5.w, vertical: 2.3.h),
        minimumSize: (buttonWidth != null || buttonHeight != null)
            ? Size(
                buttonWidth ?? 30.sp,
                buttonHeight ?? 19.sp,
              )
            : null,
        fixedSize: (buttonWidth != null || buttonHeight != null)
            ? Size(
                buttonWidth ?? 30.sp,
                buttonHeight ?? 19.sp,
              )
            : null,
      ),
      onHover: onHover,
      onPressed: onPressed,
      child: child,
    );
  }
}
