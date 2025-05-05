import 'package:va_bot_admin/presentation/authentication/login_screen/controller/login_controller.dart';
import 'package:va_bot_admin/presentation/authentication/login_screen/widgets/login_desktop_view.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(LoginController());
    return Scaffold(
      body: ScreenTypeLayout.builder(
        mobile: (context) => SizedBox(),
        tablet: (context) => SizedBox(),
        desktop: (context) => LoginDeskTopView(),
      ),
    );
  }
}
