import 'package:va_bot_admin/presentation/authentication/forgot_pass_screen/widgets/forgot_pass_desktop_view.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:flutter/material.dart';

class ForgotPassScreen extends StatelessWidget {
  final String? email;
  const ForgotPassScreen({super.key, this.email});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenTypeLayout.builder(
        mobile: (context) => SizedBox(),
        tablet: (context) => SizedBox(),
        desktop: (context) => ForgotPassDesktopView(),
      ),
    );
  }
}
