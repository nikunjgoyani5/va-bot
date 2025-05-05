import 'package:va_bot_admin/presentation/main/dashboard/view/widgets/home_widget/appointment_widgets/title_field_widget.dart';
import 'package:va_bot_admin/presentation/main/dashboard/controller/dashboard_controller.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class LeadDetails extends StatelessWidget {
  LeadDetails({super.key});
  final DashboardScreenController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Expanded(
              child: TitleFieldWidget(
                title: 'First name',
                hintText: 'Enter name',
                controller: controller.appLeadFirstController,
              ),
            ),
            Gap(20),
            Expanded(
              child: TitleFieldWidget(
                title: 'Second name',
                hintText: 'Second name',
                controller: controller.appLeadSecondController,
              ),
            ),
          ],
        ),
        Gap(20),
        TitleFieldWidget(
          title: 'Email address',
          hintText: 'Enter Email Address',
          controller: controller.appLeadEmailController,
        ),
        Gap(20),
        TitleFieldWidget(
          title: 'Phone Number',
          hintText: 'Enter Phone Number',
          controller: controller.appLeadPhoneController,
        ),
      ],
    );
  }
}
