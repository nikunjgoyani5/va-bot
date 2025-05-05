import 'package:va_bot_admin/presentation/onboard/onboard_screen/view/views/onboard_desktop_view.dart';
import 'package:va_bot_admin/presentation/onboard/onboard_screen/controller/onboard_controller.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnBoardScreen extends StatelessWidget {
  OnBoardScreen({super.key});
  final OnBoardController controller = Get.put(OnBoardController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenTypeLayout.builder(
        mobile: (context) => Container(),
        tablet: (context) => Container(),
        desktop: (context) => OnBoardDesktopView(),
      ),
    );
  }
}
