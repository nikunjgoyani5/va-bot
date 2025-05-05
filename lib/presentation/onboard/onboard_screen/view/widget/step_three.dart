import 'package:va_bot_admin/presentation/onboard/onboard_screen/controller/onboard_controller.dart';
import 'package:va_bot_admin/core/utils/common_widgets/common_text_field.dart';
import 'package:va_bot_admin/core/utils/common_widgets/common_button.dart';
import 'package:va_bot_admin/core/constant/app_strings.dart';
import 'package:va_bot_admin/core/theme/text_styles.dart';
import 'package:va_bot_admin/core/theme/colors.dart';
import 'package:va_bot_admin/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class StepThree extends StatelessWidget {
  const StepThree({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OnBoardController>(builder: (controller) {
      return Container(
        width: 40.88.w,
        color: AppColors.transparent,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gap(4.h),
            Text(
              'Step ${controller.threeCurrentPage} of 4',
              style: TextStyles.medium(
                14,
                fontColor: AppColors.grey888888,
              ),
            ),
            Expanded(
              child: PageView(
                scrollDirection: Axis.horizontal,
                controller: controller.threePageController,
                onPageChanged: (int page) {
                  controller.threeCurrentPage = page + 1;
                  controller.update();
                },
                physics: NeverScrollableScrollPhysics(),
                children: [
                  /// STEP = 1
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppStrings.transactionLeadHandlingPreference,
                          style: TextStyles.bold(
                            30,
                            fontColor: AppColors.black141414,
                          ),
                        ),
                        Gap(3.h),
                        Text(
                          AppStrings.howManyTransactionsDoYouCloseInAMonth,
                          style: TextStyles.medium(
                            14,
                            fontColor: AppColors.black141414,
                          ),
                        ),
                        Gap(0.5.h),
                        CommonTextField(
                          hintText: AppStrings.selectAEstimateYourAverage,
                          controller: controller.transactionController,
                          readOnly: true,
                          onTap: () {
                            controller.isShowTransactionContainer =
                                !controller.isShowTransactionContainer;
                            controller.update();
                          },
                          suffixIcon: Assets.icons.icDropdownArrow
                              .svg(fit: BoxFit.scaleDown),
                        ),
                        Gap(1.h),
                        Visibility(
                          visible: controller.isShowTransactionContainer,
                          child: Container(
                            width: double.infinity,
                            constraints: BoxConstraints(maxHeight: 36.h),
                            decoration: BoxDecoration(
                              border: Border.all(color: AppColors.whiteE1E1E1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: ListView.separated(
                              separatorBuilder:
                                  (BuildContext context, int index) {
                                return Gap(1.h);
                              },
                              itemCount: controller.transactionDetails.length,
                              itemBuilder: (BuildContext context, int index) {
                                String data =
                                    controller.transactionDetails[index];
                                return InkWell(
                                  onTap: () {
                                    controller.transactionController.text =
                                        data;
                                    controller.isShowTransactionContainer =
                                        false;
                                    controller.update();
                                    controller.threePageController.nextPage(
                                      duration: Duration(milliseconds: 500),
                                      curve: Curves.easeIn,
                                    );
                                  },
                                  hoverColor: AppColors.whiteEDF9FF,
                                  borderRadius: BorderRadius.circular(6),
                                  child: Container(
                                    height: 5.h,
                                    width: double.infinity,
                                    color: Colors.transparent,
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 1.w),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          data,
                                          style: TextStyles.medium(
                                            11,
                                            fontColor: AppColors.black141414,
                                          ),
                                        ),
                                        (controller.transactionController.text
                                                    .toLowerCase() ==
                                                data.toLowerCase())
                                            ? Assets.icons.icChecked.svg(
                                                colorFilter: ColorFilter.mode(
                                                  AppColors.primaryColor,
                                                  BlendMode.srcIn,
                                                ),
                                              )
                                            : SizedBox.shrink(),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        )
                      ],
                    ),
                  ),

                  /// STEP = 2
                  Container(
                    child: SingleChildScrollView(
                      child: Form(
                        key: controller.threeFormKey1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppStrings.leadAndClientCommunication,
                              style: TextStyles.bold(
                                30,
                                fontColor: AppColors.black141414,
                              ),
                            ),
                            Gap(3.h),
                            Text(
                              AppStrings.whatIsYourPrefferedLeadFollowUpTime,
                              style: TextStyles.medium(
                                14,
                                fontColor: AppColors.black141414,
                              ),
                            ),
                            Gap(0.5.h),
                            CommonTextField(
                              hintText:
                                  AppStrings.selectWhatIsYourPrefferedLead,
                              controller: controller.followUpTimeController,
                              readOnly: true,
                              onTap: () {
                                controller.isShowBookShowingContainer = false;
                                controller.isShowShowingConfirmations = false;
                                controller.isShowFollowUpContainer =
                                    !controller.isShowFollowUpContainer;
                                controller.update();
                              },
                              validator: (val) {
                                if (val == null || val.trim().isEmpty) {
                                  return AppStrings
                                      .selectPrefferedLeadFollowUptime;
                                }
                                return null;
                              },
                              suffixIcon: Assets.icons.icDropdownArrow
                                  .svg(fit: BoxFit.scaleDown),
                            ),
                            Gap(1.h),
                            Visibility(
                              visible: controller.isShowFollowUpContainer,
                              child: Container(
                                width: double.infinity,
                                constraints: BoxConstraints(maxHeight: 20.h),
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(color: AppColors.whiteE1E1E1),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: ListView.separated(
                                  separatorBuilder:
                                      (BuildContext context, int index) {
                                    return Gap(0.5.h);
                                  },
                                  itemCount:
                                      controller.followUpTimeDetail.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    String data =
                                        controller.followUpTimeDetail[index];
                                    return InkWell(
                                      onTap: () {
                                        controller.followUpTimeController.text =
                                            data;
                                        controller.isShowFollowUpContainer =
                                            false;
                                        controller.update();
                                      },
                                      hoverColor: AppColors.whiteEDF9FF,
                                      borderRadius: BorderRadius.circular(6),
                                      child: Container(
                                        height: 4.h,
                                        width: double.infinity,
                                        color: Colors.transparent,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 1.w),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              data,
                                              style: TextStyles.medium(
                                                11,
                                                fontColor:
                                                    AppColors.black141414,
                                              ),
                                            ),
                                            (controller.followUpTimeController
                                                        .text
                                                        .toLowerCase() ==
                                                    data.toLowerCase())
                                                ? Assets.icons.icChecked.svg(
                                                    colorFilter:
                                                        ColorFilter.mode(
                                                      AppColors.primaryColor,
                                                      BlendMode.srcIn,
                                                    ),
                                                  )
                                                : SizedBox.shrink(),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                            //...............................................................................................................
                            Gap(2.h),
                            Text(
                              AppStrings.howDoYouBookShowings,
                              style: TextStyles.medium(
                                14,
                                fontColor: AppColors.black141414,
                              ),
                            ),
                            Gap(0.5.h),
                            CommonTextField(
                              hintText: AppStrings.selectAHowDoYouBookShowings,
                              controller: controller.bookShowingController,
                              readOnly: true,
                              onTap: () {
                                controller.isShowFollowUpContainer = false;
                                controller.isShowShowingConfirmations = false;
                                controller.isShowBookShowingContainer =
                                    !controller.isShowBookShowingContainer;
                                controller.update();
                              },
                              validator: (val) {
                                if (val == null || val.trim().isEmpty) {
                                  return AppStrings.selectBookShowing;
                                }
                                return null;
                              },
                              suffixIcon: Assets.icons.icDropdownArrow
                                  .svg(fit: BoxFit.scaleDown),
                            ),
                            Gap(1.h),
                            Visibility(
                              visible: controller.isShowBookShowingContainer,
                              child: Container(
                                width: double.infinity,
                                constraints: BoxConstraints(maxHeight: 20.h),
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(color: AppColors.whiteE1E1E1),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: ListView.separated(
                                  separatorBuilder:
                                      (BuildContext context, int index) {
                                    return Gap(0.5.h);
                                  },
                                  itemCount:
                                      controller.bookShowingDetail.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    String data =
                                        controller.bookShowingDetail[index];
                                    return InkWell(
                                      onTap: () {
                                        controller.bookShowingController.text =
                                            data;
                                        controller.isShowBookShowingContainer =
                                            false;
                                        controller.update();
                                      },
                                      hoverColor: AppColors.whiteEDF9FF,
                                      borderRadius: BorderRadius.circular(6),
                                      child: Container(
                                        height: 4.h,
                                        width: double.infinity,
                                        color: Colors.transparent,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 1.w),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              data,
                                              style: TextStyles.medium(
                                                11,
                                                fontColor:
                                                    AppColors.black141414,
                                              ),
                                            ),
                                            (controller.bookShowingController
                                                        .text
                                                        .toLowerCase() ==
                                                    data.toLowerCase())
                                                ? Assets.icons.icChecked.svg(
                                                    colorFilter:
                                                        ColorFilter.mode(
                                                      AppColors.primaryColor,
                                                      BlendMode.srcIn,
                                                    ),
                                                  )
                                                : SizedBox.shrink(),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                            //...............................................................................................................
                            Gap(2.h),
                            Text(
                              AppStrings.doYouWantTheVABotToAutomate,
                              style: TextStyles.medium(
                                14,
                                fontColor: AppColors.black141414,
                              ),
                            ),
                            Gap(0.5.h),
                            CommonTextField(
                              hintText: AppStrings.selectADoYouWantTheVABot,
                              controller:
                                  controller.showingConfirmationController,
                              readOnly: true,
                              onTap: () {
                                controller.isShowFollowUpContainer = false;
                                controller.isShowBookShowingContainer = false;
                                controller.isShowShowingConfirmations =
                                    !controller.isShowShowingConfirmations;
                                controller.update();
                              },
                              validator: (val) {
                                if (val == null || val.trim().isEmpty) {
                                  return AppStrings.selectShowingConfirmation;
                                }
                                return null;
                              },
                              suffixIcon: Assets.icons.icDropdownArrow
                                  .svg(fit: BoxFit.scaleDown),
                            ),
                            Gap(1.h),
                            Visibility(
                              visible: controller.isShowShowingConfirmations,
                              child: Container(
                                width: double.infinity,
                                constraints: BoxConstraints(maxHeight: 20.h),
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(color: AppColors.whiteE1E1E1),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: ListView.separated(
                                  separatorBuilder:
                                      (BuildContext context, int index) {
                                    return Gap(0.5.h);
                                  },
                                  itemCount:
                                      controller.showConfirmationDetail.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    String data = controller
                                        .showConfirmationDetail[index];
                                    return InkWell(
                                      onTap: () {
                                        controller.showingConfirmationController
                                            .text = data;
                                        controller.isShowShowingConfirmations =
                                            false;
                                        controller.update();
                                      },
                                      hoverColor: AppColors.whiteEDF9FF,
                                      borderRadius: BorderRadius.circular(6),
                                      child: Container(
                                        height: 4.h,
                                        width: double.infinity,
                                        color: Colors.transparent,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 1.w),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              data,
                                              style: TextStyles.medium(
                                                11,
                                                fontColor:
                                                    AppColors.black141414,
                                              ),
                                            ),
                                            (controller.showingConfirmationController
                                                        .text
                                                        .toLowerCase() ==
                                                    data.toLowerCase())
                                                ? Assets.icons.icChecked.svg(
                                                    colorFilter:
                                                        ColorFilter.mode(
                                                      AppColors.primaryColor,
                                                      BlendMode.srcIn,
                                                    ),
                                                  )
                                                : SizedBox.shrink(),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                            //...............................................................................................................
                            Gap(2.h),
                            Text(
                              AppStrings.doYouWantVABotToCallLeads,
                              style: TextStyles.medium(
                                14,
                                fontColor: AppColors.black141414,
                              ),
                            ),
                            Gap(0.5.h),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: List.generate(
                                  controller.callLeadReason.length,
                                  (index) {
                                    String data =
                                        controller.callLeadReason[index];
                                    return InkWell(
                                      onTap: () {
                                        controller.selectedCallReason = data;
                                        controller.update();
                                      },
                                      child: Container(
                                        height: 5.h,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(
                                            color: (controller
                                                        .selectedCallReason
                                                        .toLowerCase() ==
                                                    data.toLowerCase())
                                                ? AppColors.primaryColor
                                                : AppColors.whiteE1E1E1,
                                          ),
                                        ),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 1.w),
                                        margin: EdgeInsets.only(
                                          left: (index != 0) ? 0.4.w : 0.w,
                                          right: (index != 2) ? 0.4.w : 0.w,
                                        ),
                                        child: Center(
                                          child: Text(
                                            data,
                                            style: TextStyles.medium(
                                              12,
                                              fontColor: AppColors.grey6D6D6D,
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                            //...............................................................................................................
                            Gap(2.h),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CommonButton(
                                  onPressed: () {
                                    controller.threePageController.previousPage(
                                        duration: Duration(milliseconds: 300),
                                        curve: Curves.easeIn);
                                  },
                                  buttonColor: AppColors.whiteFFFFFF,
                                  borderColor: AppColors.whiteE1E1E1,
                                  child: Text(
                                    AppStrings.previousStep,
                                    style: TextStyles.medium(
                                      12,
                                      fontColor: AppColors.grey6D6D6D,
                                    ),
                                  ),
                                ),
                                CommonButton(
                                  onPressed: () {
                                    // if (controller.threeFormKey1.currentState
                                    //         ?.validate() ??
                                    //     false) {
                                    controller.threePageController.nextPage(
                                      duration: Duration(milliseconds: 300),
                                      curve: Curves.easeIn,
                                    );
                                    // }
                                  },
                                  child: Text(
                                    AppStrings.nextStep,
                                    style: TextStyles.medium(12,
                                        fontColor: AppColors.whiteF5F5F5),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  /// STEP = 3
                  Container(
                    child: SingleChildScrollView(
                      child: Form(
                        key: controller.threeFormKe2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppStrings.crmDataIntegration,
                              style: TextStyles.bold(
                                30,
                                fontColor: AppColors.black141414,
                              ),
                            ),
                            Gap(3.h),
                            Text(
                              AppStrings.doYouWantTheVABotToSyncWithYourCRM,
                              style: TextStyles.medium(
                                14,
                                fontColor: AppColors.black141414,
                              ),
                            ),
                            Gap(0.5.h),
                            CommonTextField(
                              hintText: AppStrings
                                  .selectADoYouWantTheVABotToSyncWithYourCRM,
                              controller: controller.crmController,
                              readOnly: true,
                              onTap: () {
                                controller.isShowTrackLeadClientDetails = false;
                                controller.isShowCrmDetails =
                                    !controller.isShowCrmDetails;
                                controller.update();
                              },
                              validator: (val) {
                                if (val == null || val.trim().isEmpty) {
                                  return AppStrings.required;
                                }
                                return null;
                              },
                              suffixIcon: Assets.icons.icDropdownArrow
                                  .svg(fit: BoxFit.scaleDown),
                            ),
                            Gap(1.h),
                            Visibility(
                              visible: controller.isShowCrmDetails,
                              child: Container(
                                width: double.infinity,
                                constraints: BoxConstraints(maxHeight: 20.h),
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(color: AppColors.whiteE1E1E1),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: ListView.separated(
                                  separatorBuilder:
                                      (BuildContext context, int index) {
                                    return Gap(0.5.h);
                                  },
                                  itemCount: controller.crmDetails.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    String data = controller.crmDetails[index];
                                    return InkWell(
                                      onTap: () {
                                        controller.crmController.text = data;
                                        controller.isShowCrmDetails = false;
                                        controller.update();
                                      },
                                      hoverColor: AppColors.whiteEDF9FF,
                                      borderRadius: BorderRadius.circular(6),
                                      child: Container(
                                        height: 4.h,
                                        width: double.infinity,
                                        color: Colors.transparent,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 1.w),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              data,
                                              style: TextStyles.medium(
                                                11,
                                                fontColor:
                                                    AppColors.black141414,
                                              ),
                                            ),
                                            (controller.crmController.text
                                                        .toLowerCase() ==
                                                    data.toLowerCase())
                                                ? Assets.icons.icChecked.svg(
                                                    colorFilter:
                                                        ColorFilter.mode(
                                                      AppColors.primaryColor,
                                                      BlendMode.srcIn,
                                                    ),
                                                  )
                                                : SizedBox.shrink(),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                            //...............................................................................................................
                            Gap(2.h),
                            Text(
                              AppStrings.howDoYouCurrentlyTrackYourLeadsClients,
                              style: TextStyles.medium(
                                14,
                                fontColor: AppColors.black141414,
                              ),
                            ),
                            Gap(0.5.h),
                            CommonTextField(
                              hintText: AppStrings
                                  .selectAHowDoYouCurrentlyTrackYourLeadsClients,
                              controller: controller.leadClientController,
                              readOnly: true,
                              onTap: () {
                                controller.isShowCrmDetails = false;
                                controller.isShowTrackLeadClientDetails =
                                    !controller.isShowTrackLeadClientDetails;
                                controller.update();
                              },
                              validator: (val) {
                                if (val == null || val.trim().isEmpty) {
                                  return AppStrings.required;
                                }
                                return null;
                              },
                              suffixIcon: Assets.icons.icDropdownArrow
                                  .svg(fit: BoxFit.scaleDown),
                            ),
                            Gap(1.h),
                            Visibility(
                              visible: controller.isShowTrackLeadClientDetails,
                              child: Container(
                                width: double.infinity,
                                constraints: BoxConstraints(maxHeight: 20.h),
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(color: AppColors.whiteE1E1E1),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: ListView.separated(
                                  separatorBuilder:
                                      (BuildContext context, int index) {
                                    return Gap(0.5.h);
                                  },
                                  itemCount:
                                      controller.leadClientDetails.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    String data =
                                        controller.leadClientDetails[index];
                                    return InkWell(
                                      onTap: () {
                                        controller.leadClientController.text =
                                            data;
                                        controller
                                                .isShowTrackLeadClientDetails =
                                            false;
                                        controller.update();
                                      },
                                      hoverColor: AppColors.whiteEDF9FF,
                                      borderRadius: BorderRadius.circular(6),
                                      child: Container(
                                        height: 4.h,
                                        width: double.infinity,
                                        color: Colors.transparent,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 1.w),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              data,
                                              style: TextStyles.medium(
                                                11,
                                                fontColor:
                                                    AppColors.black141414,
                                              ),
                                            ),
                                            (controller.leadClientController
                                                        .text
                                                        .toLowerCase() ==
                                                    data.toLowerCase())
                                                ? Assets.icons.icChecked.svg(
                                                    colorFilter:
                                                        ColorFilter.mode(
                                                      AppColors.primaryColor,
                                                      BlendMode.srcIn,
                                                    ),
                                                  )
                                                : SizedBox.shrink(),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ), //...............................................................................................................
                            Gap(2.h),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CommonButton(
                                  onPressed: () {
                                    controller.threePageController.previousPage(
                                      duration: Duration(milliseconds: 300),
                                      curve: Curves.easeIn,
                                    );
                                  },
                                  buttonColor: AppColors.whiteFFFFFF,
                                  borderColor: AppColors.whiteE1E1E1,
                                  child: Text(
                                    AppStrings.previousStep,
                                    style: TextStyles.medium(
                                      12,
                                      fontColor: AppColors.grey6D6D6D,
                                    ),
                                  ),
                                ),
                                CommonButton(
                                  onPressed: () {
                                    // if (controller.threeFormKe2.currentState
                                    //         ?.validate() ??
                                    //     false) {
                                    controller.threePageController.nextPage(
                                      duration: Duration(milliseconds: 300),
                                      curve: Curves.easeIn,
                                    );
                                    // }
                                  },
                                  child: Text(
                                    AppStrings.nextStep,
                                    style: TextStyles.medium(12,
                                        fontColor: AppColors.whiteF5F5F5),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  /// STEP = 4
                  Container(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppStrings.businessGoalsAutomationPreference,
                            style: TextStyles.bold(
                              30,
                              fontColor: AppColors.black141414,
                            ),
                          ),
                          Gap(3.h),
                          Text(
                            AppStrings.whatIsYourBusinessGoal,
                            style: TextStyles.medium(
                              14,
                              fontColor: AppColors.black141414,
                            ),
                          ),
                          Gap(0.5.h),
                          Form(
                            key: controller.threeFormKe3,
                            child: CommonTextField(
                              hintText: AppStrings.selectWhatIsYourBusinessGoal,
                              controller: controller.businessGoalController,
                              readOnly: true,
                              onTap: () {
                                controller.isShowBusinessDetail =
                                    !controller.isShowBusinessDetail;
                                controller.update();
                              },
                              validator: (val) {
                                if (val == null || val.trim().isEmpty) {
                                  return AppStrings.required;
                                }
                                return null;
                              },
                              suffixIcon: Assets.icons.icDropdownArrow
                                  .svg(fit: BoxFit.scaleDown),
                            ),
                          ),
                          Gap(1.h),
                          Visibility(
                            visible: controller.isShowBusinessDetail,
                            child: Container(
                              width: double.infinity,
                              constraints: BoxConstraints(maxHeight: 20.h),
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: AppColors.whiteE1E1E1),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: ListView.separated(
                                separatorBuilder:
                                    (BuildContext context, int index) {
                                  return Gap(0.5.h);
                                },
                                itemCount:
                                    controller.businessGoalDetails.length,
                                itemBuilder: (BuildContext context, int index) {
                                  String data =
                                      controller.businessGoalDetails[index];
                                  return InkWell(
                                    onTap: () {
                                      controller.businessGoalController.text =
                                          data;
                                      controller.isShowBusinessDetail = false;
                                      controller.update();
                                    },
                                    hoverColor: AppColors.whiteEDF9FF,
                                    borderRadius: BorderRadius.circular(6),
                                    child: Container(
                                      height: 4.h,
                                      width: double.infinity,
                                      color: Colors.transparent,
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 1.w),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            data,
                                            style: TextStyles.medium(
                                              11,
                                              fontColor: AppColors.black141414,
                                            ),
                                          ),
                                          (controller.businessGoalController
                                                      .text
                                                      .toLowerCase() ==
                                                  data.toLowerCase())
                                              ? Assets.icons.icChecked.svg(
                                                  colorFilter: ColorFilter.mode(
                                                    AppColors.primaryColor,
                                                    BlendMode.srcIn,
                                                  ),
                                                )
                                              : SizedBox.shrink(),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                          //...............................................................................................................
                          Gap(2.h),
                          Text(
                            AppStrings.prefillCommonGoals,
                            style: TextStyles.medium(
                              14,
                              fontColor: AppColors.black141414,
                            ),
                          ),
                          Gap(0.5.h),
                          Wrap(
                            spacing: 10.sp,
                            runSpacing: 10.sp,
                            children: List.generate(
                              controller.prefilledCommonGoals.length,
                              (index) {
                                String data =
                                    controller.prefilledCommonGoals[index];
                                return InkWell(
                                  onTap: () {
                                    controller.selectedPreFilledGoal = data;
                                    controller.update();
                                  },
                                  child: Container(
                                    height: 5.h,
                                    padding: EdgeInsets.only(
                                      left: 1.w,
                                      right: 1.w,
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          color: AppColors.greyE5E5E5),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(
                                          (controller.selectedPreFilledGoal
                                                      .toLowerCase() ==
                                                  data.toLowerCase())
                                              ? Icons.radio_button_checked
                                              : Icons.radio_button_off,
                                          size: 17,
                                          color: (controller
                                                      .selectedPreFilledGoal
                                                      .toLowerCase() ==
                                                  data.toLowerCase())
                                              ? AppColors.primaryColor
                                              : AppColors.whiteEBEBEB,
                                        ),
                                        Gap(0.3.w),
                                        Text(
                                          data,
                                          style: TextStyles.medium(11,
                                              fontColor: AppColors.black141414),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          //...............................................................................................................
                          Gap(2.h),
                          Text(
                            AppStrings.basedOnYourSelections,
                            style: TextStyles.medium(
                              14,
                              fontColor: AppColors.black141414,
                            ),
                          ),
                          Gap(0.5.h),
                          Wrap(
                            spacing: 10.sp,
                            runSpacing: 10.sp,
                            children: List.generate(
                              controller.basedOnDetails.length,
                              (index) {
                                String data = controller.basedOnDetails[index];
                                return InkWell(
                                  onTap: () {
                                    if (controller.selectedBasedOnDetails
                                        .contains(data)) {
                                      controller.selectedBasedOnDetails
                                          .remove(data);
                                    } else {
                                      controller.selectedBasedOnDetails
                                          .add(data);
                                    }
                                    controller.update();
                                  },
                                  child: Container(
                                    height: 5.h,
                                    padding: EdgeInsets.only(
                                      left: 1.w,
                                      right: 1.w,
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          color: AppColors.greyE5E5E5),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(
                                          controller.selectedBasedOnDetails
                                                  .contains(data)
                                              ? Icons.check_box
                                              : Icons
                                                  .check_box_outline_blank_outlined,
                                          size: 13.5.sp,
                                          color: controller
                                                  .selectedBasedOnDetails
                                                  .contains(data)
                                              ? AppColors.primaryColor
                                              : AppColors.whiteEBEBEB,
                                        ),
                                        Gap(0.3.w),
                                        Text(
                                          data,
                                          style: TextStyles.medium(11,
                                              fontColor: AppColors.black141414),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          //...............................................................................................................
                          Gap(2.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CommonButton(
                                onPressed: () {
                                  controller.threePageController.previousPage(
                                    duration: Duration(milliseconds: 300),
                                    curve: Curves.easeIn,
                                  );
                                },
                                buttonColor: AppColors.whiteFFFFFF,
                                borderColor: AppColors.whiteE1E1E1,
                                child: Text(
                                  AppStrings.previousStep,
                                  style: TextStyles.medium(
                                    10.5,
                                    fontColor: AppColors.grey6D6D6D,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}
