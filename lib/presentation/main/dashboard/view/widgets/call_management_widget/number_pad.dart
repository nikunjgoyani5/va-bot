import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:va_bot_admin/core/theme/colors.dart';
import 'package:va_bot_admin/core/theme/text_styles.dart';
import 'package:va_bot_admin/presentation/main/dashboard/controller/dashboard_controller.dart';

class CustomNumberPad extends StatelessWidget {
  CustomNumberPad({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              dialButtons(
                text1: '1',
                text2: '',
              ),
              dialButtons(
                text1: '2',
                text2: 'ABC',
              ),
              dialButtons(
                text1: '3',
                text2: 'DEF',
              ),
            ],
          ),
        ),
        Gap(0.5.h),
        Divider(
          color: AppColors.greyE6E8EA,
          thickness: 3.sp,
        ),
        Gap(0.5.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              dialButtons(
                text1: '4',
                text2: 'GHI',
              ),
              dialButtons(
                text1: '5',
                text2: 'JKL',
              ),
              dialButtons(
                text1: '6',
                text2: 'MNO',
              ),
            ],
          ),
        ),
        Gap(0.5.h),
        Divider(
          color: AppColors.greyE6E8EA,
          thickness: 3.sp,
        ),
        Gap(0.5.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              dialButtons(
                text1: '7',
                text2: 'PQRS',
              ),
              dialButtons(
                text1: '8',
                text2: 'TUV',
              ),
              dialButtons(
                text1: '9',
                text2: 'WXYZ',
              ),
            ],
          ),
        ),
        Gap(0.5.h),
        Divider(
          color: AppColors.greyE6E8EA,
          thickness: 3.sp,
        ),
        Gap(0.5.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              dialButtons(
                text1: '*',
                text2: '',
              ),
              dialButtons(
                text1: '0',
                text2: '+',
              ),
              dialButtons(
                text1: '#',
                text2: '',
              ),
            ],
          ),
        ),
        Gap(0.5.h),
        Divider(
          color: AppColors.greyE6E8EA,
          thickness: 3.sp,
        ),
        Gap(0.5.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 3.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: null,
                icon: Icon(
                  Icons.backspace_outlined,
                  color: AppColors.transparent,
                ),
              ),
              InkWell(
                onTap: () {
                  DashboardScreenController controller = Get.find();
                  controller.onCall();
                },
                child: Container(
                  height: 7.h,
                  width: 7.h,
                  decoration: BoxDecoration(
                    color: AppColors.green16A34A,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Icon(
                      Icons.call,
                      color: AppColors.whiteFFFFFF,
                    ),
                  ),
                ),
              ),
              IconButton(
                  onPressed: () {
                    DashboardScreenController controller = Get.find();
                    controller.onBackSpace();
                    controller.update();
                  },
                  icon: Icon(Icons.backspace_outlined))
            ],
          ),
        ),
      ],
    );
  }

  Widget dialButtons({required String text1, required String text2}) {
    return InkWell(
      onTap: () {
        DashboardScreenController controller = Get.find();
        controller.onKeyPressed(text1);
        controller.update();
      },
      child: Column(
        children: [
          Text(
            text1,
            style: TextStyles.semiBold(
              20,
              fontColor: AppColors.black141414,
            ),
          ),
          Gap(0.5.h),
          Text(
            text2,
            style: TextStyles.regular(
              10,
              fontColor: AppColors.grey5D5D5D,
            ),
          ),
        ],
      ),
    );
  }
}
