import 'package:va_bot_admin/presentation/onboard/onboard_screen/controller/onboard_controller.dart';
import 'package:va_bot_admin/core/utils/common_widgets/common_switch.dart';
import 'package:va_bot_admin/core/constant/app_strings.dart';
import 'package:va_bot_admin/core/theme/text_styles.dart';
import 'package:va_bot_admin/core/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class StepFour extends StatelessWidget {
  const StepFour({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OnBoardController>(builder: (controller) {
      return Container(
        width: 40.88.w,
        color: AppColors.transparent,
        child: ScrollConfiguration(
          behavior: ScrollBehavior().copyWith(scrollbars: false),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Gap(4.h),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppStrings.automateYourWorkFlow,
                      textAlign: TextAlign.center,
                      style: TextStyles.bold(
                        30,
                        fontColor: AppColors.black141414,
                      ),
                    ),
                    Gap(1.h),
                    Text(
                      AppStrings.vaBotWillTrackYourOffersReplyToLeads,
                      textAlign: TextAlign.center,
                      style: TextStyles.regular(16,
                          fontColor: AppColors.grey5D5D5D),
                    ),
                    Gap(3.h),
                    Text(
                      AppStrings.aiPoweredWorkflows,
                      style: TextStyles.semiBold(
                        20,
                        fontColor: AppColors.black141414,
                      ),
                    ),
                    Gap(0.5.h),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(AppStrings.leadAutoReply),
                      titleTextStyle: TextStyles.medium(
                        14,
                        fontColor: AppColors.black141414,
                      ),
                      subtitle:
                          Text(AppStrings.vaBotWillAutomaticallyReplyToNew),
                      subtitleTextStyle: TextStyles.regular(
                        11,
                        fontColor: AppColors.grey888888,
                      ),
                      onTap: () {
                        controller.isLeadAutoReply =
                            !controller.isLeadAutoReply;
                        controller.update();
                      },
                      trailing: CommonSwitchButton(
                        value: controller.isLeadAutoReply,
                        onChanged: (newValue) {
                          controller.isLeadAutoReply = newValue;
                          controller.update();
                        },
                      ),
                    ),
                    Divider(
                      color: AppColors.whiteF0F0F0,
                      thickness: 1,
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(AppStrings.leadFollowUpReminders),
                      titleTextStyle: TextStyles.medium(
                        14,
                        fontColor: AppColors.black141414,
                      ),
                      subtitle:
                          Text(AppStrings.ifALeadDoesntRespondWithin24Hours),
                      subtitleTextStyle: TextStyles.regular(
                        11,
                        fontColor: AppColors.grey888888,
                      ),
                      onTap: () {
                        controller.isLeadFollowUpReminders =
                            !controller.isLeadFollowUpReminders;
                        if (controller.isLeadFollowUpReminders == false) {
                          controller.selectedHours = null;
                        }
                        controller.update();
                      },
                      trailing: CommonSwitchButton(
                        value: controller.isLeadFollowUpReminders,
                        onChanged: (newValue) {
                          controller.isLeadFollowUpReminders = newValue;
                          if (controller.isLeadFollowUpReminders == false) {
                            controller.selectedHours = null;
                          }
                          controller.update();
                        },
                      ),
                    ),
                    Gap(0.5.h),
                    Visibility(
                      visible: controller.isLeadFollowUpReminders,
                      child: Row(
                        children: List.generate(
                          4,
                          (index) {
                            return InkWell(
                              onTap: () {
                                controller.selectedHours = index + 1;
                                controller.update();
                              },
                              child: Container(
                                height: 5.h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: AppColors.whiteE5E5E,
                                  ),
                                ),
                                padding:
                                    EdgeInsets.symmetric(horizontal: 0.5.w),
                                margin: EdgeInsets.only(
                                  left: (index != 0) ? 0.5.w : 0.w,
                                  right: (index != 3) ? 0.5.w : 0.w,
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      (controller.selectedHours == index + 1)
                                          ? Icons.radio_button_checked
                                          : Icons.radio_button_off,
                                      size: 13.5.sp,
                                      color: (controller.selectedHours ==
                                              index + 1)
                                          ? AppColors.primaryColor
                                          : AppColors.whiteEBEBEB,
                                    ),
                                    Gap(0.5.w),
                                    Text(
                                      '${index + 1} ${AppStrings.hours}',
                                      style: TextStyles.medium(
                                        11,
                                        fontColor: AppColors.black141414,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    Divider(
                      color: AppColors.whiteF0F0F0,
                      thickness: 3.5.sp,
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(AppStrings.workflowAutomations),
                      titleTextStyle: TextStyles.medium(
                        14,
                        fontColor: AppColors.black141414,
                      ),
                      subtitle:
                          Text(AppStrings.wheneverVABotCompletesATaskForYou),
                      subtitleTextStyle: TextStyles.regular(
                        11,
                        fontColor: AppColors.grey888888,
                      ),
                      onTap: () {
                        controller.isWorkflowAutomations =
                            !controller.isWorkflowAutomations;

                        controller.update();
                      },
                      trailing: CommonSwitchButton(
                        value: controller.isWorkflowAutomations,
                        onChanged: (newValue) {
                          controller.isWorkflowAutomations = newValue;

                          controller.update();
                        },
                      ),
                    ),
                    Divider(
                      color: AppColors.whiteF0F0F0,
                      thickness: 3.5.sp,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          AppStrings.defaultNotificationPreferences,
                          style: TextStyles.semiBold(
                            20,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            if (controller.notificationPreference
                                .every((e) => e['status'])) {
                              controller.turnOffAllNotification();
                            } else {
                              controller.turnOnAllNotification();
                            }
                          },
                          child: Container(
                            height: 4.h,
                            decoration: BoxDecoration(
                              color: AppColors.blueDBEAFE,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 0.8.w),
                            child: Center(
                              child: Text(
                                AppStrings.turnOnAllRecommended(
                                  controller.notificationPreference
                                          .every((e) => e['status'])
                                      ? AppStrings.off
                                      : AppStrings.on,
                                ),
                                style: TextStyles.medium(
                                  11,
                                  fontColor: AppColors.primaryColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Gap(2.h),
                    GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 0.h,
                        crossAxisSpacing: 1.w,
                        childAspectRatio: 6.4.sp,
                      ),
                      shrinkWrap: true,
                      itemCount: controller.notificationPreference.length,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        Map<String, dynamic> data =
                            controller.notificationPreference[index];
                        return InkWell(
                          onTap: () {
                            data['status'] = !data['status'];
                            controller.update();
                          },
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    data['title'],
                                    style: TextStyles.medium(
                                      14,
                                      fontColor: AppColors.black141414,
                                    ),
                                  ),
                                  CommonSwitchButton(
                                      value: data['status'],
                                      onChanged: (newValue) {
                                        data['status'] = newValue;
                                        controller.update();
                                      })
                                ],
                              ),
                              Divider(
                                color: AppColors.whiteF0F0F0,
                                thickness: 3.5.sp,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
