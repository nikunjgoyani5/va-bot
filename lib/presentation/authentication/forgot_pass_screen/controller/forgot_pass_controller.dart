import 'package:va_bot_admin/data/repositories/auth_repo.dart';
import 'package:va_bot_admin/data/model/response_model.dart';
import 'package:va_bot_admin/core/utils/app_functions.dart';
import 'package:va_bot_admin/routes/navigation_routes.dart';
import 'package:va_bot_admin/routes/app_routes.dart';
import 'package:toastification/toastification.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'dart:developer';

class ForgotPassController extends GetxController {
  TextEditingController emailController = TextEditingController();
  GlobalKey<FormState> forgotPassKey = GlobalKey();
  bool isLoading = false;
  Future<void> sendOTP(BuildContext context) async {
    isLoading = true;
    update();
    try {
      ResponseModel responseModel = await AuthRepository.sendOTP(
        data: {'email': emailController.text},
      );
      if (responseModel.status) {
        NavigatorRoute.navigateTo(
          context,
          page: AppRoutes.otp,
          arguments: {
            'page': 'forgot-password',
            'email': emailController.text,
          },
        );
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
      log('============== $e');
    }
  }
}
