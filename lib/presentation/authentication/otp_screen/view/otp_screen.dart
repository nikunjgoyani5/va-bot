import 'package:va_bot_admin/presentation/authentication/otp_screen/widgets/otp_desktop_view.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:flutter/material.dart';

class OtpScreen extends StatelessWidget {
  final String? email;
  final String? page;
  const OtpScreen({super.key, this.email, this.page});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenTypeLayout.builder(
        mobile: (context) => SizedBox(),
        tablet: (context) => SizedBox(),
        desktop: (context) => OtpDesktopView(email: email, page: page),
      ),
    );
  }
}
