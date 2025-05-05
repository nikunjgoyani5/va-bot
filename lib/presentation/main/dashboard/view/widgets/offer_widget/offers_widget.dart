import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:va_bot_admin/core/theme/text_styles.dart';
import 'package:va_bot_admin/core/utils/common_widgets/common_button.dart';
import 'package:va_bot_admin/data/model/dashboard_model/all_offers_model.dart';
import 'package:va_bot_admin/presentation/main/dashboard/controller/dashboard_controller.dart';
import 'package:va_bot_admin/presentation/main/dashboard/view/widgets/offer_widget/top_container_widget.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:dotted_border/dotted_border.dart';
import '../../../../../../core/theme/colors.dart';
import '../../../../../../core/utils/common_widgets/common_text_field.dart';
import '../../../../../../gen/assets.gen.dart';

class OffersWidget extends StatelessWidget {
  const OffersWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardScreenController>(builder: (controller) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 1.w),
        child: Builder(
          builder: (context) {
            if (controller.isPDFEditor == false) {
              return Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: TopContainerWidget(
                          offerValue: 24,
                          offerType: 'Active Offers',
                          imagePath: Assets.icons.icActiveOffers.path,
                          iconBgColor: AppColors.whiteEFF6FF,
                        ),
                      ),
                      Gap(1.w),
                      Expanded(
                        child: TopContainerWidget(
                          offerValue: 12,
                          offerType: 'Completed Today',
                          imagePath: Assets.icons.icCompletedToday.path,
                          iconBgColor: AppColors.greenECFDF4,
                        ),
                      ),
                      Gap(1.w),
                      Expanded(
                        child: TopContainerWidget(
                          offerValue: 8,
                          offerType: 'Pending Signature',
                          imagePath: Assets.icons.icPendingSignature.path,
                          iconBgColor: AppColors.orangeFFFBEB,
                        ),
                      ),
                    ],
                  ),
                  Gap(1.h),
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Container(
                            decoration: BoxDecoration(
                              color: AppColors.whiteFFFFFF,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: AppColors.whiteEBEBEB),
                            ),
                            padding: EdgeInsets.only(
                                left: 1.w, right: 1.w, top: 1.h, bottom: 1.h),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'All Offers',
                                      style: TextStyles.semiBold(
                                        16,
                                        fontColor: AppColors.black141414,
                                      ),
                                    ),
                                    Container(
                                      height: 9.h,
                                      width: 30.w,
                                      child: Row(
                                        children: [
                                          Expanded(
                                            flex: 2,
                                            child: CommonTextField(
                                              hintText: 'Search anything here',
                                              controller:
                                                  controller.searchController,
                                              prefixIcon: Assets.icons.icSearch
                                                  .svg(fit: BoxFit.scaleDown),
                                              fillColor: AppColors.whiteFFFFFF,
                                            ),
                                          ),
                                          Gap(1.w),
                                          Expanded(
                                            child: DropdownButtonFormField(
                                              isDense: true,
                                              decoration: InputDecoration(
                                                border: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: AppColors.greyE5E5E5,
                                                    width: 1.5,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: AppColors.greyE5E5E5,
                                                    width: 1.5,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: AppColors.greyE5E5E5,
                                                    width: 1.5,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                              ),
                                              value: 'All Status',
                                              style: TextStyles.regular(12,
                                                  fontColor:
                                                      AppColors.black141414),
                                              icon: Assets.icons.icDropdownArrow
                                                  .svg(
                                                height: 10,
                                                width: 10,
                                              ),
                                              items: [
                                                DropdownMenuItem(
                                                  child: Text('All Status'),
                                                  value: 'All Status',
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
                                              onChanged: (val) {
                                                controller.update();
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Gap(2.h),
                                Expanded(
                                  child: ScrollConfiguration(
                                    behavior: ScrollBehavior()
                                        .copyWith(scrollbars: false),
                                    child: ListView.separated(
                                      itemCount:
                                          controller.allOffersDetails.length,
                                      shrinkWrap: true,
                                      separatorBuilder:
                                          (BuildContext context, int index) {
                                        return Divider();
                                      },
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        AllOffersModel data =
                                            controller.allOffersDetails[index];
                                        return Container(
                                          child: Row(
                                            children: [
                                              Container(
                                                height: 80,
                                                width: 80,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  image: DecorationImage(
                                                    image: AssetImage(
                                                      data.imagePath,
                                                    ),
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                              Gap(1.w),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        Text(
                                                          data.title,
                                                          style: TextStyles
                                                              .semiBold(
                                                            11,
                                                            fontColor: AppColors
                                                                .black141414,
                                                          ),
                                                        ),
                                                        Gap(0.5.w),
                                                        Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        6),
                                                            color: (data.status
                                                                        .toLowerCase() ==
                                                                    'waiting for signature')
                                                                ? AppColors
                                                                    .orangeFEF3C7
                                                                : (data.status
                                                                            .toLowerCase() ==
                                                                        'signed by buyer')
                                                                    ? AppColors
                                                                        .greenD1FAE5
                                                                    : (data.status.toLowerCase() ==
                                                                            'sent to listing agent')
                                                                        ? AppColors
                                                                            .blueDBEAFE
                                                                        : AppColors
                                                                            .whiteF5F5F5,
                                                          ),
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      1.w,
                                                                  vertical:
                                                                      0.5.h),
                                                          child: Center(
                                                            child: Text(
                                                              data.status,
                                                              style: TextStyles
                                                                  .medium(
                                                                10,
                                                                fontColor: (data
                                                                            .status
                                                                            .toLowerCase() ==
                                                                        'waiting for signature')
                                                                    ? AppColors
                                                                        .orange92400E
                                                                    : (data.status.toLowerCase() ==
                                                                            'signed by buyer')
                                                                        ? AppColors
                                                                            .green059669
                                                                        : (data.status.toLowerCase() ==
                                                                                'sent to listing agent')
                                                                            ? AppColors.primaryColor
                                                                            : AppColors.grey5D5D5D,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Gap(0.5.h),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          'Offer Amount: ',
                                                          style: TextStyles
                                                              .regular(
                                                            11,
                                                            fontColor: AppColors
                                                                .grey6D6D6D,
                                                          ),
                                                        ),
                                                        Text(
                                                          '\$${data.offerAmount}',
                                                          style:
                                                              TextStyles.medium(
                                                            11,
                                                            fontColor: AppColors
                                                                .black141414,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Gap(0.9.h),
                                                    Row(
                                                      children: [
                                                        Container(
                                                          height: 22,
                                                          width: 22,
                                                          decoration:
                                                              BoxDecoration(
                                                            shape:
                                                                BoxShape.circle,
                                                            image: DecorationImage(
                                                                image: AssetImage(data
                                                                    .profile
                                                                    .imagePath),
                                                                fit: BoxFit
                                                                    .cover),
                                                          ),
                                                        ),
                                                        Gap(0.5.w),
                                                        Text(
                                                          data.profile.name,
                                                          style:
                                                              TextStyles.medium(
                                                            11,
                                                            fontColor: AppColors
                                                                .black141414,
                                                          ),
                                                        ),
                                                        Gap(0.5.w),
                                                        Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        6),
                                                            color: AppColors
                                                                .whiteF5F5F5,
                                                          ),
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      1.w,
                                                                  vertical:
                                                                      0.5.h),
                                                          child: Center(
                                                            child: Text(
                                                              data.profile
                                                                  .status,
                                                              style: TextStyles
                                                                  .medium(
                                                                10,
                                                                fontColor: AppColors
                                                                    .black141414,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              CommonButton(
                                                onPressed: () {},
                                                buttonColor: (index == 1 ||
                                                        index == 2)
                                                    ? AppColors.whiteFFFFFF
                                                    : AppColors.primaryColor,
                                                borderColor:
                                                    (index == 1 || index == 2)
                                                        ? AppColors.whiteE1E1E1
                                                        : null,
                                                child: Text(
                                                  (index == 1 || index == 2)
                                                      ? 'View Details'
                                                      : 'Send Reminders',
                                                  style: TextStyles.medium(
                                                    11,
                                                    fontColor: (index == 1 ||
                                                            index == 2)
                                                        ? AppColors.grey6D6D6D
                                                        : AppColors.whiteF5F5F5,
                                                  ),
                                                ),
                                              ),
                                              Gap(0.3.w),
                                              IconButton(
                                                onPressed: () {},
                                                icon: Assets.icons.icMore.svg(),
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
                        Gap(1.w),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: AppColors.whiteFFFFFF,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: AppColors.whiteEBEBEB),
                            ),
                            padding: EdgeInsets.only(
                                left: 1.w, right: 1.w, top: 1.h, bottom: 1.h),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Recent Activity',
                                  style: TextStyles.semiBold(
                                    16,
                                    fontColor: AppColors.black141414,
                                  ),
                                ),
                                Gap(10),
                                Expanded(
                                  child: ListView.separated(
                                    itemCount:
                                        controller.recentActivityList.length,
                                    separatorBuilder:
                                        (BuildContext context, int index) {
                                      return Gap(1.h);
                                    },
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      Map<String, dynamic> data =
                                          controller.recentActivityList[index];
                                      return Container(
                                        decoration: BoxDecoration(
                                          color: AppColors.whiteF8F8F8,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 1.w, vertical: 1.h),
                                        child: Row(
                                          children: [
                                            Container(
                                              height: 5.h,
                                              width: 5.h,
                                              decoration: BoxDecoration(
                                                color: AppColors.whiteFFFFFF,
                                                shape: BoxShape.circle,
                                              ),
                                              child: Center(
                                                child: SvgPicture.asset(
                                                  data['imagePath'],
                                                  colorFilter: ColorFilter.mode(
                                                    AppColors.primaryColor,
                                                    BlendMode.srcIn,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Gap(1.w),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    '${data['title']}',
                                                    maxLines: 3,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyles.medium(
                                                      12,
                                                      fontColor:
                                                          AppColors.black141414,
                                                    ),
                                                  ),
                                                  Text(
                                                    '${data['time']}',
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyles.regular(
                                                      10,
                                                      fontColor:
                                                          AppColors.grey6D6D6D,
                                                    ),
                                                  ),
                                                ],
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
                        ),
                      ],
                    ),
                  ),
                  Gap(1.h),
                ],
              );
            } else {
              return Column(
                children: [
                  Gap(1.h),
                  Expanded(
                    child: Row(
                      children: [
                        Container(
                          width: 18.w,
                          height: double.infinity,
                          color: Colors.white,
                          child: Column(
                            children: [
                              TabBar(
                                controller: controller.controller1,
                                indicatorSize: TabBarIndicatorSize.label,
                                indicatorColor: AppColors.primaryColor,
                                indicatorWeight: 0.1,
                                labelStyle: TextStyles.medium(12,
                                    fontColor: AppColors.primaryColor),
                                unselectedLabelStyle: TextStyles.medium(
                                  12,
                                  fontColor: AppColors.grey5D5D5D,
                                ),
                                dividerColor: AppColors.greyCBCBCB,
                                tabs: [
                                  Tab(
                                    text: 'Information',
                                  ),
                                  Tab(
                                    text: 'E-Sign',
                                  ),
                                ],
                              ),
                              Expanded(
                                child: TabBarView(
                                  controller: controller.controller1,
                                  children: [
                                    Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 1.w),
                                      child: ScrollConfiguration(
                                        behavior: ScrollBehavior()
                                            .copyWith(scrollbars: false),
                                        child: SingleChildScrollView(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Gap(2.h),
                                              Text(
                                                'Buyer Information',
                                                style: TextStyles.semiBold(
                                                  14,
                                                  fontColor:
                                                      AppColors.black141414,
                                                ),
                                              ),
                                              Gap(1.8.h),
                                              _informationNameValue(
                                                title: 'Name',
                                                value: 'John Anderson',
                                              ),
                                              Gap(1.h),
                                              _informationNameValue(
                                                title: 'Mobile Number',
                                                value: '+1 9888 6554 6544',
                                              ),
                                              Gap(1.h),
                                              _informationNameValue(
                                                title: 'Email',
                                                value:
                                                    'john.anderson@email.com',
                                              ),
                                              Gap(1.8.h),
                                              Divider(),
                                              Gap(1.8.h),
                                              Text(
                                                'Seller Information',
                                                style: TextStyles.semiBold(
                                                  14,
                                                  fontColor:
                                                      AppColors.black141414,
                                                ),
                                              ),
                                              Gap(1.8.h),
                                              _informationNameValue(
                                                title: 'Name',
                                                value: 'John Anderson',
                                              ),
                                              Gap(1.h),
                                              _informationNameValue(
                                                title: 'Mobile Number',
                                                value: '+1 9888 6554 6544',
                                              ),
                                              Gap(1.h),
                                              _informationNameValue(
                                                title: 'MLS Number',
                                                value: 'Residential Properties',
                                              ),
                                              Gap(1.8.h),
                                              Divider(),
                                              Gap(1.8.h),
                                              Text(
                                                'Property Information',
                                                style: TextStyles.semiBold(
                                                  14,
                                                  fontColor:
                                                      AppColors.black141414,
                                                ),
                                              ),
                                              Gap(1.8.h),
                                              Assets.images.house4.image(
                                                height: 10.h,
                                                width: 10.h,
                                              ),
                                              Gap(1.h),
                                              _informationNameValue(
                                                title: 'Property Type',
                                                value: 'Residential',
                                              ),
                                              Gap(1.h),
                                              _informationNameValue(
                                                title: 'Location Preferences',
                                                value:
                                                    'Lincoln Drive Harrisburg, PA 17101 U.S.A',
                                              ),
                                              Gap(1.h),
                                              _informationNameValue(
                                                title: 'Ownership Type',
                                                value: 'Freehold',
                                              ),
                                              Gap(3.h),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Center(
                                      child: Builder(builder: (context) {
                                        if (controller
                                            .savedSignatures.isEmpty) {
                                          return Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Assets.images.newSignature.image(
                                                height: 10.h,
                                                width: 10.w,
                                              ),
                                              Gap(2.h),
                                              Text(
                                                'Create your eSignature',
                                                style: TextStyles.medium(
                                                  14,
                                                  fontColor:
                                                      AppColors.black141414,
                                                ),
                                              ),
                                              Gap(2.h),
                                              InkWell(
                                                onTap: () {
                                                  controller
                                                      .selectedSignatureIndex = 0;
                                                  controller
                                                      .openSignatureDialog(
                                                          context);
                                                },
                                                child: DottedBorder(
                                                  color: AppColors.greyD7D7D7,
                                                  strokeWidth: 2,
                                                  dashPattern: [
                                                    8,
                                                    4
                                                  ], // Dash pattern: 8px line, 4px gap
                                                  borderType: BorderType.RRect,
                                                  radius: Radius.circular(8),
                                                  child: Container(
                                                    height: 30,
                                                    width: 200,
                                                    decoration: BoxDecoration(
                                                      color:
                                                          AppColors.whiteFFFFFF,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                    ),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Icon(
                                                          Icons.add,
                                                          color: AppColors
                                                              .grey888888,
                                                        ),
                                                        Gap(0.5.w),
                                                        Text(
                                                          'Add Signature',
                                                          style:
                                                              TextStyles.medium(
                                                            11,
                                                            fontColor: AppColors
                                                                .grey888888,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
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
                                                Gap(1.h),
                                                Text(
                                                  'Your Signature',
                                                  style: TextStyles.medium(
                                                    10.5,
                                                    fontColor:
                                                        AppColors.grey888888,
                                                  ),
                                                ),
                                                Gap(1.h),
                                                InkWell(
                                                  onTap: () {
                                                    controller
                                                        .selectedSignatureIndex = 0;
                                                    controller
                                                        .openSignatureDialog(
                                                            context);
                                                  },
                                                  child: DottedBorder(
                                                    color: AppColors.greyD7D7D7,
                                                    strokeWidth: 2,
                                                    dashPattern: [8, 4],
                                                    borderType:
                                                        BorderType.RRect,
                                                    radius: Radius.circular(8),
                                                    child: Container(
                                                      height: 6.h,
                                                      width: double.infinity,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Icon(
                                                            Icons.add,
                                                            color: AppColors
                                                                .grey888888,
                                                          ),
                                                          Gap(0.5.w),
                                                          Text(
                                                            'Add Signature',
                                                            style: TextStyles
                                                                .medium(
                                                              10.6,
                                                              fontColor: AppColors
                                                                  .grey888888,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Gap(1.h),
                                                ListView.separated(
                                                  itemCount: controller
                                                      .savedSignatures.length,
                                                  shrinkWrap: true,
                                                  separatorBuilder:
                                                      (BuildContext context,
                                                          int index) {
                                                    return Gap(1.h);
                                                  },
                                                  itemBuilder:
                                                      (BuildContext context,
                                                          int index) {
                                                    return Container(
                                                      height: 6.h,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        border: Border.all(
                                                            color: AppColors
                                                                .greyD7D7D7),
                                                      ),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          SizedBox(),
                                                          Image.memory(
                                                            controller
                                                                    .savedSignatures[
                                                                index],
                                                            height: 5.h,
                                                            width: 5.h,
                                                          ),
                                                          IconButton(
                                                            onPressed: () {
                                                              controller
                                                                  .savedSignatures
                                                                  .removeAt(
                                                                      index);
                                                              controller
                                                                  .update();
                                                            },
                                                            icon: Icon(
                                                                Icons.close),
                                                          ),
                                                        ],
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ],
                                            ),
                                          );
                                        }
                                      }),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Gap(0.5.w),
                        Expanded(
                          child: Container(
                            color: AppColors.transparent,
                            child: (controller.isPDFLoading)
                                ? Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : HtmlElementView(
                                    viewType: 'pspdfkit-view',
                                  ),
                          ),
                        ),
                        Gap(0.5.w),
                        Container(
                          width: 18.w,
                          height: double.infinity,
                          color: AppColors.whiteFFFFFF,
                          padding: EdgeInsets.symmetric(horizontal: 1.w),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Gap(1.h),
                                  _historyWidget(
                                    title: 'Page 1',
                                    subTitles: [
                                      'Atlanta',
                                      '30349',
                                      '13-0072D-00H-001',
                                      '7509102',
                                    ],
                                  ),
                                  _historyWidget(
                                    title: 'Page 4',
                                    subTitles: [
                                      'Jazmeen Hameed',
                                      '37605',
                                    ],
                                  ),
                                ],
                              ),
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    child: Stack(
                                      children: [
                                        CommonTextField(
                                          hintText: 'Enter a message copilot',
                                          controller: TextEditingController(),
                                          maxLines: 5,
                                        ),
                                        Positioned(
                                          right: 7,
                                          bottom: 7,
                                          child: InkWell(
                                            child: Container(
                                              height: 40,
                                              width: 40,
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
                                                    BorderRadius.circular(10),
                                              ),
                                              child: Center(
                                                child:
                                                    Assets.icons.icMike.svg(),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Gap(0.8.h),
                                  CommonButton(
                                    onPressed: () {},
                                    buttonWidth: double.infinity,
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          'Save and Send',
                                          style: TextStyles.medium(12.5,
                                              fontColor: AppColors.whiteFFFFFF),
                                        ),
                                        Gap(0.8.w),
                                        Icon(
                                          Icons.keyboard_arrow_up,
                                          color: AppColors.whiteFFFFFF,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Gap(1.h),
                ],
              );
            }
          },
        ),
      );
    });
  }

  _informationNameValue({required String title, required String value}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyles.medium(
            10,
            fontColor: AppColors.grey7F878E,
          ),
        ),
        Text(
          value,
          style: TextStyles.medium(
            13,
            fontColor: AppColors.black141414,
          ),
        ),
      ],
    );
  }

  _historyWidget({required String title, required List<String> subTitles}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyles.medium(
                12,
                fontColor: AppColors.black141414,
              ),
            ),
            TextButton(
              onPressed: () {},
              child: Text(
                'Clear all',
                style: TextStyles.medium(10, fontColor: AppColors.redEF4444),
              ),
            )
          ],
        ),
        Divider(),
        ListView.separated(
          itemCount: subTitles.length,
          separatorBuilder: (BuildContext context, int index) {
            return Gap(10);
          },
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            return Row(
              children: [
                Expanded(
                  child: Text(
                    subTitles[index],
                    style:
                        TextStyles.medium(11, fontColor: AppColors.grey5D5D5D),
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Assets.icons.icEdit.svg(),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Assets.icons.icDelete.svg(),
                ),
              ],
            );
          },
        ),
        Gap(1.h),
      ],
    );
  }
}
