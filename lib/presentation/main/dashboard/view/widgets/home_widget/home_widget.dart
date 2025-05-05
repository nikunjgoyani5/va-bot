import 'package:va_bot_admin/core/constant/app_constant.dart';
import 'package:va_bot_admin/presentation/main/dashboard/view/widgets/home_widget/ai_activity_widget.dart';
import 'package:va_bot_admin/presentation/main/dashboard/controller/dashboard_controller.dart';
import 'package:va_bot_admin/data/model/home_screen_model/notification_model.dart';
import 'package:va_bot_admin/data/model/home_screen_model/appointment_model.dart';
import 'package:va_bot_admin/core/utils/common_widgets/dotted_line_painter.dart';
import 'package:va_bot_admin/core/utils/common_widgets/common_button.dart';
import 'package:va_bot_admin/core/theme/text_styles.dart';
import 'package:va_bot_admin/core/theme/colors.dart';
import 'package:va_bot_admin/gen/assets.gen.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class HomeWidget extends StatelessWidget {
  const HomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: GetBuilder<DashboardScreenController>(builder: (controller) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hello, Angelina',
              style: TextStyles.bold(
                34,
                fontColor: (isDarkTheme(context))
                    ? AppColors.whiteFFFFFF
                    : AppColors.black141414,
              ),
            ),
            Row(
              children: [
                ShaderMask(
                  shaderCallback: (bounds) {
                    return LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        (isDarkTheme(context))
                            ? AppColors.blue83D5FF
                            : AppColors.primaryColor.withValues(alpha: 0.5),
                        AppColors.primaryColor,
                      ],
                    ).createShader(bounds);
                  },
                  child: Text(
                    'How can I help you today?',
                    style: TextStyles.medium(
                      34,
                      fontColor: AppColors.whiteFFFFFF,
                    ),
                  ),
                ),
                Gap(20),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        AppColors.primaryColor,
                        AppColors.primaryColor.withValues(alpha: 0.5),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                  child: Row(
                    children: [
                      Assets.icons.icUpgrade.svg(),
                      Gap(8),
                      Text(
                        'Ask AI Bot',
                        style: TextStyles.medium(14,
                            fontColor: AppColors.whiteFFFFFF),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Gap(20),
            Stack(
              children: [
                SingleChildScrollView(
                  controller: controller.menuScrollController,
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(
                      controller.homeMenu.length,
                      (index) {
                        Map<String, dynamic> data = controller.homeMenu[index];
                        return Container(
                          margin: EdgeInsets.only(
                              left: (index != 0) ? 7.5 : 0,
                              right: (index != 4) ? 7.5 : 0),
                          decoration: BoxDecoration(
                            color: (isDarkTheme(context))
                                ? AppColors.black1C1C1C
                                : AppColors.whiteFFFFFF,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: (isDarkTheme(context))
                                  ? AppColors.black2F2F2F
                                  : AppColors.whiteEBEBEB,
                            ),
                          ),
                          padding: EdgeInsets.symmetric(
                              vertical: 15, horizontal: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    height: 44,
                                    width: 44,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [
                                          AppColors.primaryColor,
                                          AppColors.primaryColor
                                              .withValues(alpha: 0.5),
                                        ],
                                      ),
                                    ),
                                    child: Center(
                                      child: SvgPicture.asset(
                                        data['image'],
                                        height: 20,
                                        width: 20,
                                        colorFilter: ColorFilter.mode(
                                          AppColors.whiteFFFFFF,
                                          BlendMode.srcIn,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Gap(10),
                                  Text(
                                    data['title'],
                                    style: TextStyles.semiBold(
                                      14,
                                      fontColor: (isDarkTheme(context))
                                          ? AppColors.whiteFFFFFF
                                          : AppColors.black141414,
                                    ),
                                  ),
                                ],
                              ),
                              Gap(15),
                              CustomPaint(
                                size: Size(250, 1),
                                painter: DottedLinePainter(
                                    color: (isDarkTheme(context))
                                        ? AppColors.black3C3C3C
                                        : AppColors.whiteEBEBEB),
                              ),
                              Gap(15),
                              Row(
                                children: [
                                  Text(
                                    'View Details',
                                    style: TextStyles.medium(
                                      12,
                                      fontColor: (isDarkTheme(context))
                                          ? AppColors.grey5D5D5D
                                          : AppColors.grey888888,
                                    ),
                                  ),
                                  Gap(150),
                                  Assets.icons.icRightArrow.svg(
                                    colorFilter: ColorFilter.mode(
                                      (isDarkTheme(context))
                                          ? AppColors.grey5D5D5D
                                          : AppColors.grey888888,
                                      BlendMode.srcIn,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Positioned(
                  right: 1,
                  top: 0,
                  bottom: 0,
                  child: Center(
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: (isDarkTheme(context))
                            ? AppColors.black2F2F2F
                            : AppColors.whiteFFFFFF,
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(0, 5),
                            color: AppColors.black000000.withValues(alpha: 0.1),
                            blurRadius: 10,
                            spreadRadius: 5,
                          ),
                          BoxShadow(
                            offset: Offset(0, 0),
                            color:
                                AppColors.black000000.withValues(alpha: 0.01),
                            blurRadius: 10,
                            spreadRadius: 50,
                          ),
                        ],
                      ),
                      child: IconButton(
                        onPressed: () {
                          controller.menuScrollController.animateTo(
                            controller
                                .menuScrollController.position.maxScrollExtent,
                            duration: Duration(milliseconds: 500),
                            curve: Curves.easeOut,
                          );
                        },
                        icon: Icon(
                          Icons.chevron_right,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
            Gap(10),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Container(
                            decoration: BoxDecoration(
                              color: (isDarkTheme(context))
                                  ? AppColors.black1C1C1C
                                  : AppColors.whiteFFFFFF,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Upcoming Appointments',
                                  style: TextStyles.semiBold(16,
                                      fontColor: (isDarkTheme(context))
                                          ? AppColors.whiteFFFFFF
                                          : AppColors.black141414),
                                ),
                                Gap(15),
                                Expanded(
                                  child: RawScrollbar(
                                    thumbVisibility: true,
                                    trackVisibility: true,
                                    interactive: false,
                                    thickness: 4,
                                    thumbColor: (isDarkTheme(context))
                                        ? AppColors.black3C3C3C
                                        : AppColors.whiteEBEBEB,
                                    trackBorderColor: AppColors.transparent,
                                    controller: controller.scrollController,
                                    child: ScrollConfiguration(
                                      behavior: ScrollBehavior()
                                          .copyWith(scrollbars: false),
                                      child: ListView.separated(
                                        controller: controller.scrollController,
                                        itemCount:
                                            controller.appointmentData.length,
                                        separatorBuilder:
                                            (BuildContext context, int index) {
                                          return Gap(10);
                                        },
                                        padding: EdgeInsets.only(right: 10),
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          AppointmentModel data =
                                              controller.appointmentData[index];
                                          return Container(
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: (isDarkTheme(context))
                                                      ? AppColors.black2F2F2F
                                                      : AppColors.whiteEBEBEB),
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                            padding: EdgeInsets.all(15),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Image.asset(
                                                      data.image,
                                                      height: 55,
                                                      width: 55,
                                                    ),
                                                    Gap(10),
                                                    Expanded(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Row(
                                                            children: [
                                                              Assets
                                                                  .icons.icUser
                                                                  .svg(
                                                                height: 18,
                                                                width: 18,
                                                              ),
                                                              Gap(10),
                                                              Text(
                                                                data.name,
                                                                style:
                                                                    TextStyles
                                                                        .medium(
                                                                  11,
                                                                  fontColor: (isDarkTheme(
                                                                          context))
                                                                      ? AppColors
                                                                          .grey6D6D6D
                                                                      : AppColors
                                                                          .grey5D5D5D,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          Gap(10),
                                                          Row(
                                                            children: [
                                                              Assets.icons
                                                                  .icScheduling
                                                                  .svg(
                                                                height: 18,
                                                                width: 18,
                                                              ),
                                                              Gap(10),
                                                              Text(
                                                                data.time,
                                                                style:
                                                                    TextStyles
                                                                        .medium(
                                                                  11,
                                                                  fontColor: (isDarkTheme(
                                                                          context))
                                                                      ? AppColors
                                                                          .grey6D6D6D
                                                                      : AppColors
                                                                          .grey5D5D5D,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Gap(10),
                                                    Container(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 6,
                                                              vertical: 3),
                                                      decoration: BoxDecoration(
                                                        color: (data.status
                                                                    .toLowerCase() ==
                                                                'confirmed')
                                                            ? (isDarkTheme(
                                                                    context))
                                                                ? AppColors
                                                                    .green01B500
                                                                    .withValues(
                                                                        alpha:
                                                                            0.2)
                                                                : AppColors
                                                                    .greenD1FAE5
                                                            : (isDarkTheme(
                                                                    context))
                                                                ? AppColors
                                                                    .orange92400E
                                                                    .withValues(
                                                                        alpha:
                                                                            0.2)
                                                                : AppColors
                                                                    .orangeFEF3C7,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                      ),
                                                      child: Text(
                                                        data.status,
                                                        style:
                                                            TextStyles.medium(
                                                          11,
                                                          fontColor: (data
                                                                      .status
                                                                      .toLowerCase() ==
                                                                  'confirmed')
                                                              ? (isDarkTheme(
                                                                      context))
                                                                  ? AppColors
                                                                      .green01B500
                                                                  : AppColors
                                                                      .green059669
                                                              : (isDarkTheme(
                                                                      context))
                                                                  ? AppColors
                                                                      .orangeC27A0C
                                                                  : AppColors
                                                                      .orange92400E,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Gap(15),
                                                Text(
                                                  data.amount,
                                                  style: TextStyles.semiBold(
                                                    16,
                                                    fontColor:
                                                        AppColors.green16A34A,
                                                  ),
                                                ),
                                                Gap(8),
                                                Row(
                                                  children: [
                                                    Assets.icons.icLocationPin
                                                        .svg(),
                                                    Gap(12),
                                                    Text(
                                                      data.address,
                                                      style: TextStyles.medium(
                                                        13,
                                                        fontColor: AppColors
                                                            .grey5D5D5D,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Gap(15),
                                                Row(
                                                  children: [
                                                    CommonButton(
                                                      onPressed: () {},
                                                      buttonColor:
                                                          (isDarkTheme(context))
                                                              ? AppColors
                                                                  .black282828
                                                              : AppColors
                                                                  .whiteFFFFFF,
                                                      borderColor:
                                                          (isDarkTheme(context))
                                                              ? AppColors
                                                                  .black323232
                                                              : AppColors
                                                                  .whiteE1E1E1,
                                                      child: Text(
                                                        'Reschedule',
                                                        style: TextStyles.medium(
                                                            12,
                                                            fontColor: AppColors
                                                                .grey6D6D6D),
                                                      ),
                                                    ),
                                                    Gap(8),
                                                    CommonButton(
                                                      onPressed: () {
                                                        controller
                                                            .appointmentController
                                                            .animateTo(0,
                                                                duration: Duration(
                                                                    milliseconds:
                                                                        100),
                                                                curve: Curves
                                                                    .decelerate);
                                                        controller
                                                            .openAppointmentDetailsDialog(
                                                                context);
                                                      },
                                                      buttonColor:
                                                          (isDarkTheme(context))
                                                              ? AppColors
                                                                  .black282828
                                                              : AppColors
                                                                  .whiteFFFFFF,
                                                      borderColor:
                                                          (isDarkTheme(context))
                                                              ? AppColors
                                                                  .black323232
                                                              : AppColors
                                                                  .whiteE1E1E1,
                                                      child: Text(
                                                        'Details',
                                                        style: TextStyles.medium(
                                                            12,
                                                            fontColor: AppColors
                                                                .grey6D6D6D),
                                                      ),
                                                    ),
                                                    Gap(8),
                                                    CommonButton(
                                                      onPressed: () {},
                                                      buttonColor:
                                                          (isDarkTheme(context))
                                                              ? AppColors
                                                                  .black282828
                                                              : AppColors
                                                                  .whiteFFFFFF,
                                                      borderColor:
                                                          (isDarkTheme(context))
                                                              ? AppColors
                                                                  .black323232
                                                              : AppColors
                                                                  .whiteE1E1E1,
                                                      child: Text(
                                                        'Cancel',
                                                        style: TextStyles.medium(
                                                            12,
                                                            fontColor: AppColors
                                                                .grey6D6D6D),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Gap(10),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: (isDarkTheme(context))
                                  ? AppColors.black1C1C1C
                                  : AppColors.whiteFFFFFF,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 10, left: 16),
                                  child: Text(
                                    'Alerts and Notifications',
                                    style: TextStyles.semiBold(16,
                                        fontColor: (isDarkTheme(context))
                                            ? AppColors.whiteFFFFFF
                                            : AppColors.black141414),
                                  ),
                                ),
                                Gap(15),
                                Expanded(
                                  child: ScrollConfiguration(
                                    behavior: ScrollBehavior()
                                        .copyWith(scrollbars: false),
                                    child: ListView.separated(
                                      itemCount:
                                          controller.notificationData.length,
                                      separatorBuilder:
                                          (BuildContext context, int index) {
                                        return Gap(10);
                                      },
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        NotificationModel data =
                                            controller.notificationData[index];
                                        return Container(
                                          color: (isDarkTheme(context))
                                              ? AppColors.primaryColor
                                                  .withValues(alpha: 0.1)
                                              : AppColors.greyF0F6FF,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 16, vertical: 10),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                height: 36,
                                                width: 36,
                                                decoration: BoxDecoration(
                                                  color: AppColors.primaryColor
                                                      .withValues(alpha: 0.1),
                                                  shape: BoxShape.circle,
                                                ),
                                                child: Assets.icons.icEmail
                                                    .svg(fit: BoxFit.scaleDown),
                                              ),
                                              Gap(12),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      data.title,
                                                      style: TextStyles.medium(
                                                        14,
                                                        fontColor: (isDarkTheme(
                                                                context))
                                                            ? AppColors
                                                                .whiteFFFFFF
                                                            : AppColors
                                                                .black141414,
                                                      ),
                                                    ),
                                                    Text(
                                                      data.description,
                                                      style: TextStyles.regular(
                                                        11,
                                                        fontColor: AppColors
                                                            .grey5D5D5D,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Gap(12),
                                              Text(
                                                data.time,
                                                style: TextStyles.regular(
                                                  10,
                                                  fontColor:
                                                      AppColors.grey888888,
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Gap(10),
                  Expanded(
                    child: Column(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Container(
                            decoration: BoxDecoration(
                              color: (isDarkTheme(context))
                                  ? AppColors.black1C1C1C
                                  : AppColors.whiteFFFFFF,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Recent Offers',
                                  style: TextStyles.semiBold(16,
                                      fontColor: (isDarkTheme(context))
                                          ? AppColors.whiteFFFFFF
                                          : AppColors.black141414),
                                ),
                                Gap(15),
                                Expanded(
                                  child: RawScrollbar(
                                    thumbVisibility: true,
                                    trackVisibility: true,
                                    interactive: false,
                                    thickness: 4,
                                    thumbColor: (isDarkTheme(context))
                                        ? AppColors.black3C3C3C
                                        : AppColors.whiteEBEBEB,
                                    trackBorderColor: AppColors.transparent,
                                    controller:
                                        controller.recentScrollController,
                                    child: ScrollConfiguration(
                                      behavior: ScrollBehavior()
                                          .copyWith(scrollbars: false),
                                      child: ListView.separated(
                                        controller:
                                            controller.recentScrollController,
                                        itemCount:
                                            controller.recentOffersData.length,
                                        separatorBuilder:
                                            (BuildContext context, int index) {
                                          return Gap(10);
                                        },
                                        padding: EdgeInsets.only(right: 10),
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          AppointmentModel data = controller
                                              .recentOffersData[index];
                                          return Container(
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: (isDarkTheme(context))
                                                      ? AppColors.black2F2F2F
                                                      : AppColors.whiteEBEBEB),
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                            padding: EdgeInsets.all(15),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Image.asset(
                                                      data.image,
                                                      height: 55,
                                                      width: 55,
                                                    ),
                                                    Gap(10),
                                                    Expanded(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Row(
                                                            children: [
                                                              Assets
                                                                  .icons.icUser
                                                                  .svg(
                                                                height: 18,
                                                                width: 18,
                                                              ),
                                                              Gap(10),
                                                              Text(
                                                                data.name,
                                                                style:
                                                                    TextStyles
                                                                        .medium(
                                                                  11,
                                                                  fontColor:
                                                                      AppColors
                                                                          .grey5D5D5D,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          Gap(10),
                                                          Row(
                                                            children: [
                                                              Assets.icons
                                                                  .icScheduling
                                                                  .svg(
                                                                height: 18,
                                                                width: 18,
                                                              ),
                                                              Gap(10),
                                                              Text(
                                                                data.time,
                                                                style:
                                                                    TextStyles
                                                                        .medium(
                                                                  11,
                                                                  fontColor:
                                                                      AppColors
                                                                          .grey5D5D5D,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Gap(10),
                                                    Container(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 6,
                                                              vertical: 3),
                                                      decoration: BoxDecoration(
                                                        color: (data.status
                                                                    .toLowerCase() ==
                                                                'rejected')
                                                            ? (isDarkTheme(
                                                                    context))
                                                                ? AppColors
                                                                    .redD80909
                                                                    .withValues(
                                                                        alpha:
                                                                            0.2)
                                                                : AppColors
                                                                    .redFEE2E2
                                                            : (isDarkTheme(
                                                                    context))
                                                                ? AppColors
                                                                    .orange92400E
                                                                    .withValues(
                                                                        alpha:
                                                                            0.2)
                                                                : AppColors
                                                                    .orangeFEF3C7,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                      ),
                                                      child: Text(
                                                        data.status,
                                                        style:
                                                            TextStyles.medium(
                                                          11,
                                                          fontColor: (data
                                                                      .status
                                                                      .toLowerCase() ==
                                                                  'rejected')
                                                              ? AppColors
                                                                  .redEF4444
                                                              : (isDarkTheme(
                                                                      context))
                                                                  ? AppColors
                                                                      .orangeC27A0C
                                                                  : AppColors
                                                                      .orange92400E,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Gap(15),
                                                Text(
                                                  data.amount,
                                                  style: TextStyles.semiBold(
                                                    16,
                                                    fontColor:
                                                        AppColors.green16A34A,
                                                  ),
                                                ),
                                                Gap(8),
                                                Row(
                                                  children: [
                                                    Assets.icons.icLocationPin
                                                        .svg(),
                                                    Gap(12),
                                                    Text(
                                                      data.address,
                                                      style: TextStyles.medium(
                                                        13,
                                                        fontColor: AppColors
                                                            .grey5D5D5D,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Gap(15),
                                                Row(
                                                  children: [
                                                    CommonButton(
                                                      onPressed: () {},
                                                      buttonColor:
                                                          (isDarkTheme(context))
                                                              ? AppColors
                                                                  .black282828
                                                              : AppColors
                                                                  .whiteFFFFFF,
                                                      borderColor:
                                                          (isDarkTheme(context))
                                                              ? AppColors
                                                                  .black323232
                                                              : AppColors
                                                                  .whiteE1E1E1,
                                                      child: Text(
                                                        'Reschedule',
                                                        style: TextStyles.medium(
                                                            12,
                                                            fontColor: AppColors
                                                                .grey6D6D6D),
                                                      ),
                                                    ),
                                                    Gap(8),
                                                    CommonButton(
                                                      onPressed: () {},
                                                      buttonColor:
                                                          (isDarkTheme(context))
                                                              ? AppColors
                                                                  .black282828
                                                              : AppColors
                                                                  .whiteFFFFFF,
                                                      borderColor:
                                                          (isDarkTheme(context))
                                                              ? AppColors
                                                                  .black323232
                                                              : AppColors
                                                                  .whiteE1E1E1,
                                                      child: Text(
                                                        'Details',
                                                        style: TextStyles.medium(
                                                            12,
                                                            fontColor: AppColors
                                                                .grey6D6D6D),
                                                      ),
                                                    ),
                                                    Gap(8),
                                                    CommonButton(
                                                      onPressed: () {},
                                                      buttonColor:
                                                          (isDarkTheme(context))
                                                              ? AppColors
                                                                  .black282828
                                                              : AppColors
                                                                  .whiteFFFFFF,
                                                      borderColor:
                                                          (isDarkTheme(context))
                                                              ? AppColors
                                                                  .black323232
                                                              : AppColors
                                                                  .whiteE1E1E1,
                                                      child: Text(
                                                        'Cancel',
                                                        style: TextStyles.medium(
                                                            12,
                                                            fontColor: AppColors
                                                                .grey6D6D6D),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Gap(10),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: (isDarkTheme(context))
                                  ? AppColors.black1C1C1C
                                  : AppColors.whiteFFFFFF,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'AI Activity Summary',
                                  style: TextStyles.semiBold(16,
                                      fontColor: (isDarkTheme(context))
                                          ? AppColors.whiteFFFFFF
                                          : AppColors.black141414),
                                ),
                                Gap(15),
                                Expanded(
                                  child: ScrollConfiguration(
                                    behavior: ScrollBehavior()
                                        .copyWith(scrollbars: false),
                                    child: SingleChildScrollView(
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Expanded(
                                                child: AiActivityWidget(
                                                  bgColor: (isDarkTheme(
                                                          context))
                                                      ? AppColors.purple765CF6
                                                          .withValues(
                                                              alpha: 0.1)
                                                      : AppColors.whiteF5F3FF,
                                                  title: 'Offers Submitted',
                                                  icon: Assets.icons
                                                      .icOfferSubmitted.path,
                                                  index: ' 05',
                                                  upValue: 40,
                                                ),
                                              ),
                                              Gap(10),
                                              Expanded(
                                                child: AiActivityWidget(
                                                  bgColor: (isDarkTheme(
                                                          context))
                                                      ? AppColors.green059669
                                                          .withValues(
                                                              alpha: 0.1)
                                                      : AppColors.whiteECFDF5,
                                                  title: 'Follow-up Scheduled',
                                                  icon: Assets.icons
                                                      .icFollowUpScheduled.path,
                                                  index: ' 08',
                                                  upValue: 25,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Gap(10),
                                          Row(
                                            children: [
                                              Expanded(
                                                child: AiActivityWidget(
                                                  bgColor: (isDarkTheme(
                                                          context))
                                                      ? AppColors.purple765CF6
                                                          .withValues(
                                                              alpha: 0.1)
                                                      : AppColors.whiteF5F3FF,
                                                  title: 'Offers Submitted - 2',
                                                  icon: Assets.icons
                                                      .icOfferSubmitted.path,
                                                  index: ' 01',
                                                  upValue: 80,
                                                ),
                                              ),
                                              Gap(10),
                                              Expanded(
                                                child: AiActivityWidget(
                                                  bgColor: (isDarkTheme(
                                                          context))
                                                      ? AppColors.green059669
                                                          .withValues(
                                                              alpha: 0.1)
                                                      : AppColors.whiteECFDF5,
                                                  title:
                                                      'Follow-up Scheduled - 2',
                                                  icon: Assets.icons
                                                      .icFollowUpScheduled.path,
                                                  index: ' 02',
                                                  upValue: 50,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
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
          ],
        );
      }),
    );
  }
}
