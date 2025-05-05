import 'package:va_bot_admin/core/theme/text_styles.dart';
import 'package:va_bot_admin/core/theme/colors.dart';
import 'package:toastification/toastification.dart';
import 'package:flutter/material.dart';

class AppFunctions {
  static void showToast({
    required String message,
    required ToastificationType toastType,
    void Function(ToastificationItem)? onTap,
    void Function(ToastificationItem)? onCloseButtonTap,
    void Function(ToastificationItem)? onAutoCompleteCompleted,
    void Function(ToastificationItem)? onDismissed,
  }) {
    toastification.show(
      type: toastType,
      style: ToastificationStyle.flat,
      autoCloseDuration: const Duration(seconds: 3),
      title: Text(
        message,
        style: TextStyles.medium(
          14,
          fontColor: AppColors.black141414,
        ),
      ),
      alignment: Alignment.topRight,
      direction: TextDirection.ltr,
      icon: Icon(
        (toastType == ToastificationType.success) ? Icons.check : Icons.close,
      ),
      primaryColor: (toastType == ToastificationType.success)
          ? AppColors.green33B764
          : AppColors.redEF4444,
      backgroundColor: AppColors.whiteFFFFFF,
      foregroundColor: AppColors.black000000,
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      borderRadius: BorderRadius.circular(12),
      showProgressBar: true,
      closeButton: ToastCloseButton(
        showType: CloseButtonShowType.onHover,
        buttonBuilder: (context, onClose) {
          return IconButton(
            onPressed: onClose,
            icon: Icon(
              Icons.close,
              size: 14,
              color: AppColors.grey888888,
            ),
          );
        },
      ),
      closeOnClick: true,
      pauseOnHover: true,
      dragToClose: true,
      applyBlurEffect: true,
      callbacks: ToastificationCallbacks(
        onTap: onTap,
        onCloseButtonTap: onCloseButtonTap,
        onAutoCompleteCompleted: onAutoCompleteCompleted,
        onDismissed: onDismissed,
      ),
    );
  }
}
