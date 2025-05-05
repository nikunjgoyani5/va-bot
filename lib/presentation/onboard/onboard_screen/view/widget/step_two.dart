import 'package:va_bot_admin/presentation/onboard/onboard_screen/controller/onboard_controller.dart';
import 'package:va_bot_admin/core/utils/common_widgets/common_text_field.dart';
import 'package:va_bot_admin/data/model/onboard_model/crm_tools_model.dart';
import 'package:va_bot_admin/core/utils/common_widgets/common_button.dart';
import 'package:va_bot_admin/core/constant/app_strings.dart';
import 'package:va_bot_admin/core/theme/text_styles.dart';
import 'package:va_bot_admin/core/theme/colors.dart';
import 'package:country_picker/country_picker.dart';
import 'package:va_bot_admin/gen/assets.gen.dart';
import 'dart:developer';

import 'package:country_flags/country_flags.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class StepTwo extends StatelessWidget {
  const StepTwo({super.key});

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
              'Step ${controller.twoCurrentPage} of 2',
              style: TextStyles.medium(
                14,
                fontColor: AppColors.grey888888,
              ),
            ),
            Expanded(
              child: PageView(
                scrollDirection: Axis.horizontal,
                controller: controller.twoPageController,
                onPageChanged: (int page) {
                  controller.twoCurrentPage = page + 1;
                  controller.update();
                },
                children: [
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppStrings.personalizeVABotForYourBusiness,
                          style: TextStyles.bold(
                            30,
                            fontColor: AppColors.black141414,
                          ),
                        ),
                        Text(
                          AppStrings.vaBotWillCustomizeItsRecommendations,
                          style: TextStyles.regular(16,
                              fontColor: AppColors.grey5D5D5D),
                        ),
                        Gap(1.5.h),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  AppStrings.profilePhoto,
                                  style: TextStyles.medium(
                                    14,
                                    fontColor: AppColors.black141414,
                                  ),
                                ),
                                Gap(1.h),
                                InkWell(
                                  onTap: () async {
                                    FilePickerResult? result =
                                        await FilePicker.platform.pickFiles(
                                      allowMultiple: false,
                                      type: FileType.image,
                                    );
                                    controller.pickedFile =
                                        result?.files.single;
                                    controller.update();
                                  },
                                  child: Container(
                                    height: 14.3.h,
                                    width: 14.3.h,
                                    child: Stack(
                                      children: [
                                        Container(
                                          height: 14.h,
                                          width: 14.h,
                                          decoration: BoxDecoration(
                                            color: AppColors.whiteEBEBEB,
                                            shape: BoxShape.circle,
                                            image:
                                                (controller.pickedFile != null)
                                                    ? DecorationImage(
                                                        image: MemoryImage(
                                                          controller.pickedFile!
                                                              .bytes!,
                                                        ),
                                                        fit: BoxFit.cover,
                                                      )
                                                    : null,
                                          ),
                                          child: (controller.pickedFile == null)
                                              ? Icon(
                                                  Icons.person,
                                                  size: 10.h,
                                                  color: AppColors.whiteFFFFFF,
                                                )
                                              : SizedBox(),
                                        ),
                                        Positioned(
                                          bottom: 0,
                                          right: 0,
                                          child: Container(
                                            height: 5.5.h,
                                            width: 5.5.h,
                                            decoration: BoxDecoration(
                                              color: AppColors.black141414,
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                color: AppColors.whiteFFFFFF,
                                                width: 6.sp,
                                              ),
                                            ),
                                            child: Assets.icons.icUpload
                                                .svg(fit: BoxFit.scaleDown),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Gap(2.8.w),
                            Expanded(
                              child: Form(
                                key: controller.twoFormKey,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      AppStrings.fullName,
                                      style: TextStyles.medium(
                                        13,
                                        fontColor: AppColors.black141414,
                                      ),
                                    ),
                                    Gap(0.5.h),
                                    CommonTextField(
                                      hintText: AppStrings.enterYourFullName,
                                      controller: controller.nameController,
                                      validator: (value) {
                                        if (value == null ||
                                            value.trim().isEmpty) {
                                          controller.nameController.clear();
                                          return AppStrings.enterName;
                                        }
                                        return null;
                                      },
                                    ),
                                    Gap(1.8.h),
                                    Text(
                                      AppStrings.role,
                                      style: TextStyles.medium(
                                        13,
                                        fontColor: AppColors.black141414,
                                      ),
                                    ),
                                    Gap(0.5.h),
                                    /* CommonTextField(
                                      hintText: AppStrings.realEstateAgent,
                                      controller: controller.nameController,
                                      suffixIcon: Assets.icons.icDropdownArrow
                                          .svg(fit: BoxFit.scaleDown),
                                    ),*/
                                    DropdownButtonFormField(
                                      isDense: true,
                                      isExpanded: true,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: AppColors.greyE5E5E5,
                                            width: 1.5,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: AppColors.greyE5E5E5,
                                            width: 1.5,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: AppColors.greyE5E5E5,
                                            width: 1.5,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                      hint: Text(
                                        AppStrings.realEstateAgent,
                                        style: TextStyles.regular(12,
                                            fontColor: AppColors.grey888888),
                                      ),
                                      style: TextStyles.regular(12,
                                          fontColor: AppColors.black141414),
                                      icon: Assets.icons.icDropdownArrow.svg(
                                        height: 10.sp,
                                        width: 10.sp,
                                      ),
                                      items: [
                                        DropdownMenuItem(
                                          child: Text('Data 1'),
                                          value: 'Data1',
                                        ),
                                        DropdownMenuItem(
                                          child: Text('Data 2'),
                                          value: 'Data 2',
                                        ),
                                        DropdownMenuItem(
                                          child: Text('Data 3'),
                                          value: 'Data 3',
                                        ),
                                        DropdownMenuItem(
                                          child: Text('Data 4'),
                                          value: 'Data 4',
                                        ),
                                        DropdownMenuItem(
                                          child: Text('Data 5'),
                                          value: 'Data 5',
                                        ),
                                        DropdownMenuItem(
                                          child: Text('Data 6'),
                                          value: 'Data 6',
                                        ),
                                        DropdownMenuItem(
                                          child: Text('Data 7'),
                                          value: 'Data 7',
                                        ),
                                        DropdownMenuItem(
                                          child: Text('Data 8'),
                                          value: 'Data 8',
                                        ),
                                        DropdownMenuItem(
                                          child: Text('Data 9'),
                                          value: 'Data 9',
                                        ),
                                        DropdownMenuItem(
                                          child: Text('Data 10'),
                                          value: 'Data 10',
                                        ),
                                      ],
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return AppStrings.selectARole;
                                        }
                                        return null;
                                      },
                                      onChanged: (val) {
                                        controller.selectedRole = val;
                                        log(val ?? '');
                                        controller.update();
                                      },
                                    ),
                                    Gap(1.8.h),
                                    Text(
                                      AppStrings.emailAddress,
                                      style: TextStyles.medium(
                                        13,
                                        fontColor: AppColors.black141414,
                                      ),
                                    ),
                                    Gap(0.5.h),
                                    CommonTextField(
                                      hintText: AppStrings.emailHint,
                                      controller: controller.emailController,
                                      validator: (val) {
                                        if (val == null || val.trim().isEmpty) {
                                          controller.emailController.clear();
                                          return AppStrings.enterEmailAddress;
                                        }
                                        if (val.isEmail == false) {
                                          return AppStrings.enterValidEmail;
                                        }
                                        return null;
                                      },
                                    ),
                                    Gap(1.8.h),
                                    Text(
                                      AppStrings.phoneNumber,
                                      style: TextStyles.medium(
                                        13,
                                        fontColor: AppColors.black141414,
                                      ),
                                    ),
                                    Gap(0.5.h),
                                    CommonTextField(
                                      hintText: '',
                                      controller: controller.phoneController,
                                      prefixIcon: Padding(
                                        padding: EdgeInsets.only(left: 0.5.w),
                                        child: InkWell(
                                          onTap: () {
                                            showCountryPicker(
                                              context: context,
                                              showPhoneCode: true,
                                              onSelect: (country) {
                                                controller.selectedCountry =
                                                    country;
                                                controller.phoneController
                                                    .clear();
                                                controller.update();
                                              },
                                            );
                                          },
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              CountryFlag.fromCountryCode(
                                                controller.selectedCountry
                                                        ?.countryCode ??
                                                    'US',
                                                height: 30,
                                                width: 30,
                                                shape: Circle(),
                                              ),
                                              Gap(0.5.w),
                                              Text(
                                                '+${controller.selectedCountry?.phoneCode ?? 1}',
                                              ),
                                              Gap(0.5.w)
                                            ],
                                          ),
                                        ),
                                      ),
                                      inputFormatters: [
                                        FilteringTextInputFormatter.digitsOnly,
                                        LengthLimitingTextInputFormatter(
                                            controller.selectedCountry?.example
                                                    .length ??
                                                10),
                                      ],
                                      validator: (val) {
                                        if (val == null || val.trim().isEmpty) {
                                          return AppStrings.enterPhoneNumber;
                                        }
                                        return null;
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        Gap(1.3.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            CommonButton(
                              onPressed: () {
                                // if (controller.twoFormKey.currentState
                                //         ?.validate() ??
                                //     false) {
                                controller.twoPageController.animateToPage(1,
                                    duration: Duration(milliseconds: 500),
                                    curve: Curves.easeIn);
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
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppStrings.connectCRMTools,
                          style: TextStyles.bold(
                            30,
                            fontColor: AppColors.black141414,
                          ),
                        ),
                        Text(
                          AppStrings
                              .syncYourCalenderAndCRMForAutomatedScheduling,
                          style: TextStyles.regular(16,
                              fontColor: AppColors.grey5D5D5D),
                        ),
                        Gap(2.h),
                        Expanded(
                          child: ScrollConfiguration(
                            behavior:
                                ScrollBehavior().copyWith(scrollbars: false),
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  GridView.builder(
                                    itemCount: controller.crmToolsList.length,
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3,
                                      crossAxisSpacing: 1.h,
                                      mainAxisSpacing: 1.h,
                                      childAspectRatio: 3.4.sp,
                                    ),
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      CrmToolsModel data =
                                          controller.crmToolsList[index];
                                      return Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: AppColors.whiteEBEBEB,
                                              width: 1),
                                          borderRadius:
                                              BorderRadius.circular(14),
                                        ),
                                        padding: EdgeInsets.all(12.sp),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            (data.imagePath.contains('png'))
                                                ? Image.asset(
                                                    data.imagePath,
                                                    fit: BoxFit.scaleDown,
                                                    height: 20.sp,
                                                    width: 20.sp,
                                                  )
                                                : SvgPicture.asset(
                                                    data.imagePath,
                                                    fit: BoxFit.scaleDown,
                                                    height: 20.sp,
                                                    width: 20.sp,
                                                  ),
                                            Gap(10.sp),
                                            Text(
                                              data.title,
                                              style: TextStyles.medium(
                                                16,
                                                fontColor:
                                                    AppColors.black141414,
                                              ),
                                            ),
                                            // Gap(1.h),
                                            InkWell(
                                              onTap: data.onConnect,
                                              child: Text(
                                                AppStrings.connect,
                                                style: TextStyles.regular(12,
                                                    fontColor:
                                                        AppColors.primaryColor),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                  Gap(3.h),
                                  CommonButton(
                                    onPressed: () {
                                      controller.twoPageController.previousPage(
                                        duration: Duration(milliseconds: 500),
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
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
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
