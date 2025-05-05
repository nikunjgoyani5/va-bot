import 'package:va_bot_admin/data/repositories/auth_repo.dart';
import 'package:va_bot_admin/data/model/response_model.dart';
import 'package:va_bot_admin/routes/navigation_routes.dart';
import 'package:va_bot_admin/core/utils/app_functions.dart';
import 'package:va_bot_admin/routes/app_routes.dart';
import 'package:country_picker/country_picker.dart';
import 'package:toastification/toastification.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'dart:developer';

class SignUpController extends GetxController {
  Country? selectedCountry;
  String selectedCountryCode = '91';
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  GlobalKey<FormState> signUpKey = GlobalKey();

  bool isPasswordSecure = true;

  bool isLoading = false;
  Future<void> signUp(BuildContext context) async {
    isLoading = true;
    update();
    try {
      ResponseModel responseModel = await AuthRepository.signUpWithEmail(
        data: {
          'firstName': firstNameController.text,
          'lastName': lastNameController.text,
          'email': emailController.text,
          'password': passController.text,
          'mobileNumber': int.parse(phoneController.text)
        },
      );
      if (responseModel.status) {
        NavigatorRoute.navigateTo(
          context,
          page: AppRoutes.otp,
          arguments: {
            'page': 'sign-up',
            'email': emailController.text,
          },
        );
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
