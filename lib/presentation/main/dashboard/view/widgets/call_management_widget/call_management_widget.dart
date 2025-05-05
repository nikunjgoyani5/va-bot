import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:va_bot_admin/core/theme/colors.dart';
import 'package:va_bot_admin/core/theme/text_styles.dart';
import 'package:va_bot_admin/core/utils/common_widgets/common_button.dart';
import 'package:va_bot_admin/data/model/dashboard_model/property_list_model.dart';
import 'package:va_bot_admin/gen/assets.gen.dart';
import 'package:va_bot_admin/presentation/main/dashboard/controller/dashboard_controller.dart';
import 'package:va_bot_admin/presentation/main/dashboard/view/widgets/call_management_widget/email_draft_widget.dart';
import 'package:va_bot_admin/presentation/main/dashboard/view/widgets/call_management_widget/number_pad.dart';
import 'package:va_bot_admin/presentation/main/dashboard/view/widgets/call_management_widget/recent_call_widget.dart';

class CallManagementWidget extends StatelessWidget {
  const CallManagementWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardScreenController>(builder: (controller) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 1.w),
        child: Column(
          children: [
            (controller.callerInfo.isNotEmpty)
                ? ListTile(
                    leading: Container(
                      height: 6.h,
                      width: 6.h,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(controller.callerInfo['image']),
                          fit: BoxFit.cover,
                        ),
                        shape: BoxShape.circle,
                      ),
                    ),
                    title: Text(
                      controller.callerInfo['name'],
                      style:
                          TextStyles.bold(24, fontColor: AppColors.black141414),
                    ),
                    subtitle: Text(
                      controller.callerInfo['email'],
                      style: TextStyles.regular(12,
                          fontColor: AppColors.grey5D5D5D),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CommonButton(
                          onPressed: () {},
                          buttonColor: AppColors.whiteFFFFFF,
                          buttonHeight: 18.sp,
                          buttonWidth: 40.sp,
                          borderColor: AppColors.whiteE1E1E1,
                          child: Text(
                            'Schedule Follow-up',
                            style: TextStyles.medium(
                              12,
                              fontColor: AppColors.grey6D6D6D,
                            ),
                          ),
                        ),
                        Gap(0.5.w),
                        CommonButton(
                          onPressed: () {},
                          buttonColor: AppColors.whiteFFFFFF,
                          borderColor: AppColors.whiteE1E1E1,
                          buttonHeight: 18.sp,
                          buttonWidth: 33.sp,
                          child: Text(
                            'Send Offer',
                            style: TextStyles.medium(
                              12,
                              fontColor: AppColors.grey6D6D6D,
                            ),
                          ),
                        ),
                        Gap(0.5.w),
                        CommonButton(
                          onPressed: () {},
                          buttonColor: AppColors.whiteFFFFFF,
                          borderColor: AppColors.whiteE1E1E1,
                          buttonHeight: 18.sp,
                          buttonWidth: 42.sp,
                          child: Text(
                            'Mark as Priority Lead',
                            style: TextStyles.medium(
                              12,
                              fontColor: AppColors.grey6D6D6D,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : SizedBox.shrink(),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(bottom: 0.8.h),
                      child: ScrollConfiguration(
                        behavior: ScrollBehavior().copyWith(scrollbars: false),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Builder(builder: (context) {
                                if (controller.callerInfo.isEmpty) {
                                  return Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: AppColors.whiteFFFFFF,
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                          color: AppColors.greyE6E8EA),
                                    ),
                                    child: Builder(builder: (context) {
                                      if (!controller.isCallActive) {
                                        return Column(
                                          children: [
                                            Gap(3.h),
                                            SingleChildScrollView(
                                              scrollDirection: Axis.horizontal,
                                              child: Row(
                                                children: [
                                                  Text(
                                                    controller.enteredNumber,
                                                    style: TextStyles.semiBold(
                                                      18.sp,
                                                      fontColor:
                                                          AppColors.black141414,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Gap(4.h),
                                            CustomNumberPad(),
                                            Gap(3.h),
                                          ],
                                        );
                                      } else {
                                        return Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 1.w),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Gap(3.h),
                                              Row(
                                                children: [
                                                  Container(
                                                    height: 1.2.h,
                                                    width: 1.2.h,
                                                    decoration: BoxDecoration(
                                                      color:
                                                          AppColors.green16A34A,
                                                      shape: BoxShape.circle,
                                                    ),
                                                  ),
                                                  Gap(1.w),
                                                  Text(
                                                    'Active Call',
                                                    style: TextStyles.semiBold(
                                                      16,
                                                      fontColor:
                                                          AppColors.black141414,
                                                    ),
                                                  ),
                                                  Spacer(),
                                                  Container(
                                                    decoration: BoxDecoration(
                                                      color:
                                                          AppColors.greenD1FAE5,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              6),
                                                    ),
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                      horizontal: 0.5.w,
                                                      vertical: 0.5.h,
                                                    ),
                                                    child: Center(
                                                      child: Text(
                                                        '12:45',
                                                        style:
                                                            TextStyles.medium(
                                                          11.5,
                                                          fontColor: AppColors
                                                              .green059669,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Gap(0.5.h),
                                              Row(
                                                children: [
                                                  Assets.icons.icBot.svg(
                                                    height: 2.5.h,
                                                    width: 2.5.h,
                                                    colorFilter:
                                                        ColorFilter.mode(
                                                      AppColors.grey7F878E,
                                                      BlendMode.srcIn,
                                                    ),
                                                  ),
                                                  Gap(0.5.w),
                                                  Text(
                                                    'Product Inquiry - Sales Bot',
                                                    style: TextStyles.medium(
                                                      12,
                                                      fontColor:
                                                          AppColors.grey7F878E,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Gap(1.5.h),
                                              Text(
                                                'John Anderson',
                                                style: TextStyles.medium(
                                                  14,
                                                  fontColor:
                                                      AppColors.black141414,
                                                ),
                                              ),
                                              Text(
                                                '${controller.enteredNumber}',
                                                style: TextStyles.medium(
                                                  12,
                                                  fontColor:
                                                      AppColors.grey7F878E,
                                                ),
                                              ),
                                              Gap(2.5.h),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  callOption(
                                                    iconPath: Assets
                                                        .icons.icMute.path,
                                                    title: 'Mute',
                                                    onPressed: () {},
                                                  ),
                                                  Gap(4.w),
                                                  callOption(
                                                    iconPath: Assets
                                                        .icons.icHold.path,
                                                    title: 'Hold',
                                                    onPressed: () {},
                                                  ),
                                                  Gap(4.w),
                                                  callOption(
                                                    iconPath: Assets
                                                        .icons.icCallEnd.path,
                                                    title: 'End',
                                                    onPressed: () {
                                                      controller.isCallActive =
                                                          false;
                                                      controller.callerInfo = {
                                                        'image': Assets.images
                                                            .johnAnderson.path,
                                                        'name': 'John Andreson',
                                                        'email':
                                                            'john.anderson@email.com',
                                                      };
                                                      controller
                                                              .selectedProperty =
                                                          controller
                                                              .propertyListDetails
                                                              .first;
                                                      controller.update();
                                                    },
                                                  ),
                                                  Gap(4.w),
                                                  callOption(
                                                    iconPath: Assets
                                                        .icons.icResponse.path,
                                                    title: 'Response',
                                                    onPressed: () {},
                                                  ),
                                                ],
                                              ),
                                              Gap(2.h),
                                              CommonButton(
                                                onPressed: () {},
                                                buttonWidth: double.infinity,
                                                buttonColor:
                                                    AppColors.whiteFFFFFF,
                                                borderColor:
                                                    AppColors.whiteE1E1E1,
                                                child: Text(
                                                  'Listen Live',
                                                  style: TextStyles.medium(
                                                    11.5,
                                                    fontColor:
                                                        AppColors.grey6D6D6D,
                                                  ),
                                                ),
                                              ),
                                              Gap(3.h),
                                            ],
                                          ),
                                        );
                                      }
                                    }),
                                  );
                                } else {
                                  return SizedBox.shrink();
                                }
                              }),
                              Gap(1.h),
                              Container(
                                decoration: BoxDecoration(
                                  color: AppColors.whiteFFFFFF,
                                  borderRadius: BorderRadius.circular(12),
                                  border:
                                      Border.all(color: AppColors.greyE6E8EA),
                                ),
                                padding: EdgeInsets.only(
                                  left: 1.w,
                                  top: 1.5.h,
                                  right: 1.w,
                                  bottom: 1.5.h,
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          'Recent Calls',
                                          style: TextStyles.semiBold(
                                            16,
                                            fontColor: AppColors.black141414,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Gap(1.h),
                                    Builder(builder: (context) {
                                      if (controller.callerInfo.isNotEmpty) {
                                        return ListView.separated(
                                          itemCount: 5,
                                          shrinkWrap: true,
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          separatorBuilder:
                                              (BuildContext context,
                                                  int index) {
                                            return Gap(2.5.h);
                                          },
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return Column(
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          'Answered 18 sec',
                                                          style:
                                                              TextStyles.medium(
                                                            15,
                                                            fontColor: AppColors
                                                                .black141414,
                                                          ),
                                                        ),
                                                        Gap(5),
                                                        Text(
                                                          'Today, 9:30 AM',
                                                          style:
                                                              TextStyles.medium(
                                                            13,
                                                            fontColor: AppColors
                                                                .grey7F878E,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    IconButton(
                                                      onPressed: () {},
                                                      icon: Assets.icons.icMore
                                                          .svg(
                                                        fit: BoxFit.scaleDown,
                                                        colorFilter:
                                                            ColorFilter.mode(
                                                          AppColors.grey5D5D5D,
                                                          BlendMode.srcIn,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Gap(12),
                                                Container(
                                                  width: double.infinity,
                                                  padding: EdgeInsets.only(
                                                      right: 14,
                                                      left: 7,
                                                      top: 3,
                                                      bottom: 3),
                                                  decoration: BoxDecoration(
                                                    color: AppColors.greyF3F5F7,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                  ),
                                                  child: Row(
                                                    children: [
                                                      Icon(
                                                        Icons.play_arrow,
                                                      ),
                                                      Gap(0.5.w),
                                                      Text(
                                                        '0:00 / 1:23',
                                                        style:
                                                            TextStyles.regular(
                                                          11,
                                                          fontColor: AppColors
                                                              .black141414,
                                                        ),
                                                      ),
                                                      Gap(0.5.w),
                                                      Expanded(
                                                        child:
                                                            LinearProgressIndicator(
                                                          value: 0.3,
                                                          color: AppColors
                                                              .black141414,
                                                          backgroundColor:
                                                              AppColors
                                                                  .greyD8DEE4,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      } else {
                                        return Column(
                                          children: [
                                            RecentCallWidget(
                                              title: 'John Doe',
                                              subTitle:
                                                  'Inbound (Client-Initiated)',
                                              date:
                                                  '${DateFormat('MMMM d, y, h: mm a').format(DateTime.now())}',
                                            ),
                                            Gap(1.h),
                                            RecentCallWidget(
                                              title: 'John Doe',
                                              subTitle:
                                                  'Outbound (AI-Initiated)',
                                              date:
                                                  '${DateFormat('MMMM d, y, h: mm a').format(DateTime.now())}',
                                            ),
                                          ],
                                        );
                                      }
                                    }),
                                  ],
                                ),
                              ),
                              Gap(1.h),
                              Container(
                                decoration: BoxDecoration(
                                  color: AppColors.whiteFFFFFF,
                                  borderRadius: BorderRadius.circular(12),
                                  border:
                                      Border.all(color: AppColors.greyE6E8EA),
                                ),
                                padding: EdgeInsets.only(
                                    left: 1.w,
                                    top: 1.5.h,
                                    right: 1.w,
                                    bottom: 1.5.h),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          'Email Draft',
                                          style: TextStyles.semiBold(
                                            16,
                                            fontColor: AppColors.black141414,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Gap(1.h),
                                    EmailDraftWidget(),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Gap(0.5.w),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(bottom: 0.8.h),
                      decoration: BoxDecoration(
                        color: AppColors.whiteFFFFFF,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppColors.greyE6E8EA),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 0.5.w),
                      child: Column(
                        children: [
                          Gap(1.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Live Transcription',
                                style: TextStyles.semiBold(16,
                                    fontColor: AppColors.black141414),
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    onPressed: () {},
                                    icon: Assets.icons.icDownload.svg(),
                                  ),
                                  Gap(0.3.w),
                                  IconButton(
                                    onPressed: () {},
                                    icon: Assets.icons.icCopy.svg(),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Gap(3.h),
                          Expanded(
                            child: ScrollConfiguration(
                              behavior:
                                  ScrollBehavior().copyWith(scrollbars: false),
                              child: ListView.separated(
                                itemCount: (controller.isCallActive ||
                                        controller.callerInfo.isNotEmpty)
                                    ? controller.liveTranscriptionDetails.length
                                    : 1,
                                separatorBuilder:
                                    (BuildContext context, int index) {
                                  return Gap(3.h);
                                },
                                itemBuilder: (BuildContext context, int index) {
                                  Map<String, dynamic> data = controller
                                      .liveTranscriptionDetails[index];
                                  return Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: (data['send'])
                                        ? MainAxisAlignment.end
                                        : MainAxisAlignment.start,
                                    children: [
                                      (data['send'])
                                          ? SizedBox.shrink()
                                          : Container(
                                              height: 6.h,
                                              width: 6.h,
                                              decoration: BoxDecoration(
                                                color: AppColors.greyF3F5F7,
                                                shape: BoxShape.circle,
                                              ),
                                              child: Center(
                                                child: Assets.icons.icBot.svg(
                                                  height: 3.5.h,
                                                  width: 3.5.h,
                                                  fit: BoxFit.scaleDown,
                                                ),
                                              ),
                                            ),
                                      Gap(0.5.w),
                                      (data['type'] == null)
                                          ? Container(
                                              constraints: BoxConstraints(
                                                  maxWidth: 18.w),
                                              decoration: BoxDecoration(
                                                  color: AppColors.greyF3F5F7),
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 1.w,
                                                  vertical: 1.h),
                                              child: Text(
                                                data['message'],
                                                textAlign: (data['send'])
                                                    ? TextAlign.end
                                                    : TextAlign.start,
                                                style: TextStyles.medium(
                                                  14,
                                                  fontColor:
                                                      AppColors.black000000,
                                                ),
                                              ),
                                            )
                                          : Container(
                                              decoration: BoxDecoration(
                                                  color: AppColors.greyF3F5F7),
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 1.w,
                                                  vertical: 1.h),
                                              constraints: BoxConstraints(
                                                  maxWidth: 18.w),
                                              child: Column(
                                                children: [
                                                  Text(
                                                    data['message'],
                                                    style: TextStyles.medium(
                                                      10,
                                                      fontColor:
                                                          AppColors.black000000,
                                                    ),
                                                  ),
                                                  Gap(1.h),
                                                  Container(
                                                    height: 8.h,
                                                    width: double.infinity,
                                                    decoration: BoxDecoration(
                                                      color:
                                                          AppColors.whiteFFFFFF,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Expanded(
                                                          child: Center(
                                                            child: Text(
                                                              'Smith Roy',
                                                              style: TextStyles
                                                                  .semiBold(
                                                                11.5,
                                                                fontColor: AppColors
                                                                    .black141414,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Gap(0.5.w),
                                                        Container(
                                                          height: 4.h,
                                                          width: 0.1.w,
                                                          color: AppColors
                                                              .greyF3F5F7,
                                                        ),
                                                        Gap(0.5.w),
                                                        Expanded(
                                                          child: Center(
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,
                                                              children: [
                                                                Text(
                                                                  'Smithroy179@gamil.com',
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  style:
                                                                      TextStyles
                                                                          .medium(
                                                                    10.5,
                                                                    fontColor:
                                                                        AppColors
                                                                            .black000000,
                                                                  ),
                                                                ),
                                                                Text(
                                                                  '+1 (817) 896-5846',
                                                                  style:
                                                                      TextStyles
                                                                          .medium(
                                                                    10.5,
                                                                    fontColor:
                                                                        AppColors
                                                                            .black000000,
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
                                      Gap(0.5.w),
                                      (data['send'] == false)
                                          ? SizedBox.shrink()
                                          : Container(
                                              height: 6.h,
                                              width: 6.h,
                                              decoration: BoxDecoration(
                                                color: AppColors.greyF3F5F7,
                                                shape: BoxShape.circle,
                                                image: DecorationImage(
                                                  image: AssetImage(
                                                    Assets.images.johnAnderson
                                                        .path,
                                                  ),
                                                  fit: BoxFit.scaleDown,
                                                ),
                                              ),
                                            ),
                                    ],
                                  );
                                },
                              ),
                            ),
                          ),
                          Gap(3.h),
                          Divider(),
                          Column(
                            children: [
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: [
                                    liveTranscriptionButton(
                                      title: 'Follow-Up in 24 Hours?',
                                      onPressed: () {},
                                    ),
                                    Gap(1.w),
                                    liveTranscriptionButton(
                                      title: 'Send Follow-Up Email?',
                                      onPressed: () {},
                                    ),
                                  ],
                                ),
                              ),
                              Gap(1.h),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: [
                                    liveTranscriptionButton(
                                      title: 'Add Client Notes',
                                      onPressed: () {},
                                    ),
                                    Gap(1.w),
                                    liveTranscriptionButton(
                                      title: 'Update CRM?',
                                      onPressed: () {},
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Gap(1.h),
                        ],
                      ),
                    ),
                  ),
                  Gap(0.5.w),
                  Expanded(
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: AppColors.whiteFFFFFF,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: AppColors.greyE6E8EA),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 1.5.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Gap(1.h),
                              Row(
                                children: [
                                  Text(
                                    'Caller Information',
                                    style: TextStyles.semiBold(16,
                                        fontColor: AppColors.black141414),
                                  ),
                                ],
                              ),
                              Builder(builder: (context) {
                                if (controller.isCallActive ||
                                    controller.callerInfo.isNotEmpty) {
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Gap(1.h),
                                      Text(
                                        'Name',
                                        style: TextStyles.medium(
                                          10,
                                          fontColor: AppColors.grey7F878E,
                                        ),
                                      ),
                                      Text(
                                        'John Anderson',
                                        style: TextStyles.medium(
                                          14,
                                          fontColor: AppColors.black141414,
                                        ),
                                      ),
                                      Gap(1.h),
                                      Text(
                                        'Email',
                                        style: TextStyles.medium(
                                          10,
                                          fontColor: AppColors.grey7F878E,
                                        ),
                                      ),
                                      Text(
                                        'john.anderson@email.com',
                                        style: TextStyles.medium(
                                          14,
                                          fontColor: AppColors.black141414,
                                        ),
                                      ),
                                      Gap(1.h),
                                      Text(
                                        'Interest',
                                        style: TextStyles.medium(
                                          10,
                                          fontColor: AppColors.grey7F878E,
                                        ),
                                      ),
                                      Text(
                                        'Residential Properties',
                                        style: TextStyles.medium(
                                          14,
                                          fontColor: AppColors.black141414,
                                        ),
                                      ),
                                      Gap(1.h),
                                    ],
                                  );
                                } else {
                                  return Center(
                                    heightFactor: 1.5.h,
                                    child: Text(
                                      'No active call at the moment',
                                      style: TextStyles.medium(
                                        14,
                                        fontColor: AppColors.grey7F878E,
                                      ),
                                    ),
                                  );
                                }
                              }),
                            ],
                          ),
                        ),
                        Gap(1.h),
                        Builder(builder: (context) {
                          if (controller.isCallActive ||
                              controller.callerInfo.isNotEmpty) {
                            return Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: AppColors.whiteFFFFFF,
                                  borderRadius: BorderRadius.circular(12),
                                  border:
                                      Border.all(color: AppColors.greyE6E8EA),
                                ),
                                margin: EdgeInsets.only(bottom: 0.8.h),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 1.5.w, vertical: 1.5.h),
                                child: Builder(builder: (context) {
                                  if (controller.selectedProperty == null) {
                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Property List',
                                          style: TextStyles.semiBold(
                                            16,
                                            fontColor: AppColors.black141414,
                                          ),
                                        ),
                                        Gap(1.h),
                                        Expanded(
                                          child: ScrollConfiguration(
                                            behavior: ScrollBehavior()
                                                .copyWith(scrollbars: false),
                                            child: ListView.separated(
                                              itemCount: controller
                                                  .propertyListDetails.length,
                                              separatorBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                return Column(
                                                  children: [
                                                    Gap(0.5.h),
                                                    Divider(
                                                      color:
                                                          AppColors.whiteEBEBEB,
                                                    ),
                                                    Gap(0.5.h),
                                                  ],
                                                );
                                              },
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                PropertyListModel data =
                                                    controller
                                                            .propertyListDetails[
                                                        index];
                                                return InkWell(
                                                  onTap: () {
                                                    controller
                                                            .selectedProperty =
                                                        data;
                                                    controller.update();
                                                  },
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Image.asset(
                                                            data.imagePath,
                                                            height: 10.h,
                                                            width: 10.h,
                                                          ),
                                                          Gap(1.w),
                                                          Expanded(
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Text(
                                                                  'Property Address',
                                                                  style:
                                                                      TextStyles
                                                                          .medium(
                                                                    12,
                                                                    fontColor:
                                                                        AppColors
                                                                            .grey7F878E,
                                                                  ),
                                                                ),
                                                                Text(
                                                                  data.propertyName,
                                                                  maxLines: 2,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  style:
                                                                      TextStyles
                                                                          .medium(
                                                                    14,
                                                                    fontColor:
                                                                        AppColors
                                                                            .black141414,
                                                                  ),
                                                                ),
                                                                Gap(1.h),
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    Text(
                                                                      'Date Viewed',
                                                                      style: TextStyles
                                                                          .medium(
                                                                        12,
                                                                        fontColor:
                                                                            AppColors.grey7F878E,
                                                                      ),
                                                                    ),
                                                                    Text(
                                                                      DateFormat(
                                                                              "MMMM d, y")
                                                                          .format(
                                                                              data.propertyViewedDate),
                                                                      style: TextStyles
                                                                          .medium(
                                                                        12,
                                                                        fontColor:
                                                                            AppColors.black141414,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                                Gap(0.5.h),
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    Text(
                                                                      'Interest Level',
                                                                      style: TextStyles
                                                                          .medium(
                                                                        12,
                                                                        fontColor:
                                                                            AppColors.grey7F878E,
                                                                      ),
                                                                    ),
                                                                    Container(
                                                                      padding: EdgeInsets.symmetric(
                                                                          horizontal: 0.5
                                                                              .w,
                                                                          vertical:
                                                                              0.5.h),
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: (data.interestLevel.toLowerCase() ==
                                                                                'considering')
                                                                            ? AppColors.orangeFEF3C7
                                                                            : AppColors.greenD1FAE5,
                                                                        borderRadius:
                                                                            BorderRadius.circular(5),
                                                                      ),
                                                                      child:
                                                                          Text(
                                                                        data.interestLevel,
                                                                        style: TextStyles
                                                                            .medium(
                                                                          12,
                                                                          fontColor: (data.interestLevel.toLowerCase() == 'considering')
                                                                              ? AppColors.orange92400E
                                                                              : AppColors.green059669,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Gap(1.h),
                                                      Row(
                                                        children: [
                                                          CommonButton(
                                                            onPressed: () {},
                                                            buttonWidth: 38.sp,
                                                            buttonColor:
                                                                AppColors
                                                                    .whiteFFFFFF,
                                                            borderColor:
                                                                AppColors
                                                                    .whiteE1E1E1,
                                                            child: Text(
                                                              'Schedule Second Visit',
                                                              style: TextStyles
                                                                  .medium(
                                                                12,
                                                                fontColor: AppColors
                                                                    .grey6D6D6D,
                                                              ),
                                                            ),
                                                          ),
                                                          Gap(1.w),
                                                          CommonButton(
                                                            onPressed: () {},
                                                            buttonWidth: 38.sp,
                                                            buttonColor:
                                                                AppColors
                                                                    .whiteFFFFFF,
                                                            borderColor:
                                                                AppColors
                                                                    .whiteE1E1E1,
                                                            child: Text(
                                                              'Suggest Similar Listings',
                                                              style: TextStyles
                                                                  .medium(
                                                                12,
                                                                fontColor: AppColors
                                                                    .grey6D6D6D,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Gap(0.5.h),
                                                      CommonButton(
                                                        onPressed: () {},
                                                        buttonWidth: 38.sp,
                                                        buttonColor: AppColors
                                                            .whiteFFFFFF,
                                                        borderColor: AppColors
                                                            .whiteE1E1E1,
                                                        child: Text(
                                                          'Follow Up in 3 Days',
                                                          style:
                                                              TextStyles.medium(
                                                            12,
                                                            fontColor: AppColors
                                                                .grey6D6D6D,
                                                          ),
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
                                    );
                                  } else {
                                    return ScrollConfiguration(
                                      behavior: ScrollBehavior()
                                          .copyWith(scrollbars: false),
                                      child: SingleChildScrollView(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                (controller.callerInfo.isEmpty)
                                                    ? InkWell(
                                                        onTap: () {
                                                          controller
                                                                  .selectedProperty =
                                                              null;
                                                          controller.update();
                                                        },
                                                        child: Icon(Icons
                                                            .keyboard_arrow_left),
                                                      )
                                                    : SizedBox.shrink(),
                                                Gap(0.5.w),
                                                Text(
                                                  'Property Details',
                                                  style: TextStyles.semiBold(
                                                    16,
                                                    fontColor:
                                                        AppColors.black141414,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Gap(1.h),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  height: 20.h,
                                                  width: double.infinity,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    image: DecorationImage(
                                                      image: AssetImage(
                                                          controller
                                                              .selectedProperty!
                                                              .imagePath),
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                                Gap(2.h),
                                                Row(
                                                  children: [
                                                    Assets
                                                        .icons.icPropertyAddress
                                                        .svg(
                                                      fit: BoxFit.scaleDown,
                                                    ),
                                                    Gap(1.w),
                                                    Text(
                                                      'Property Address',
                                                      style: TextStyles.medium(
                                                        12,
                                                        fontColor: AppColors
                                                            .grey7F878E,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Gap(1.h),
                                                Text(
                                                  controller.selectedProperty!
                                                      .propertyName,
                                                  style: TextStyles.medium(
                                                    14,
                                                    fontColor:
                                                        AppColors.black141414,
                                                  ),
                                                ),
                                                Gap(1.h),
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      child: Container(
                                                        decoration: BoxDecoration(
                                                            color: AppColors
                                                                .greyF3F5F7,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10)),
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal: 1.w,
                                                                vertical: 1.h),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              'Equity',
                                                              style: TextStyles
                                                                  .medium(
                                                                12,
                                                                fontColor: AppColors
                                                                    .grey7F878E,
                                                              ),
                                                            ),
                                                            Text(
                                                              controller
                                                                  .selectedProperty!
                                                                  .equity,
                                                              style: TextStyles
                                                                  .medium(
                                                                14,
                                                                fontColor: AppColors
                                                                    .black141414,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    Gap(1.w),
                                                    Expanded(
                                                      child: Container(
                                                        decoration: BoxDecoration(
                                                            color: AppColors
                                                                .greyF3F5F7,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10)),
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal: 1.w,
                                                                vertical: 1.h),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              'Equity',
                                                              style: TextStyles
                                                                  .medium(
                                                                12,
                                                                fontColor: AppColors
                                                                    .grey7F878E,
                                                              ),
                                                            ),
                                                            Text(
                                                              controller
                                                                  .selectedProperty!
                                                                  .equity,
                                                              style: TextStyles
                                                                  .medium(
                                                                14,
                                                                fontColor: AppColors
                                                                    .black141414,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Gap(0.5.h),
                                                Divider(
                                                    color:
                                                        AppColors.greyE6E8EA),
                                                Gap(0.5.h),
                                                Text(
                                                  'Tax & Public Records',
                                                  style: TextStyles.semiBold(
                                                    16,
                                                    fontColor:
                                                        AppColors.black141414,
                                                  ),
                                                ),
                                                Gap(0.8.h),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      'Last Sale Date',
                                                      style: TextStyles.medium(
                                                        14,
                                                        fontColor: AppColors
                                                            .grey7F878E,
                                                      ),
                                                    ),
                                                    Text(
                                                      controller
                                                          .selectedProperty!
                                                          .lastSellDate,
                                                      style: TextStyles.medium(
                                                        14,
                                                        fontColor: AppColors
                                                            .black141414,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Gap(0.5.h),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      'Last Sale Price',
                                                      style: TextStyles.medium(
                                                        14,
                                                        fontColor: AppColors
                                                            .grey7F878E,
                                                      ),
                                                    ),
                                                    Text(
                                                      controller
                                                          .selectedProperty!
                                                          .lastSellPrice,
                                                      style: TextStyles.medium(
                                                        14,
                                                        fontColor: AppColors
                                                            .black141414,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Gap(0.5.h),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      'Property Tax(2025)',
                                                      style: TextStyles.medium(
                                                        14,
                                                        fontColor: AppColors
                                                            .grey7F878E,
                                                      ),
                                                    ),
                                                    Text(
                                                      controller
                                                          .selectedProperty!
                                                          .propertyTax,
                                                      style: TextStyles.medium(
                                                        14,
                                                        fontColor: AppColors
                                                            .black141414,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Gap(0.5.h),
                                                Divider(
                                                    color:
                                                        AppColors.greyE6E8EA),
                                                Gap(0.5.h),
                                                Text(
                                                  'Lockbox information',
                                                  style: TextStyles.semiBold(
                                                    12,
                                                    fontColor:
                                                        AppColors.black141414,
                                                  ),
                                                ),
                                                Gap(0.8.h),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  }
                                }),
                              ),
                            );
                          } else {
                            return SizedBox.shrink();
                          }
                        })
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

  Widget callOption({
    required String iconPath,
    required String title,
    required void Function() onPressed,
  }) {
    return InkWell(
      onTap: onPressed,
      child: Column(
        children: [
          SvgPicture.asset(
            iconPath,
            height: 20,
            width: 20,
          ),
          Gap(1.h),
          Text(
            title,
            style: TextStyles.medium(
              12,
              fontColor: AppColors.black141414,
            ),
          ),
        ],
      ),
    );
  }

  Widget liveTranscriptionButton(
      {required String title, required void Function()? onPressed}) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.greyF3F5F7,
          borderRadius: BorderRadius.circular(20),
        ),
        padding: EdgeInsets.symmetric(horizontal: 1.w, vertical: 0.5.h),
        child: Center(
          child: Text(
            title,
            style: TextStyles.medium(
              14,
              fontColor: AppColors.black141414,
            ),
          ),
        ),
      ),
    );
  }
}
