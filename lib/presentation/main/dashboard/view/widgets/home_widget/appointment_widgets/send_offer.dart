import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:va_bot_admin/presentation/main/dashboard/controller/dashboard_controller.dart';
import 'package:va_bot_admin/presentation/main/dashboard/view/widgets/home_widget/appointment_widgets/title_field_widget.dart';

class AppointmentSendOffer extends StatelessWidget {
  AppointmentSendOffer({super.key});
  final DashboardScreenController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TitleFieldWidget(
            title: 'Seller Price',
            hintText: 'Enter Seller Name',
            controller: controller.appSOSellerPrice,
          ),
        ),
        Gap(20),
        Expanded(
          child: TitleFieldWidget(
            title: 'Buyer Price',
            hintText: 'Enter Buyer Price',
            controller: controller.appSOBuyerPrice,
          ),
        ),
      ],
    );
  }
}
