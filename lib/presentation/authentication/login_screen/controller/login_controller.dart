import 'package:va_bot_admin/data/repositories/auth_repo.dart';
import 'package:va_bot_admin/data/model/response_model.dart';
import 'package:va_bot_admin/core/utils/app_functions.dart';
import 'package:va_bot_admin/data/model/sign_in_model.dart';
import 'package:va_bot_admin/routes/navigation_routes.dart';
import 'package:va_bot_admin/services/pref_service.dart';
import 'package:va_bot_admin/routes/app_routes.dart';
import 'package:toastification/toastification.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'dart:developer';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  GlobalKey<FormState> loginKey = GlobalKey();

  bool isPasswordSecure = true;
  bool isLoading = false;
  Future<void> signIn(BuildContext context) async {
    isLoading = true;
    update();
    try {
      ResponseModel responseModel = await AuthRepository.loginWithEmail(
        data: {
          'email': emailController.text,
          'password': passController.text,
        },
      );
      if (responseModel.status) {
        SignInData signInModel = SignInData.fromJson(responseModel.body);
        PrefService.setValue(PrefService.token, signInModel.token);
        AppFunctions.showToast(
            message: responseModel.message,
            toastType: ToastificationType.success);
        NavigatorRoute.navigateTo(context, page: AppRoutes.dashboard);
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
      AppFunctions.showToast(
          message: '${e}', toastType: ToastificationType.error);
    }
  }

  Future<void> googleSignIn(BuildContext context) async {
    isLoading = true;
    update();
    try {
      GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) return null;
      GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      await FirebaseAuth.instance.signInWithCredential(credential);
      ResponseModel responseModel = await AuthRepository.loginWithGoogle(
        data: {'token': googleAuth.idToken},
      );
      if (responseModel.status) {
        PrefService.setValue(PrefService.token, responseModel.body['token']);
        AppFunctions.showToast(
            message: responseModel.message,
            toastType: ToastificationType.success);
        NavigatorRoute.navigateTo(context, page: AppRoutes.dashboard);
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
    } finally {
      isLoading = false;
      update();
    }
  }
}
