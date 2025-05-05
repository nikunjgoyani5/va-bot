import 'package:va_bot_admin/presentation/main/dashboard/view/views/dashboard_desktop_view.dart';
import 'package:va_bot_admin/presentation/main/dashboard/controller/dashboard_controller.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardScreen extends StatelessWidget {
  DashboardScreen({super.key});
  final DashboardScreenController controller =
      Get.put(DashboardScreenController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenTypeLayout.builder(
        mobile: (context) => Container(),
        tablet: (context) => Container(),
        desktop: (context) => DashboardDesktopView(),
      ),
    );
  }
}
