import 'package:va_bot_admin/data/repositories/auth_repo.dart';
import 'package:va_bot_admin/data/model/response_model.dart';
import 'package:va_bot_admin/core/utils/app_functions.dart';
import 'package:va_bot_admin/routes/navigation_routes.dart';
import 'package:va_bot_admin/routes/app_routes.dart';
import 'package:toastification/toastification.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'dart:developer';
import 'dart:async';

class OtpController extends GetxController {
  TextEditingController otpController = TextEditingController();
  String? email;
  String? page;

  GlobalKey<FormState> otpKey = GlobalKey();
  Timer? timer;
  int secondsRemaining = 120; // 2 minutes

  void startTimer() {
    timer?.cancel();
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (secondsRemaining > 0) {
        secondsRemaining--;
        update();
      } else {
        timer.cancel();
        update();
      }
    });
  }

  String formatTime(int seconds) {
    String minutes = (seconds ~/ 60).toString().padLeft(2, '0');
    String secs = (seconds % 60).toString().padLeft(2, '0');
    return "$minutes:$secs";
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  void onInit() {
    startTimer();
    super.onInit();
  }

  bool isLoading = false;
  Future<void> verifyOTP(BuildContext context) async {
    isLoading = true;
    update();
    try {
      ResponseModel responseModel = await AuthRepository.verifyOTP(
        data: {
          'email': email,
          'otp': int.parse(otpController.text),
        },
      );
      if (responseModel.status) {
        if (page?.toLowerCase() == 'forgot-password') {
          NavigatorRoute.navigateTo(
            context,
            page: AppRoutes.createNewPass,
            arguments: {'email': email},
          );
        } else {
          NavigatorRoute.navigateTo(context, page: AppRoutes.login);
        }
        AppFunctions.showToast(
            message: responseModel.message,
            toastType: ToastificationType.success);
      } else {
        AppFunctions.showToast(
            message: responseModel.message,
            toastType: ToastificationType.error);
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
