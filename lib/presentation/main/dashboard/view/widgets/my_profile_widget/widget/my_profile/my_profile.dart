import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:va_bot_admin/core/theme/colors.dart';
import 'package:va_bot_admin/core/theme/text_styles.dart';
import 'package:va_bot_admin/core/utils/common_widgets/common_button.dart';
import 'package:va_bot_admin/core/utils/common_widgets/common_text_field.dart';
import 'package:va_bot_admin/gen/assets.gen.dart';
import 'package:va_bot_admin/presentation/main/dashboard/controller/dashboard_controller.dart';

class MyProfileWidget extends StatelessWidget {
  const MyProfileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: GetBuilder<DashboardScreenController>(builder: (controller) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Profile Picture',
              style: TextStyles.medium(14, fontColor: AppColors.black141414),
            ),
            Gap(5),
            Row(
              children: [
                Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage(Assets.images.profileImage.path),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Gap(20),
                CommonButton(
                  onPressed: () {},
                  child: Text(
                    'Change Picture',
                    style: TextStyles.medium(
                      12,
                      fontColor: AppColors.whiteFFFFFF,
                    ),
                  ),
                ),
                Gap(10),
                CommonButton(
                  onPressed: () {},
                  borderColor: AppColors.whiteE1E1E1,
                  buttonColor: AppColors.whiteFFFFFF,
                  child: Text(
                    'Delete Picture',
                    style: TextStyles.medium(
                      12,
                      fontColor: AppColors.grey6D6D6D,
                    ),
                  ),
                ),
              ],
            ),
            Gap(20),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'First name',
                        style: TextStyles.medium(
                          12,
                          fontColor: AppColors.black141414,
                        ),
                      ),
                      Gap(10),
                      CommonTextField(
                        hintText: 'First Name',
                        controller: controller.myProfileFirstNameController,
                        fillColor: AppColors.whiteF8F8F8,
                        enableBorderColor: AppColors.whiteF8F8F8,
                        suffixIcon:
                            Assets.icons.icEditLine.svg(fit: BoxFit.scaleDown),
                      )
                    ],
                  ),
                ),
                Gap(20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Last name',
                        style: TextStyles.medium(
                          12,
                          fontColor: AppColors.black141414,
                        ),
                      ),
                      Gap(10),
                      CommonTextField(
                        hintText: 'Last Name',
                        controller: controller.myProfileLastNameController,
                        fillColor: AppColors.whiteF8F8F8,
                        enableBorderColor: AppColors.whiteF8F8F8,
                        suffixIcon:
                            Assets.icons.icEditLine.svg(fit: BoxFit.scaleDown),
                      )
                    ],
                  ),
                ),
              ],
            ),
            Gap(20),
            Text(
              'Email address',
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
              suffixIcon: Assets.icons.icEditLine.svg(fit: BoxFit.scaleDown),
            ),
            Gap(20),
            Text(
              'Phone Number',
              style: TextStyles.medium(
                12,
                fontColor: AppColors.black141414,
              ),
            ),
            Gap(10),
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    showCountryPicker(
                      context: context,
                      showPhoneCode: true,
                      customFlagBuilder: (country) {
                        return Image.network(
                          'https://flagcdn.com/w40/${country.countryCode.toLowerCase()}.png',
                          width: 30,
                          height: 20,
                          errorBuilder: (context, error, stackTrace) =>
                              const Icon(Icons.flag, size: 24),
                        );
                      },
                      countryListTheme: CountryListThemeData(
                        flagSize: 25,
                        backgroundColor: Colors.white,
                        textStyle: const TextStyle(
                            fontSize: 16, color: Colors.blueGrey),
                        borderRadius: BorderRadius.circular(20.0),
                        inputDecoration: InputDecoration(
                          labelText: 'Search',
                          hintText: 'Start typing to search',
                          prefixIcon: const Icon(Icons.search),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: const Color(0xFF8C98A8)
                                    .withValues(alpha: 0.2)),
                          ),
                        ),
                      ),
                      onSelect: (Country country) {
                        controller.selectedCountry = country;
                        controller.selectedCountryCode = country.phoneCode;
                        controller.update();
                      },
                    );
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        10,
                      ),
                      color: AppColors.whiteF8F8F8,
                      border: Border.all(color: AppColors.whiteF8F8F8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Gap(10),
                        if (controller.selectedCountry != null)
                          ClipOval(
                            child: Image.network(
                              'https://flagcdn.com/w40/${controller.selectedCountry!.countryCode.toLowerCase()}.png',
                              width: 20,
                              height: 20,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  const Icon(Icons.flag, size: 24),
                            ),
                          )
                        else
                          ClipOval(
                            child: Image.network(
                              'https://flagcdn.com/w40/in.png',
                              width: 20,
                              height: 20,
                              fit: BoxFit.cover,
                            ),
                          ),
                        Gap(10),
                        Text(
                          '+' + controller.selectedCountryCode,
                          style: TextStyles.semiBold(12,
                              fontColor: AppColors.grey6D6D6D),
                        ),
                        Gap(10),
                        Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: AppColors.grey888888,
                        ),
                        Gap(10),
                      ],
                    ),
                  ),
                ),
                Gap(10),
                Expanded(
                  child: CommonTextField(
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    fillColor: AppColors.whiteF8F8F8,
                    enableBorderColor: AppColors.whiteF8F8F8,
                    hintText: '--- --- ---',
                    controller: controller.myProfilePhoneController,
                    suffixIcon:
                        Assets.icons.icEditLine.svg(fit: BoxFit.scaleDown),
                  ),
                ),
              ],
            ),
            Gap(20),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CommonButton(
                  onPressed: () {},
                  buttonColor: AppColors.primaryColor.withValues(alpha: 0.5),
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
        );
      }),
    );
  }
}
