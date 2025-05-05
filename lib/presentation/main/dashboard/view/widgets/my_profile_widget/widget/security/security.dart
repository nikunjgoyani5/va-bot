import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:va_bot_admin/presentation/main/dashboard/controller/dashboard_controller.dart';
import 'package:va_bot_admin/presentation/main/dashboard/view/widgets/my_profile_widget/widget/security/account_recovery/account_recovery.dart';
import 'package:va_bot_admin/presentation/main/dashboard/view/widgets/my_profile_widget/widget/security/chang_password/change_password.dart';
import 'package:va_bot_admin/presentation/main/dashboard/view/widgets/my_profile_widget/widget/security/multi_factor/multi_factor.dart';

class SecurityTab extends StatelessWidget {
  SecurityTab({super.key});
  final DashboardScreenController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: controller.securityPageController,
      scrollDirection: Axis.vertical,
      physics: NeverScrollableScrollPhysics(),
      children: [
        ChangePassword(),
        MultiFactor(),
        AccountRecovery(),
      ],
    );
  }
}
