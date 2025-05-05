import 'package:va_bot_admin/presentation/main/dashboard/view/widgets/home_widget/appointment_widgets/title_field_widget.dart';
import 'package:va_bot_admin/presentation/main/dashboard/controller/dashboard_controller.dart';
import 'package:va_bot_admin/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class AppointmentProperty extends StatelessWidget {
  AppointmentProperty({super.key});
  final DashboardScreenController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Assets.images.appointment1.image(width: 80, height: 80),
            Gap(16),
            Expanded(
              child: TitleFieldWidget(
                title: 'Property Name',
                hintText: 'Property Name',
                controller: controller.appPropertyType,
              ),
            ),
          ],
        ),
        Gap(20),
        TitleFieldWidget(
          title: 'Location Preference',
          hintText: 'Enter Location Preference',
          controller: controller.appProLocationPreference,
        ),
      ],
    );
  }
}
