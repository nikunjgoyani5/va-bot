import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:va_bot_admin/core/theme/colors.dart';
import 'package:va_bot_admin/core/theme/text_styles.dart';
import 'package:va_bot_admin/core/utils/common_widgets/common_button.dart';
import 'package:va_bot_admin/core/utils/common_widgets/common_text_field.dart';
import 'package:va_bot_admin/gen/assets.gen.dart';
import 'package:va_bot_admin/presentation/main/dashboard/controller/dashboard_controller.dart';

class ProfessionalTab extends StatelessWidget {
  const ProfessionalTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: GetBuilder<DashboardScreenController>(builder: (controller) {
        return ScrollConfiguration(
          behavior: ScrollBehavior().copyWith(scrollbars: false),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Brokerage Name',
                  style: TextStyles.medium(
                    12,
                    fontColor: AppColors.black141414,
                  ),
                ),
                Gap(10),
                CommonTextField(
                  hintText: 'Email',
                  controller: controller.myProfileEmailController,
                  fillColor: AppColors.whiteF8F8F8,
                  enableBorderColor: AppColors.whiteF8F8F8,
                  suffixIcon:
                      Assets.icons.icEditLine.svg(fit: BoxFit.scaleDown),
                ),
                Gap(20),
                Text(
                  'License Number',
                  style: TextStyles.medium(
                    12,
                    fontColor: AppColors.black141414,
                  ),
                ),
                Gap(10),
                Row(
                  children: [
                    Expanded(
                      child: CommonTextField(
                        hintText: 'License Number',
                        controller:
                            controller.professionalLicenseNumberController,
                        fillColor: AppColors.whiteF8F8F8,
                        enableBorderColor: AppColors.whiteF8F8F8,
                        suffixIcon:
                            Assets.icons.icEditLine.svg(fit: BoxFit.scaleDown),
                      ),
                    ),
                    Gap(10),
                    CommonButton(
                      onPressed: () {},
                      buttonColor:
                          AppColors.primaryColor.withValues(alpha: 0.5),
                      child: Text(
                        'Verify',
                        style: TextStyles.medium(
                          12,
                          fontColor: AppColors.whiteFFFFFF,
                        ),
                      ),
                    ),
                  ],
                ),
                Gap(20),
                Text(
                  'Specialization Areas',
                  style: TextStyles.medium(
                    12,
                    fontColor: AppColors.black141414,
                  ),
                ),
                Gap(10),
                CommonTextField(
                  hintText: 'Specialization Areas',
                  controller:
                      controller.professionalSpecializationAresController,
                  fillColor: AppColors.whiteF8F8F8,
                  enableBorderColor: AppColors.whiteF8F8F8,
                ),
                Gap(20),
                Text(
                  'Experience Level',
                  style: TextStyles.medium(
                    12,
                    fontColor: AppColors.black141414,
                  ),
                ),
                Gap(10),
                CommonTextField(
                  hintText: 'Experience Level',
                  controller: controller.professionalExperienceLevelController,
                  fillColor: AppColors.whiteF8F8F8,
                  enableBorderColor: AppColors.whiteF8F8F8,
                ),
                Gap(20),
                Text(
                  'Linked Professional Accounts',
                  style: TextStyles.medium(
                    12,
                    fontColor: AppColors.black141414,
                  ),
                ),
                Gap(5),
                Row(
                  children: [
                    Expanded(
                      child: CommonTextField(
                        hintText: 'Add Link',
                        controller: controller.linkedinController,
                        enableBorderColor: AppColors.greyE0E0E0,
                        prefixIcon: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Assets.images.linkedin.image(
                            height: 5,
                            width: 5,
                          ),
                        ),
                        onChanged: (val) {
                          controller.update();
                        },
                        suffixIcon:
                            (controller.linkedinController.text.isNotEmpty)
                                ? IconButton(
                                    onPressed: () {
                                      controller.linkedinController.clear();
                                    },
                                    icon: Assets.icons.icDelete.svg())
                                : SizedBox.shrink(),
                      ),
                    ),
                    Gap(10),
                    Expanded(
                      child: CommonTextField(
                        hintText: 'Add Link',
                        controller: controller.linkImageController,
                        enableBorderColor: AppColors.greyE0E0E0,
                        prefixIcon: Padding(
                          padding: EdgeInsets.all(8),
                          child: Assets.images.linkImage
                              .image(height: 5, width: 5),
                        ),
                        onChanged: (val) {
                          controller.update();
                        },
                        suffixIcon:
                            (controller.linkImageController.text.isNotEmpty)
                                ? IconButton(
                                    onPressed: () {
                                      controller.linkImageController.clear();
                                    },
                                    icon: Assets.icons.icDelete.svg())
                                : SizedBox.shrink(),
                      ),
                    ),
                  ],
                ),
                Gap(20),
                Text(
                  'Connect Your Social Accounts',
                  style: TextStyles.medium(
                    12,
                    fontColor: AppColors.black141414,
                  ),
                ),
                Gap(5),
                Row(
                  children: [
                    Expanded(
                      child: CommonTextField(
                        hintText: 'Add Link',
                        controller: controller.facebookController,
                        enableBorderColor: AppColors.greyE0E0E0,
                        prefixIcon: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Assets.images.facebook.image(
                            height: 5,
                            width: 5,
                          ),
                        ),
                        onChanged: (val) {
                          controller.update();
                        },
                        suffixIcon:
                            (controller.facebookController.text.isNotEmpty)
                                ? IconButton(
                                    onPressed: () {
                                      controller.facebookController.clear();
                                    },
                                    icon: Assets.icons.icDelete.svg())
                                : SizedBox.shrink(),
                      ),
                    ),
                    Gap(10),
                    Expanded(
                      child: CommonTextField(
                        hintText: 'Add Link',
                        controller: controller.instagramController,
                        enableBorderColor: AppColors.greyE0E0E0,
                        prefixIcon: Padding(
                          padding: EdgeInsets.all(8),
                          child: Assets.images.instagram
                              .image(height: 5, width: 5),
                        ),
                        onChanged: (val) {
                          controller.update();
                        },
                        suffixIcon:
                            (controller.instagramController.text.isNotEmpty)
                                ? IconButton(
                                    onPressed: () {
                                      controller.instagramController.clear();
                                    },
                                    icon: Assets.icons.icDelete.svg())
                                : SizedBox.shrink(),
                      ),
                    ),
                  ],
                ),
                Gap(5),
                Row(
                  children: [
                    Expanded(
                      child: CommonTextField(
                        hintText: 'Add Link',
                        controller: controller.linkedinSAController,
                        enableBorderColor: AppColors.greyE0E0E0,
                        prefixIcon: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Assets.images.linkedin.image(
                            height: 5,
                            width: 5,
                          ),
                        ),
                        onChanged: (val) {
                          controller.update();
                        },
                        suffixIcon:
                            (controller.linkedinSAController.text.isNotEmpty)
                                ? IconButton(
                                    onPressed: () {
                                      controller.linkedinSAController.clear();
                                    },
                                    icon: Assets.icons.icDelete.svg())
                                : SizedBox.shrink(),
                      ),
                    ),
                    Gap(10),
                    Expanded(child: SizedBox()),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CommonButton(
                      onPressed: () {},
                      buttonColor:
                          AppColors.primaryColor.withValues(alpha: 0.5),
                      child: Text(
                        'Save Change',
                        style: TextStyles.medium(
                          12,
                          fontColor: AppColors.whiteFFFFFF,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
