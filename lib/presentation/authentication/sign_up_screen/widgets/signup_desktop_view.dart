import 'package:flutter/cupertino.dart';
import 'package:va_bot_admin/presentation/authentication/sign_up_screen/controller/signup_controller.dart';
import 'package:va_bot_admin/core/utils/common_widgets/common_title_with_image.dart';
import 'package:va_bot_admin/core/utils/common_widgets/common_text_field.dart';
import 'package:va_bot_admin/core/utils/common_widgets/common_button.dart';
import 'package:va_bot_admin/core/constant/app_extension.dart';
import 'package:va_bot_admin/core/constant/app_strings.dart';
import 'package:va_bot_admin/routes/navigation_routes.dart';
import 'package:va_bot_admin/core/theme/text_styles.dart';
import 'package:va_bot_admin/routes/app_routes.dart';
import 'package:va_bot_admin/core/theme/colors.dart';
import 'package:country_picker/country_picker.dart';
import 'package:va_bot_admin/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';

class SignupDeskTopView extends StatelessWidget {
  const SignupDeskTopView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SignUpController>(
      init: SignUpController(),
      builder: (controller) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Stack(
            children: [
              Row(
                children: [
                  Spacer(),
                  Container(
                    alignment: Alignment.center,
                    width: context.screenWidth * 0.3,
                    child: Form(
                      key: controller.signUpKey,
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  AppStrings.createAccount,
                                  style: TextStyles.bold(20),
                                ),
                              ],
                            ),
                            spaceH(6),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  AppStrings.enterYourPersonal,
                                  style: TextStyles.regular(14),
                                ),
                              ],
                            ),
                            spaceH(13),
                            Text(
                              AppStrings.firstName,
                              style: TextStyles.medium(12),
                            ),
                            spaceH(5),
                            CommonTextField(
                              validator: (p0) {
                                if (p0 == null || p0.isEmpty) {
                                  return AppStrings.pleaseEnterFName;
                                }

                                return null;
                              },
                              hintText: AppStrings.enterFName,
                              controller: controller.firstNameController,
                            ),
                            spaceH(10),
                            Text(
                              AppStrings.lastName,
                              style: TextStyles.medium(12),
                            ),
                            spaceH(5),
                            CommonTextField(
                              validator: (p0) {
                                if (p0 == null || p0.isEmpty) {
                                  return AppStrings.pleaseEnterLName;
                                }
                                return null;
                              },
                              hintText: AppStrings.enterLName,
                              controller: controller.lastNameController,
                            ),
                            spaceH(10),
                            Text(
                              AppStrings.emailAddress,
                              style: TextStyles.medium(12),
                            ),
                            spaceH(5),
                            CommonTextField(
                              validator: (p0) {
                                if (p0 == null || p0.isEmpty) {
                                  return AppStrings.pleaseEnterEmail;
                                }
                                if (!p0.isEmail) {
                                  return AppStrings.pleaseEnterValidEmail;
                                }
                                return null;
                              },
                              hintText: AppStrings.enterEmail,
                              controller: controller.emailController,
                            ),
                            spaceH(10),
                            Text(
                              AppStrings.password,
                              style: TextStyles.medium(12),
                            ),
                            spaceH(5),
                            CommonTextField(
                              obscureText: controller.isPasswordSecure,
                              hintText: AppStrings.enterPassword,
                              controller: controller.passController,
                              validator: (p0) {
                                if (p0 == null || p0.isEmpty) {
                                  return AppStrings.pleaseEnterPass;
                                } else if (p0.length < 8) {
                                  return AppStrings.pleaseEnter8Chars;
                                }

                                return null;
                              },
                              suffixIcon: IconButton(
                                onPressed: () {
                                  if (controller.isPasswordSecure) {
                                    controller.isPasswordSecure = false;
                                  } else {
                                    controller.isPasswordSecure = true;
                                  }
                                  controller.update();
                                },
                                icon: (controller.isPasswordSecure == false)
                                    ? Assets.icons.icCloseEye.svg(
                                        colorFilter: const ColorFilter.mode(
                                            AppColors.grey6D6D6D,
                                            BlendMode.srcIn),
                                      )
                                    : Assets.icons.icOpenEye.svg(),
                              ).paddingOnly(right: 10),
                            ),
                            spaceH(10),
                            Text(
                              AppStrings.phoneNumber,
                              style: TextStyles.medium(12),
                            ),
                            spaceH(5),
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
                                          errorBuilder: (context, error,
                                                  stackTrace) =>
                                              const Icon(Icons.flag, size: 24),
                                        );
                                      },
                                      countryListTheme: CountryListThemeData(
                                        flagSize: 25,
                                        backgroundColor: Colors.white,
                                        textStyle: const TextStyle(
                                            fontSize: 16,
                                            color: Colors.blueGrey),
                                        borderRadius:
                                            BorderRadius.circular(20.0),
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
                                        controller.selectedCountryCode =
                                            country.phoneCode;
                                        controller.update();
                                      },
                                    );
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    height: 48,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                        10,
                                      ),
                                      border: Border.all(
                                          color: AppColors.whiteE1E1E1),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        spaceW(10),
                                        if (controller.selectedCountry != null)
                                          ClipOval(
                                            child: Image.network(
                                              'https://flagcdn.com/w40/${controller.selectedCountry!.countryCode.toLowerCase()}.png',
                                              width: 20,
                                              height: 20,
                                              fit: BoxFit.cover,
                                              errorBuilder: (context, error,
                                                      stackTrace) =>
                                                  const Icon(Icons.flag,
                                                      size: 24),
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
                                        spaceW(10),
                                        Text(
                                          '+' + controller.selectedCountryCode,
                                          style: TextStyles.semiBold(12,
                                              fontColor: AppColors.grey6D6D6D),
                                        ),
                                        spaceW(10),
                                        Icon(
                                          Icons.keyboard_arrow_down_rounded,
                                          color: AppColors.grey888888,
                                        ),
                                        spaceW(10),
                                      ],
                                    ),
                                  ),
                                ),
                                spaceW(10),
                                Expanded(
                                  child: CommonTextField(
                                    keyboardType: TextInputType.number,
                                    inputFormatters: <TextInputFormatter>[
                                      FilteringTextInputFormatter.digitsOnly
                                    ],
                                    hintText: '--- --- ---',
                                    controller: controller.phoneController,
                                    validator: (p0) {
                                      if (p0 == null || p0.isEmpty) {
                                        return AppStrings.pleaseEnterMoNumber;
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ],
                            ),
                            spaceH(10),
                            Row(
                              children: [
                                Expanded(
                                    child: Container(
                                  height: 1,
                                  color: AppColors.greyE5E5E5,
                                )),
                                spaceW(10),
                                Text(
                                  AppStrings.or,
                                  style: TextStyles.regular(11,
                                      fontColor: AppColors.grey888888),
                                ),
                                spaceW(10),
                                Expanded(
                                    child: Container(
                                  height: 1,
                                  color: AppColors.greyE5E5E5,
                                )),
                              ],
                            ),
                            spaceH(12),
                            Container(
                              alignment: Alignment.center,
                              height: 50,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                  10,
                                ),
                                border:
                                    Border.all(color: AppColors.whiteE1E1E1),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    Assets.icons.icGoogle.path,
                                    height: 24,
                                    width: 24,
                                  ),
                                  spaceW(10),
                                  Text(
                                    AppStrings.continueWithGoogle,
                                    style: TextStyles.medium(14,
                                        fontColor: AppColors.grey6D6D6D),
                                  ),
                                ],
                              ),
                            ),
                            spaceH(10),
                            Container(
                              alignment: Alignment.center,
                              height: 50,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                  10,
                                ),
                                border:
                                    Border.all(color: AppColors.whiteE1E1E1),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    Assets.icons.icApple.path,
                                    height: 24,
                                    width: 24,
                                  ),
                                  spaceW(10),
                                  Text(
                                    AppStrings.continueWithApple,
                                    style: TextStyles.medium(14,
                                        fontColor: AppColors.grey6D6D6D),
                                  ),
                                ],
                              ),
                            ),
                            spaceH(30),
                            CommonButton(
                              buttonWidth: context.screenWidth,
                              onPressed: () {
                                if (controller.signUpKey.currentState
                                        ?.validate() ??
                                    false) {
                                  if (controller.isLoading == false) {
                                    controller.signUp(context);
                                  }
                                }
                              },
                              child: (controller.isLoading == false)
                                  ? Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          AppStrings.signup,
                                          style: TextStyles.semiBold(14,
                                              fontColor: AppColors.whiteFFFFFF),
                                        ),
                                        spaceW(5),
                                        Icon(
                                          Icons.arrow_right,
                                          color: AppColors.whiteFFFFFF,
                                          size: 30,
                                        ),
                                      ],
                                    )
                                  : CupertinoActivityIndicator(
                                      color: AppColors.whiteFFFFFF),
                            ),
                            spaceH(20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  AppStrings.alreadyHaveAnAccount,
                                  style: TextStyles.regular(12,
                                      fontColor: AppColors.grey888888),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    NavigatorRoute.navigateTo(context,
                                        page: AppRoutes.login);
                                  },
                                  child: Text(
                                    AppStrings.signIn,
                                    style: TextStyles.semiBold(12,
                                        fontColor: AppColors.black141414),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Spacer(),
                  Stack(
                    children: [
                      Image.asset(
                        Assets.images.loginBg.path,
                        width: context.screenWidth * 0.43,
                        height: context.screenHeight,
                        fit: BoxFit.fill,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 4.w, top: 4.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              AppStrings.meetYourAIPowered,
                              style: TextStyles.semiBold(16,
                                  fontColor: AppColors.whiteFFFFFF),
                            ),
                            spaceH(10),
                            Text(
                              AppStrings.generateOffers,
                              style: TextStyles.light(12,
                                  fontColor: AppColors.whiteFFFFFF),
                            ),
                          ],
                        ),
                      ),

                      // Image.asset('assets/images/chats.png'),
                    ],
                  ),
                ],
              ),
              Row(
                children: [
                  spaceW(10),
                  CommonTitleWithImage(),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
