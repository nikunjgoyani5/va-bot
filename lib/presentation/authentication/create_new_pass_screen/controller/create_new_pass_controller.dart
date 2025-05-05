import 'package:va_bot_admin/data/repositories/auth_repo.dart';
import 'package:va_bot_admin/data/model/response_model.dart';
import 'package:va_bot_admin/routes/navigation_routes.dart';
import 'package:va_bot_admin/core/utils/app_functions.dart';
import 'package:va_bot_admin/routes/app_routes.dart';
import 'package:toastification/toastification.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateNewPassController extends GetxController {
  String? email;
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  GlobalKey<FormState> createNewPassKey = GlobalKey();

  bool isPasswordSecure = true;
  bool isConfirmPasswordSecure = true;

  bool isLoading = false;

  Future<void> resetPassword(BuildContext context) async {
    isLoading = true;
    update();
    try {
      ResponseModel responseModel = await AuthRepository.resetPassword(
        data: {
          'email': email,
          'newPassword': passwordController.text,
          'conformNewPassword': confirmPasswordController.text
        },
      );
      if (responseModel.status) {
        NavigatorRoute.navigateTo(context, page: AppRoutes.login);
      } else {
        AppFunctions.showToast(
          message: responseModel.message,
          toastType: ToastificationType.error,
        );
      }
      isLoading = false;
      update();
    } catch (e) {
      isLoading = false;
      update();
    }
  }
}
