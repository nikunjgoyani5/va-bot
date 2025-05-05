import 'package:va_bot_admin/core/constant/app_strings.dart';
import 'package:va_bot_admin/core/theme/text_styles.dart';
import 'package:va_bot_admin/core/theme/colors.dart';
import 'package:va_bot_admin/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:gap/gap.dart';

class StepOne extends StatelessWidget {
  const StepOne({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40.88.w,
      color: AppColors.transparent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Gap(4.h),
          Text(
            AppStrings.heresWhatVABotWilldoForYou,
            style: TextStyles.bold(
              30,
              fontColor: AppColors.black141414,
            ),
          ),
          Text(
            AppStrings.hiAngelineGotelli,
            style: TextStyles.regular(16, fontColor: AppColors.grey5D5D5D),
          ),
          Gap(5.h),
          Row(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.transparent,
                    border: Border.all(color: AppColors.whiteE1E1E1),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  padding: EdgeInsets.all(12.sp),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Assets.icons.icCall.svg(),
                      Gap(1.5.h),
                      Text(
                        AppStrings.letAIHandleYourCalls,
                        style: TextStyles.medium(
                          16,
                          fontColor: AppColors.black141414,
                        ),
                      ),
                      Gap(0.5.h),
                      Text(
                        AppStrings.smartCallManagementForSeamlessCommunication,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyles.regular(
                          12,
                          fontColor: AppColors.grey6D6D6D,
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
                    color: AppColors.transparent,
                    border: Border.all(color: AppColors.whiteE1E1E1),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  padding: EdgeInsets.all(12.sp),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Assets.icons.icDeal.svg(),
                      Gap(1.5.h),
                      Text(
                        AppStrings.neverMissADeal,
                        style: TextStyles.medium(
                          16,
                          fontColor: AppColors.black141414,
                        ),
                      ),
                      Gap(0.5.h),
                      Text(
                        AppStrings.getNotifiedAboutTheBestReal,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyles.regular(
                          12,
                          fontColor: AppColors.grey6D6D6D,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
