import 'package:va_bot_admin/presentation/authentication/create_new_pass_screen/widgets/create_new_pass_desktopview.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:flutter/material.dart';

class CreateNewPassScreen extends StatelessWidget {
  final String? email;
  const CreateNewPassScreen({super.key, this.email});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenTypeLayout.builder(
        mobile: (context) => SizedBox(),
        tablet: (context) => SizedBox(),
        desktop: (context) => CreateNewPassDesktopView(email: email),
      ),
    );
  }
}
