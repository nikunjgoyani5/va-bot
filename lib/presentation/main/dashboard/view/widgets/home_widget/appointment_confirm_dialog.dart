import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:va_bot_admin/core/theme/colors.dart';
import 'package:va_bot_admin/core/theme/text_styles.dart';
import 'package:va_bot_admin/core/utils/common_widgets/common_button.dart';
import 'package:va_bot_admin/core/utils/common_widgets/common_dialog.dart';
import 'package:flutter/material.dart';
import 'package:va_bot_admin/routes/navigation_routes.dart';

class AppointmentConfirmDialog extends StatelessWidget {
  const AppointmentConfirmDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonAppDialog(
      padding: EdgeInsets.zero,
      child: Container(
        width: 600,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 10, right: 10, top: 10),
              child: Row(
                children: [
                  Text(
                    'Appointment information',
                    style: TextStyles.semiBold(18),
                  ),
                  Gap(10),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: AppColors.greenD1FAE5,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text(
                      'Confirmed',
                      style: TextStyles.medium(
                        11,
                        fontColor: AppColors.green059669,
                      ),
                    ),
                  ),
                  Spacer(),
                  TextButton(
                    onPressed: () {
                      NavigatorRoute.navigateBack(context: context);
                    },
                    child: Icon(Icons.close, color: AppColors.greyC3C3C3),
                  ),
                ],
              ),
            ),
            Divider(
              color: AppColors.whiteEBEBEB,
              thickness: 1,
            ),
            Gap(10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Client information',
                    style: TextStyles.medium(
                      13,
                      fontColor: AppColors.black141414,
                    ),
                  ),
                  Gap(10),
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.whiteF8F8F8,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Name',
                                style: TextStyles.medium(
                                  10,
                                  fontColor: AppColors.grey7F878E,
                                ),
                              ),
                              Text(
                                'Nolan Calzoni',
                                style: TextStyles.medium(
                                  13,
                                  fontColor: AppColors.black141414,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Email',
                                style: TextStyles.medium(
                                  10,
                                  fontColor: AppColors.grey7F878E,
                                ),
                              ),
                              Text(
                                'name@email.com',
                                style: TextStyles.medium(
                                  13,
                                  fontColor: AppColors.black141414,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Phone Number',
                                style: TextStyles.medium(
                                  10,
                                  fontColor: AppColors.grey7F878E,
                                ),
                              ),
                              Text(
                                '(+1) 703-555-5678',
                                style: TextStyles.medium(
                                  13,
                                  fontColor: AppColors.black141414,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Gap(20),
                  Text(
                    'Property Information',
                    style: TextStyles.medium(
                      13,
                      fontColor: AppColors.black141414,
                    ),
                  ),
                  Gap(10),
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.whiteF8F8F8,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Address',
                          style: TextStyles.medium(
                            10,
                            fontColor: AppColors.grey7F878E,
                          ),
                        ),
                        Text(
                          'Lincoln Drive, Harrisburg, PA 17101 U.S.A',
                          style: TextStyles.medium(
                            13,
                            fontColor: AppColors.black141414,
                          ),
                        ),
                        Gap(20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Property Type',
                                    style: TextStyles.medium(
                                      10,
                                      fontColor: AppColors.grey7F878E,
                                    ),
                                  ),
                                  Text(
                                    'House',
                                    style: TextStyles.medium(
                                      13,
                                      fontColor: AppColors.black141414,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Listing Price',
                                    style: TextStyles.medium(
                                      10,
                                      fontColor: AppColors.grey7F878E,
                                    ),
                                  ),
                                  Text(
                                    '\$450,000',
                                    style: TextStyles.medium(
                                      13,
                                      fontColor: AppColors.black141414,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'MLS Number',
                                    style: TextStyles.medium(
                                      10,
                                      fontColor: AppColors.grey7F878E,
                                    ),
                                  ),
                                  Text(
                                    '#MLS123456',
                                    style: TextStyles.medium(
                                      13,
                                      fontColor: AppColors.black141414,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Gap(15),
                        CommonButton(
                          onPressed: () {},
                          child: Text(
                            'View on Map',
                            style: TextStyles.medium(
                              12,
                              fontColor: AppColors.whiteFFFFFF,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Gap(20),
                  Text(
                    'Appointment Summary',
                    style: TextStyles.medium(
                      13,
                      fontColor: AppColors.black141414,
                    ),
                  ),
                  Gap(10),
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.whiteF8F8F8,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Date & Time',
                          style: TextStyles.medium(
                            10,
                            fontColor: AppColors.grey7F878E,
                          ),
                        ),
                        Text(
                          '${DateFormat('MMMM d, y - h:mm a').format(DateTime.now())}',
                          style: TextStyles.medium(
                            13,
                            fontColor: AppColors.black141414,
                          ),
                        ),
                        Gap(15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Agent Assigned',
                                    style: TextStyles.medium(
                                      10,
                                      fontColor: AppColors.grey7F878E,
                                    ),
                                  ),
                                  Text(
                                    'Sarah Johnson',
                                    style: TextStyles.medium(
                                      13,
                                      fontColor: AppColors.black141414,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Showing Instructions',
                                    style: TextStyles.medium(
                                      10,
                                      fontColor: AppColors.grey7F878E,
                                    ),
                                  ),
                                  Text(
                                    '\$450,000',
                                    style: TextStyles.medium(
                                      13,
                                      fontColor: AppColors.black141414,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Gap(15),
                        Text(
                          'Additional Notes',
                          style: TextStyles.medium(
                            10,
                            fontColor: AppColors.grey7F878E,
                          ),
                        ),
                        Text(
                          'Client interested in viewing the basement renovation details.',
                          style: TextStyles.medium(
                            13,
                            fontColor: AppColors.black141414,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Gap(20),
                  Text(
                    'Did the client like the property?',
                    style: TextStyles.medium(
                      13,
                      fontColor: AppColors.black141414,
                    ),
                  ),
                  Gap(12),
                  Row(
                    children: [
                      CommonButton(
                        onPressed: () {},
                        buttonColor: AppColors.whiteFFFFFF,
                        borderColor: AppColors.whiteE1E1E1,
                        child: Text(
                          'Yes',
                          style: TextStyles.medium(
                            13,
                            fontColor: AppColors.black141414,
                          ),
                        ),
                      ),
                      Gap(10),
                      CommonButton(
                        onPressed: () {},
                        buttonColor: AppColors.whiteFFFFFF,
                        borderColor: AppColors.whiteE1E1E1,
                        child: Text(
                          'No',
                          style: TextStyles.medium(
                            13,
                            fontColor: AppColors.black141414,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Gap(10),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
