import 'package:va_bot_admin/presentation/main/dashboard/controller/dashboard_controller.dart';
import 'package:va_bot_admin/core/utils/common_widgets/common_dialog.dart';
import 'package:va_bot_admin/core/theme/text_styles.dart';
import 'package:va_bot_admin/core/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:va_bot_admin/routes/navigation_routes.dart';

class UpcomingAppointmentDetailsDialog extends StatelessWidget {
  const UpcomingAppointmentDetailsDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonAppDialog(
      padding: EdgeInsets.zero,
      child: Container(
        width: 500,
        // height: 400,
        child: GetBuilder<DashboardScreenController>(builder: (controller) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 10, right: 10, top: 10),
                child: Row(
                  children: [
                    Text(
                      'Appointment information',
                      style: TextStyles.semiBold(18),
                    ),
                    Gap(10),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: AppColors.orangeFEF3C7,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text(
                        'Pending',
                        style: TextStyles.medium(
                          11,
                          fontColor: AppColors.orange92400E,
                        ),
                      ),
                    ),
                    Spacer(),
                    TextButton(
                      onPressed: () {
                        NavigatorRoute.navigateBack(context: context);
                      },
                      child: Icon(Icons.close, color: AppColors.greyC3C3C3),
                    ),
                  ],
                ),
              ),
              Divider(
                color: AppColors.whiteEBEBEB,
                thickness: 1,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.whiteF8F8F8,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                      child: TabBar(
                        dividerHeight: 0,
                        controller: controller.appointmentController,
                        indicatorPadding: EdgeInsets.zero,
                        indicator: BoxDecoration(),
                        isScrollable: true,
                        tabAlignment: TabAlignment.start,
                        onTap: controller.onTabPressed,
                        tabs: [
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            decoration: BoxDecoration(
                              color:
                                  (controller.appointmentController.index == 0)
                                      ? AppColors.whiteFFFFFF
                                      : AppColors.transparent,
                              borderRadius: BorderRadius.circular(8),
                              boxShadow:
                                  (controller.appointmentController.index == 0)
                                      ? [
                                          BoxShadow(
                                            color: AppColors.whiteE1E1E1,
                                            offset: Offset(0, 1),
                                            blurRadius: 1,
                                          )
                                        ]
                                      : null,
                            ),
                            child: Text(
                              'Lead Details',
                              style: TextStyles.medium(
                                12,
                                fontColor:
                                    (controller.appointmentController.index ==
                                            0)
                                        ? AppColors.black141414
                                        : AppColors.grey6D6D6D,
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            decoration: BoxDecoration(
                              color:
                                  (controller.appointmentController.index == 1)
                                      ? AppColors.whiteFFFFFF
                                      : AppColors.transparent,
                              borderRadius: BorderRadius.circular(8),
                              boxShadow:
                                  (controller.appointmentController.index == 1)
                                      ? [
                                          BoxShadow(
                                            color: AppColors.whiteE1E1E1,
                                            offset: Offset(0, 1),
                                            blurRadius: 1,
                                          )
                                        ]
                                      : null,
                            ),
                            child: Text(
                              'Property',
                              style: TextStyles.medium(
                                12,
                                fontColor:
                                    (controller.appointmentController.index ==
                                            1)
                                        ? AppColors.black141414
                                        : AppColors.grey6D6D6D,
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            decoration: BoxDecoration(
                              color:
                                  (controller.appointmentController.index == 2)
                                      ? AppColors.whiteFFFFFF
                                      : AppColors.transparent,
                              borderRadius: BorderRadius.circular(8),
                              boxShadow:
                                  (controller.appointmentController.index == 2)
                                      ? [
                                          BoxShadow(
                                            color: AppColors.whiteE1E1E1,
                                            offset: Offset(0, 1),
                                            blurRadius: 1,
                                          )
                                        ]
                                      : null,
                            ),
                            child: Text(
                              'Send Offer',
                              style: TextStyles.medium(
                                12,
                                fontColor:
                                    (controller.appointmentController.index ==
                                            2)
                                        ? AppColors.black141414
                                        : AppColors.grey6D6D6D,
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            decoration: BoxDecoration(
                              color:
                                  (controller.appointmentController.index == 3)
                                      ? AppColors.whiteFFFFFF
                                      : AppColors.transparent,
                              borderRadius: BorderRadius.circular(8),
                              boxShadow:
                                  (controller.appointmentController.index == 3)
                                      ? [
                                          BoxShadow(
                                            color: AppColors.whiteE1E1E1,
                                            offset: Offset(0, 1),
                                            blurRadius: 1,
                                          )
                                        ]
                                      : null,
                            ),
                            child: Text(
                              'Lead Status',
                              style: TextStyles.medium(
                                12,
                                fontColor:
                                    (controller.appointmentController.index ==
                                            3)
                                        ? AppColors.black141414
                                        : AppColors.grey6D6D6D,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Gap(20),
                    /*Builder(
                      builder: (BuildContext context) {
                        if (controller.appointmentController.index == 0) {
                          return LeadDetails();
                        } else if (controller.appointmentController.index ==
                            1) {
                          return AppointmentProperty();
                        } else if (controller.appointmentController.index ==
                            2) {
                          return AppointmentSendOffer();
                        } else {
                          return AppointmentLeadStatus();
                        }
                      },
                    ),*/
                    AnimatedSwitcher(
                      duration: Duration(milliseconds: 300),
                      transitionBuilder:
                          (Widget child, Animation<double> animation) {
                        return FadeTransition(
                          opacity: animation,
                          child: child,
                        );
                      },
                      child: controller.getAppointmentDialogWidgets(
                          controller.appointmentController.index),
                    ),
                  ],
                ),
              ),
              Gap(10),
            ],
          );
        }),
      ),
    );
  }
}
