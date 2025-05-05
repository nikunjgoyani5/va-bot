import 'package:va_bot_admin/core/constant/app_constant.dart';
import 'package:va_bot_admin/presentation/main/dashboard/view/widgets/call_management_widget/call_management_widget.dart';
import 'package:va_bot_admin/presentation/main/dashboard/view/widgets/leads_follow_up_widget/lead_follow_up_widget.dart';
import 'package:va_bot_admin/presentation/main/dashboard/view/widgets/notification_widget/notification_widget.dart';
import 'package:va_bot_admin/presentation/main/dashboard/view/widgets/transaction_widget/transaction_widget.dart';
import 'package:va_bot_admin/presentation/main/dashboard/view/widgets/scheduling_widget/scheduling_widget.dart';
import 'package:va_bot_admin/presentation/main/dashboard/view/widgets/settings_widget/settings_widget.dart';
import 'package:va_bot_admin/presentation/main/dashboard/view/widgets/ai_notes_widget/ai_notes_widget.dart';
import 'package:va_bot_admin/presentation/main/dashboard/view/widgets/offer_widget/offers_widget.dart';
import 'package:va_bot_admin/presentation/main/dashboard/view/widgets/home_widget/home_widget.dart';
import 'package:va_bot_admin/presentation/main/dashboard/controller/dashboard_controller.dart';
import 'package:va_bot_admin/core/utils/common_widgets/common_text_field.dart';
import 'package:va_bot_admin/core/utils/common_widgets/vertical_tabbar.dart';
import 'package:va_bot_admin/core/utils/common_widgets/common_switch.dart';
import 'package:va_bot_admin/core/utils/common_widgets/common_button.dart';
import 'package:va_bot_admin/core/constant/app_strings.dart';
import 'package:va_bot_admin/core/theme/text_styles.dart';
import 'package:va_bot_admin/core/theme/colors.dart';
import 'package:va_bot_admin/gen/assets.gen.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class DashboardDesktopView extends StatelessWidget {
  DashboardDesktopView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: (isDarkTheme(context))
          ? AppColors.black141414
          : AppColors.whiteF2F5F8,
      floatingActionButton:
          GetBuilder<DashboardScreenController>(builder: (controller) {
        if (controller.currentIndex == 1) {
          return InkWell(
            onTap: () {},
            child: Container(
              height: 6.h,
              width: 6.h,
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  colors: [
                    AppColors.blue006BFF,
                    AppColors.blue1E9EFF,
                  ],
                ),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Assets.icons.icUpgrade.svg(
                  height: 5.h,
                  width: 5.h,
                  fit: BoxFit.scaleDown,
                ),
              ),
            ),
          );
        } else {
          return SizedBox.shrink();
        }
      }),
      body: GetBuilder<DashboardScreenController>(builder: (controller) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  height: 9.h,
                  width: (controller.isShowFullSideMenu) ? 17.w : 5.w,
                  decoration: BoxDecoration(
                    color: (isDarkTheme(context))
                        ? AppColors.black1C1C1C
                        : AppColors.whiteFFFFFF,
                    border: Border(
                      right: BorderSide(
                        color: AppColors.black141414,
                        width: 0.9.sp,
                      ),
                    ),
                  ),
                  child: Row(
                    children: [
                      Gap(1.w),
                      Assets.icons.vaBotLogo.svg(
                        height: 20.sp,
                        width: 20.sp,
                      ),
                      Gap((controller.isShowFullSideMenu) ? 0.8.w : 0.w),
                      (controller.isShowFullSideMenu)
                          ? Text(
                              AppStrings.vaBoat,
                              style: TextStyles.medium(
                                16,
                                fontColor: (isDarkTheme(context))
                                    ? AppColors.whiteFFFFFF
                                    : AppColors.black141414,
                              ),
                            )
                          : SizedBox.shrink(),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 9.h,
                    color: (controller.isPDFEditor)
                        ? AppColors.whiteFFFFFF
                        : AppColors.transparent,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 1.w),
                      child: (controller.currentIndex != 3 ||
                              !controller.isPDFEditor)
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        controller.currentIndex = 0;
                                        controller.pageController.jumpToPage(0);
                                        controller.update();
                                      },
                                      icon: Assets.icons.icHome.svg(
                                        colorFilter: ColorFilter.mode(
                                          AppColors.grey888888,
                                          BlendMode.srcIn,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      '/',
                                      style: TextStyles.regular(
                                        15,
                                        fontColor: AppColors.grey888888,
                                      ),
                                    ),
                                    Gap(10),
                                    Text(
                                      controller.sideBarMenu[
                                          controller.currentIndex]['fullName'],
                                      style: TextStyles.medium(
                                        15,
                                        fontColor: (isDarkTheme(context))
                                            ? AppColors.whiteFFFFFF
                                            : AppColors.black141414,
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  height: 9.h,
                                  width: 45.w,
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: CommonTextField(
                                          hintText: 'Search anything here',
                                          controller:
                                              controller.searchController,
                                          prefixIcon: Assets.icons.icSearch
                                              .svg(fit: BoxFit.scaleDown),
                                          fillColor: AppColors.whiteFFFFFF,
                                        ),
                                      ),
                                      Gap((controller.currentIndex == 3)
                                          ? 1.w
                                          : 0.w),
                                      (controller.currentIndex == 3)
                                          ? CommonButton(
                                              onPressed: () {
                                                controller
                                                    .searchAddressController
                                                    .clear();
                                                controller.dialogCurrentIndex =
                                                    0;
                                                controller.openFormSelectDialog(
                                                    context);
                                              },
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    Icons.add,
                                                    color:
                                                        AppColors.whiteFFFFFF,
                                                  ),
                                                  Gap(0.4.w),
                                                  Text(
                                                    'New offer',
                                                    style: TextStyles.medium(
                                                      11,
                                                      fontColor:
                                                          AppColors.whiteFFFFFF,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                          : SizedBox.shrink(),
                                      Gap(1.w),
                                      Container(
                                        width: 0.1.w,
                                        height: 4.h,
                                        color: AppColors.whiteE1E1E1,
                                      ),
                                      Gap(1.w),
                                      InkWell(
                                        onTap: () {
                                          controller.myProfileCurrentIndex = 0;
                                          controller.selectedProfileTab =
                                              controller.myProfileSideBarMenu
                                                  .first['title'];
                                          controller
                                              .showMyProfileDialog(context);
                                        },
                                        child: Row(
                                          children: [
                                            Container(
                                              width: 2.7.w,
                                              height: 2.7.w,
                                              decoration: BoxDecoration(
                                                color: AppColors.whiteE1E1E1,
                                                shape: BoxShape.circle,
                                                image: DecorationImage(
                                                  image: AssetImage(
                                                    Assets.images.profileImage
                                                        .path,
                                                  ),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                            Gap(0.5.w),
                                            Text(
                                              'Angelina Gotelli',
                                              style: TextStyles.medium(
                                                12,
                                                fontColor:
                                                    (isDarkTheme(context))
                                                        ? AppColors.whiteFFFFFF
                                                        : AppColors.black141414,
                                              ),
                                            ),
                                            Gap(0.5.w),
                                            Assets.icons.icDropdownArrow.svg(),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            )
                          : Row(
                              children: [
                                Expanded(
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          controller.isPDFEditor = false;
                                          controller.isShowFullSideMenu = true;
                                          controller.update();
                                        },
                                        child: Container(
                                          height: 5.h,
                                          width: 5.h,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            border: Border.all(
                                                color: AppColors.whiteE1E1E1),
                                          ),
                                          child: Icon(
                                              Icons.arrow_back_ios_outlined),
                                        ),
                                      ),
                                      Gap(1.w),
                                      Expanded(
                                        child: Text(
                                          controller.fileName,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyles.medium(
                                            10.5,
                                            fontColor: AppColors.black141414,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Gap(1.5.w),
                                Expanded(
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        height: 5.h,
                                        width: 3.w,
                                        child: CommonTextField(
                                          hintText: '',
                                          textAlign: TextAlign.center,
                                          controller: controller
                                              .currentPDFPageController,
                                          textStyle: TextStyles.medium(
                                            11,
                                            fontColor: AppColors.black141414,
                                          ),
                                          enableBorderColor:
                                              AppColors.transparent,
                                          fillColor: AppColors.whiteF5F5F5,
                                          onSubmitted: (val) {
                                            int pageValue = int.parse(val);
                                            if (pageValue >
                                                controller.pdfTotalPages) {
                                              pageValue =
                                                  controller.pdfTotalPages;
                                            }
                                            if (pageValue == 0) {
                                              pageValue = 1;
                                            }
                                            controller.goToPage(pageValue - 1);
                                          },
                                        ),
                                      ),
                                      Gap(0.5.w),
                                      Text(
                                        '/',
                                        style: TextStyles.medium(
                                          14,
                                          fontColor: AppColors.grey888888,
                                        ),
                                      ),
                                      Gap(0.5.w),
                                      Text(
                                        '${controller.pdfTotalPages}',
                                        style: TextStyles.medium(
                                          14,
                                          fontColor: AppColors.grey888888,
                                        ),
                                      ),
                                      Container(
                                        height: 4.h,
                                        width: 0.1.w,
                                        color: AppColors.whiteE1E1E1,
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 1.w),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          String value = controller
                                              .currentPDFZoomPercentage.text;
                                          print(value);

                                          int actualValue =
                                              int.parse(value) - 10;
                                          print(actualValue);
                                          controller
                                              .setZoom(actualValue.toDouble());
                                        },
                                        icon: Icon(Icons.remove),
                                        color: AppColors.grey888888,
                                      ),
                                      Container(
                                        height: 5.h,
                                        width: 6.w,
                                        child: CommonTextField(
                                          hintText: '',
                                          textAlign: TextAlign.center,
                                          controller: controller
                                              .currentPDFZoomPercentage,
                                          textStyle: TextStyles.medium(
                                            10.5,
                                            fontColor: AppColors.black141414,
                                          ),
                                          enableBorderColor:
                                              AppColors.transparent,
                                          fillColor: AppColors.whiteF5F5F5,
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          String value = controller
                                              .currentPDFZoomPercentage.text;
                                          print(value);
                                          int actualValue =
                                              int.parse(value) + 10;
                                          controller
                                              .setZoom(actualValue.toDouble());
                                        },
                                        icon: Icon(Icons.add),
                                        color: AppColors.grey888888,
                                      ),
                                    ],
                                  ),
                                ),
                                Gap(1.5.w),
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          controller.savePDF();
                                        },
                                        icon: Assets.icons.icSave.svg(),
                                      ),
                                      Gap(0.5.w),
                                      IconButton(
                                        onPressed: () {
                                          controller.printPDF();
                                        },
                                        icon: Assets.icons.icPrint.svg(),
                                      ),
                                      Gap(0.5.w),
                                      InkWell(
                                        onTap: () {},
                                        child: Container(
                                          decoration: BoxDecoration(
                                              gradient: LinearGradient(
                                                colors: [
                                                  AppColors.primaryColor,
                                                  AppColors.primaryColor
                                                      .withValues(alpha: 0.5),
                                                ],
                                                begin: Alignment.centerLeft,
                                                end: Alignment.centerRight,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(30)),
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 1.w, vertical: 1.2.h),
                                          child: Row(
                                            children: [
                                              Assets.icons.icUpgrade.svg(),
                                              Gap(0.5.w),
                                              Text(
                                                'Ask AI Bot',
                                                style: TextStyles.medium(
                                                  10.5,
                                                  fontColor:
                                                      AppColors.whiteFFFFFF,
                                                ),
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
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: VerticalTabView(
                isShowFullMenu: controller.isShowFullSideMenu,
                tabsWidth: (controller.isShowFullSideMenu) ? 17.w : 5.w,
                onSelect: (newIndex) {
                  print('NEW INDEX ### ${newIndex}');
                  controller.isPDFEditor = false;
                  controller.isShowFullSideMenu = true;
                  controller.callerInfo.clear();
                  controller.selectedProperty = null;
                  if (newIndex != 9) {
                    controller.currentIndex = newIndex;
                    controller.pageController
                        .jumpToPage(controller.currentIndex);
                  } else {
                    ///DARK MODE FUNCTIONALITY HERE
                    Get.changeThemeMode((context.isDarkMode)
                        ? ThemeMode.light
                        : ThemeMode.dark);
                  }
                  controller.update();
                },
                pageController: controller.pageController,
                initialIndex: controller.currentIndex,
                unSelectedTabBackgroundColor: (isDarkTheme(context))
                    ? AppColors.transparent
                    : AppColors.whiteFFFFFF,
                selectedTabBackgroundColor:
                    AppColors.primaryColor.withValues(alpha: 0.1),
                tabs: List.generate(
                  controller.sideBarMenu.length,
                  (index) {
                    Map<String, dynamic> data = controller.sideBarMenu[index];
                    return Tab(
                      child: Column(
                        children: [
                          Container(
                            height: 5.h,
                            child: Row(
                              mainAxisAlignment: (controller.isShowFullSideMenu)
                                  ? MainAxisAlignment.start
                                  : MainAxisAlignment.center,
                              children: [
                                Gap((controller.isShowFullSideMenu)
                                    ? 1.5.w
                                    : 0.w),
                                SvgPicture.asset(
                                  data['image'],
                                  colorFilter: ColorFilter.mode(
                                    (controller.currentIndex == index)
                                        ? AppColors.primaryColor
                                        : AppColors.grey5D5D5D,
                                    BlendMode.srcIn,
                                  ),
                                ),
                                Gap((controller.isShowFullSideMenu)
                                    ? 1.w
                                    : 0.w),
                                (controller.isShowFullSideMenu)
                                    ? Text(
                                        data['title'],
                                        style: TextStyles.medium(
                                          12,
                                          fontColor:
                                              (controller.currentIndex == index)
                                                  ? (isDarkTheme(context))
                                                      ? AppColors.whiteFFFFFF
                                                      : AppColors.black141414
                                                  : (isDarkTheme(context))
                                                      ? AppColors.grey888888
                                                      : AppColors.grey5D5D5D,
                                        ),
                                      )
                                    : SizedBox.shrink(),
                                Gap((controller.isShowFullSideMenu)
                                    ? 3.w
                                    : 0.w),
                                (index == 9 && controller.isShowFullSideMenu)
                                    ? CommonSwitchButton(
                                        value: /*controller.isDarkMode*/
                                            context.isDarkMode,
                                        onChanged: (value) {
                                          Get.changeThemeMode(
                                              (context.isDarkMode)
                                                  ? ThemeMode.light
                                                  : ThemeMode.dark);
                                          // controller.isDarkMode = value;
                                          controller.update();
                                        },
                                      )
                                    : SizedBox.shrink(),
                              ],
                            ),
                          ),
                          (index == 9 && controller.isShowFullSideMenu)
                              ? Container(
                                  height: 20.h,
                                  width: 17.w,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(14),
                                    gradient: LinearGradient(
                                      colors: [
                                        AppColors.primaryColor,
                                        AppColors.primaryColor
                                            .withValues(alpha: 0.5),
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ),
                                  ),
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 1.w),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Assets.icons.icUpgrade.svg(),
                                          Gap(0.8.w),
                                          Text(
                                            'Upgrade Plan',
                                            style: TextStyles.bold(
                                              16,
                                              fontColor: AppColors.whiteFFFFFF,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        'Get even more of the Va Bot features you need.',
                                        textAlign: TextAlign.start,
                                        style: TextStyles.regular(
                                          11,
                                          fontColor: AppColors.whiteFFFFFF,
                                        ),
                                      ),
                                      Gap(0.3.h),
                                      CommonButton(
                                        onPressed: () {},
                                        radius: 30,
                                        buttonColor: AppColors.whiteFFFFFF,
                                        buttonWidth: double.infinity,
                                        child: Text(
                                          'Upgrade',
                                          style: TextStyles.medium(
                                            12,
                                            fontColor: AppColors.black141414,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              : SizedBox.shrink(),
                        ],
                      ),
                    );
                  },
                ),
                contents: [
                  HomeWidget(),
                  KeyboardListener(
                    focusNode: FocusNode()..requestFocus(),
                    onKeyEvent: controller.handleKey,
                    child: CallManagementWidget(),
                  ),
                  SchedulingWidget(),
                  OffersWidget(),
                  TransactionWidget(),
                  LeadsFollowUpWidget(),
                  AINotesWidget(),
                  NotificationWidget(),
                  SettingsWidget(),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}
