import 'package:va_bot_admin/presentation/authentication/sign_up_screen/widgets/signup_desktop_view.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenTypeLayout.builder(
        mobile: (context) => SizedBox(),
        tablet: (context) => SizedBox(),
        desktop: (context) => SignupDeskTopView(),
      ),
    );
  }
}
