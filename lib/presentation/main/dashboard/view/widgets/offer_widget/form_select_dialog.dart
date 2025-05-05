import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:va_bot_admin/core/theme/colors.dart';
import 'package:va_bot_admin/core/theme/text_styles.dart';
import 'package:va_bot_admin/core/utils/common_widgets/common_button.dart';
import 'package:va_bot_admin/core/utils/common_widgets/common_dialog.dart';
import 'package:va_bot_admin/core/utils/common_widgets/common_text_field.dart';
import 'package:va_bot_admin/gen/assets.gen.dart';
import 'package:va_bot_admin/presentation/main/dashboard/controller/dashboard_controller.dart';
import 'package:va_bot_admin/routes/navigation_routes.dart';

class FormSelectDialog extends StatelessWidget {
  const FormSelectDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonAppDialog(
      padding: EdgeInsets.symmetric(horizontal: 1.w, vertical: 1.h),
      child: GetBuilder<DashboardScreenController>(builder: (controller) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  (controller.dialogCurrentIndex == 0)
                      ? 'Select Form'
                      : (controller.dialogCurrentIndex == 1 ||
                              controller.dialogCurrentIndex == 2)
                          ? 'Seller Information'
                          : 'Buyer Information',
                  style: TextStyles.medium(
                    18,
                    fontColor: AppColors.black141414,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    NavigatorRoute.navigateBack(context: context);
                  },
                  icon: Icon(
                    Icons.close,
                    color: AppColors.greyC3C3C3,
                  ),
                )
              ],
            ),
            Text(
              'Step ${controller.dialogCurrentIndex + 1} of 4',
              style: TextStyles.medium(
                13,
                fontColor: AppColors.grey888888,
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Divider(
                    color: (controller.dialogCurrentIndex >= 0)
                        ? AppColors.primaryColor
                        : AppColors.whiteF5F5F5,
                    thickness: 5.sp,
                  ),
                ),
                Gap(0.5.w),
                Expanded(
                  child: Divider(
                    color: (controller.dialogCurrentIndex > 0)
                        ? AppColors.primaryColor
                        : AppColors.whiteF5F5F5,
                    thickness: 5.sp,
                  ),
                ),
                Gap(0.5.w),
                Expanded(
                  child: Divider(
                    color: (controller.dialogCurrentIndex > 1)
                        ? AppColors.primaryColor
                        : AppColors.whiteF5F5F5,
                    thickness: 5.sp,
                  ),
                ),
                Gap(0.5.w),
                Expanded(
                  child: Divider(
                    color: (controller.dialogCurrentIndex > 2)
                        ? AppColors.primaryColor
                        : AppColors.whiteF5F5F5,
                    thickness: 5.sp,
                  ),
                ),
              ],
            ),
            Container(
              height: 60.h,
              width: 40.w,
              child: PageView(
                controller: controller.dialogPageController,
                onPageChanged: (newIndex) {
                  controller.dialogCurrentIndex = newIndex;
                  controller.update();
                },
                children: [
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 1.h, vertical: 1.h),
                    decoration: BoxDecoration(
                      color: AppColors.whiteF5F5F5,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        CommonTextField(
                          hintText: 'Search anything here',
                          controller: controller.searchFormController,
                          prefixIcon:
                              Assets.icons.icSearch.svg(fit: BoxFit.scaleDown),
                        ),
                        Gap(2.h),
                        ListView.separated(
                          itemCount: controller.formLists.length,
                          separatorBuilder: (BuildContext context, int index) {
                            return Gap(1.h);
                          },
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int index) {
                            Map<String, dynamic> data =
                                controller.formLists[index];
                            return InkWell(
                              onTap: () {
                                data['isSelected'] = !data['isSelected'];
                                controller.update();
                              },
                              child: Row(
                                children: [
                                  (data['isSelected'])
                                      ? Icon(
                                          Icons.check_box,
                                          size: 15,
                                          color: AppColors.primaryColor,
                                        )
                                      : Container(
                                          height: 13.8,
                                          width: 13.8,
                                          color: AppColors.whiteFFFFFF,
                                        ),
                                  Gap(0.8.w),
                                  Expanded(
                                    child: Text(
                                      data['title'],
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyles.medium(
                                        10,
                                        fontColor: AppColors.grey6D6D6D,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 1.h, vertical: 1.h),
                    decoration: BoxDecoration(
                      color: AppColors.whiteFFFFFF,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        CommonTextField(
                          hintText:
                              'Start typing address or MLS number here...',
                          controller: controller.searchAddressController,
                          onChanged: (val) {
                            controller.searchAddress(val);
                          },
                        ),
                        Gap(2.h),
                        Expanded(
                          child: ListView.separated(
                            itemCount: controller.searchedAddress.length,
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return Gap(1.h);
                            },
                            shrinkWrap: true,
                            itemBuilder: (BuildContext context, int index) {
                              String data = controller.searchedAddress[index];
                              return InkWell(
                                onTap: () {
                                  controller.searchAddressController.text =
                                      data;
                                  controller.searchAddress('');
                                  controller.update();
                                },
                                hoverColor: AppColors.black141414,
                                child: Row(
                                  children: [
                                    Container(
                                      height: 5.h,
                                      width: 5.h,
                                      decoration: BoxDecoration(
                                        color: AppColors.whiteFFFFFF,
                                        borderRadius: BorderRadius.circular(10),
                                        image: DecorationImage(
                                          image: AssetImage(
                                            Assets.images.house1.path,
                                          ),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Gap(1.w),
                                    Text(
                                      data,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyles.medium(
                                        11.2,
                                        fontColor: AppColors.grey6D6D6D,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 1.h, vertical: 1.h),
                    decoration: BoxDecoration(
                      color: AppColors.whiteFFFFFF,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ScrollConfiguration(
                      behavior: ScrollBehavior().copyWith(scrollbars: false),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Name',
                              style: TextStyles.medium(
                                12,
                                fontColor: AppColors.black141414,
                              ),
                            ),
                            Gap(0.5.h),
                            CommonTextField(
                              hintText: 'Enter Name',
                              controller: controller.sellerNameController,
                              textStyle: TextStyles.regular(
                                11.5,
                                fontColor: AppColors.black141414,
                              ),
                            ),
                            Gap(1.h),
                            Text(
                              'Email',
                              style: TextStyles.medium(
                                12,
                                fontColor: AppColors.black141414,
                              ),
                            ),
                            Gap(0.5.h),
                            CommonTextField(
                              hintText: 'Enter Email',
                              controller: controller.sellerEmailController,
                              textStyle: TextStyles.regular(
                                11.5,
                                fontColor: AppColors.black141414,
                              ),
                            ),
                            Gap(1.h),
                            Text(
                              'Phone Number',
                              style: TextStyles.medium(
                                12,
                                fontColor: AppColors.black141414,
                              ),
                            ),
                            Gap(0.5.h),
                            CommonTextField(
                              hintText: 'Enter Phone Number',
                              controller:
                                  controller.sellerPhoneNumberController,
                              textStyle: TextStyles.regular(
                                11.5,
                                fontColor: AppColors.black141414,
                              ),
                            ),
                            Gap(1.h),
                            Text(
                              'Address',
                              style: TextStyles.medium(
                                12,
                                fontColor: AppColors.black141414,
                              ),
                            ),
                            Gap(0.5.h),
                            CommonTextField(
                              hintText: 'Enter Address',
                              controller: controller.sellerAddressController,
                              textStyle: TextStyles.regular(
                                11.5,
                                fontColor: AppColors.black141414,
                              ),
                            ),
                            Gap(1.h),
                            Text(
                              'Offered Price',
                              style: TextStyles.medium(
                                12,
                                fontColor: AppColors.black141414,
                              ),
                            ),
                            Gap(0.5.h),
                            CommonTextField(
                              hintText: 'Enter Offered Price',
                              controller: controller.sellerOfferPriceController,
                              textStyle: TextStyles.regular(
                                11.5,
                                fontColor: AppColors.black141414,
                              ),
                            ),
                            Gap(1.h),
                            Text(
                              'Broker name',
                              style: TextStyles.medium(
                                12,
                                fontColor: AppColors.black141414,
                              ),
                            ),
                            Gap(0.5.h),
                            CommonTextField(
                              hintText: 'Enter Broker name',
                              controller: controller.sellerBrokerNameController,
                              textStyle: TextStyles.regular(
                                11.5,
                                fontColor: AppColors.black141414,
                              ),
                            ),
                            Gap(1.h),
                            Text(
                              'Percentage Brokerage',
                              style: TextStyles.medium(
                                12,
                                fontColor: AppColors.black141414,
                              ),
                            ),
                            Gap(0.5.h),
                            CommonTextField(
                              hintText: 'Enter Percentage Brokerage',
                              controller: controller
                                  .sellerPercentageBrokerageController,
                              textStyle: TextStyles.regular(
                                11.5,
                                fontColor: AppColors.black141414,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 1.h, vertical: 1.h),
                    decoration: BoxDecoration(
                      color: AppColors.whiteFFFFFF,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ScrollConfiguration(
                      behavior: ScrollBehavior().copyWith(scrollbars: false),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Name',
                              style: TextStyles.medium(
                                12,
                                fontColor: AppColors.black141414,
                              ),
                            ),
                            Gap(0.5.h),
                            CommonTextField(
                              hintText: 'Enter Name',
                              controller: controller.buyerNameController,
                              textStyle: TextStyles.regular(
                                11.5,
                                fontColor: AppColors.black141414,
                              ),
                            ),
                            Gap(1.h),
                            Text(
                              'Email',
                              style: TextStyles.medium(
                                12,
                                fontColor: AppColors.black141414,
                              ),
                            ),
                            Gap(0.5.h),
                            CommonTextField(
                              hintText: 'Enter Email',
                              controller: controller.buyerEmailController,
                              textStyle: TextStyles.regular(
                                11.5,
                                fontColor: AppColors.black141414,
                              ),
                            ),
                            Gap(1.h),
                            Text(
                              'Phone Number',
                              style: TextStyles.medium(
                                12,
                                fontColor: AppColors.black141414,
                              ),
                            ),
                            Gap(0.5.h),
                            CommonTextField(
                              hintText: 'Enter Phone Number',
                              controller: controller.buyerPhoneNumberController,
                              textStyle: TextStyles.regular(
                                11.5,
                                fontColor: AppColors.black141414,
                              ),
                            ),
                            Gap(1.h),
                            Text(
                              'Address',
                              style: TextStyles.medium(
                                12,
                                fontColor: AppColors.black141414,
                              ),
                            ),
                            Gap(0.5.h),
                            CommonTextField(
                              hintText: 'Enter Address',
                              controller: controller.buyerEmailController,
                              textStyle: TextStyles.regular(
                                11.5,
                                fontColor: AppColors.black141414,
                              ),
                            ),
                            Gap(1.h),
                            Text(
                              'Offered Price',
                              style: TextStyles.medium(
                                12,
                                fontColor: AppColors.black141414,
                              ),
                            ),
                            Gap(0.5.h),
                            CommonTextField(
                              hintText: 'Enter Offered Price',
                              controller: controller.buyerOfferPriceController,
                              textStyle: TextStyles.regular(
                                11.5,
                                fontColor: AppColors.black141414,
                              ),
                            ),
                            Gap(1.h),
                            Text(
                              'Broker name',
                              style: TextStyles.medium(
                                12,
                                fontColor: AppColors.black141414,
                              ),
                            ),
                            Gap(0.5.h),
                            CommonTextField(
                              hintText: 'Enter Broker name',
                              controller: controller.buyerBrokerNameController,
                              textStyle: TextStyles.regular(
                                11.5,
                                fontColor: AppColors.black141414,
                              ),
                            ),
                            Gap(1.h),
                            Text(
                              'Percentage Brokerage',
                              style: TextStyles.medium(
                                12,
                                fontColor: AppColors.black141414,
                              ),
                            ),
                            Gap(0.5.h),
                            CommonTextField(
                              hintText: 'Enter Percentage Brokerage',
                              controller:
                                  controller.buyerPercentageBrokerageController,
                              textStyle: TextStyles.regular(
                                11.5,
                                fontColor: AppColors.black141414,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Gap(1.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CommonButton(
                  onPressed: () {
                    NavigatorRoute.navigateBack(context: context);
                  },
                  borderColor: AppColors.whiteE1E1E1,
                  buttonColor: AppColors.whiteFFFFFF,
                  child: Text(
                    'Cancel',
                    style: TextStyles.medium(
                      12,
                      fontColor: AppColors.black141414,
                    ),
                  ),
                ),
                CommonButton(
                  onPressed: () {
                    if (controller.dialogCurrentIndex != 3) {
                      controller.dialogPageController.animateToPage(
                        controller.dialogCurrentIndex + 1,
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeIn,
                      );
                    } else {
                      NavigatorRoute.navigateBack(context: context);
                      controller.registerViewFactory();
                      controller.isShowFullSideMenu = false;
                      controller.isPDFEditor = true;
                      controller.update();
                    }
                  },
                  child: Text(
                    'Continue',
                    style: TextStyles.medium(
                      12,
                      fontColor: AppColors.whiteFFFFFF,
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      }),
    );
  }
}
