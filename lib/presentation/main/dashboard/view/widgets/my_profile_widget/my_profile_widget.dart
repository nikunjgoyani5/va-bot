import 'package:animated_tree_view/tree_view/tree_view.dart';
import 'package:animated_tree_view/tree_view/widgets/expansion_indicator.dart';
import 'package:animated_tree_view/tree_view/widgets/indent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:va_bot_admin/core/theme/colors.dart';
import 'package:va_bot_admin/core/theme/text_styles.dart';
import 'package:va_bot_admin/core/utils/common_widgets/common_dialog.dart';
import 'package:va_bot_admin/core/utils/common_widgets/vertical_tabbar.dart';
import 'package:va_bot_admin/gen/assets.gen.dart';
import 'package:va_bot_admin/presentation/main/dashboard/controller/dashboard_controller.dart';
import 'package:va_bot_admin/presentation/main/dashboard/view/widgets/my_profile_widget/widget/my_profile/my_profile.dart';
import 'package:va_bot_admin/presentation/main/dashboard/view/widgets/my_profile_widget/widget/notification/notification.dart';
import 'package:va_bot_admin/presentation/main/dashboard/view/widgets/my_profile_widget/widget/privacy_policy/privacy_policy.dart';
import 'package:va_bot_admin/presentation/main/dashboard/view/widgets/my_profile_widget/widget/professional/professional.dart';
import 'package:va_bot_admin/presentation/main/dashboard/view/widgets/my_profile_widget/widget/security/security.dart';
import 'package:va_bot_admin/routes/app_routes.dart';
import 'package:va_bot_admin/routes/navigation_routes.dart';

class MyProfileDialog extends StatelessWidget {
  const MyProfileDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonAppDialog(
      padding: EdgeInsets.symmetric(horizontal: 0.5.w, vertical: 1.h),
      child: GetBuilder<DashboardScreenController>(builder: (controller) {
        return Container(
          height: 650,
          width: 800,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    controller.selectedProfileTab,
                    style: TextStyles.semiBold(
                      18,
                      fontColor: AppColors.black141414,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      NavigatorRoute.navigateBack(context: context);
                    },
                    icon: Icon(
                      Icons.close,
                      color: AppColors.greyC3C3C3,
                    ),
                  ),
                ],
              ),
              Divider(
                color: AppColors.whiteF0F0F0,
                thickness: 1,
              ),
              Expanded(
                child: VerticalTabView(
                  isShowBGColor: (controller.myProfileCurrentIndex != 2),
                  tabsWidth: 16.w,
                  initialIndex: controller.myProfileCurrentIndex,
                  tabs: List.generate(
                    controller.myProfileSideBarMenu.length,
                    (index) {
                      Map<String, dynamic> data =
                          controller.myProfileSideBarMenu[index];
                      return Tab(
                        child: (index != 2)
                            ? Container(
                                height: 5.h,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Gap(1.5.w),
                                    SvgPicture.asset(
                                      data['image'],
                                      height: 18,
                                      width: 18,
                                      colorFilter: ColorFilter.mode(
                                        (controller.myProfileCurrentIndex ==
                                                index)
                                            ? AppColors.primaryColor
                                            : (index == 5)
                                                ? AppColors.redEF4444
                                                : AppColors.grey5D5D5D,
                                        BlendMode.srcIn,
                                      ),
                                    ),
                                    Gap(1.w),
                                    Text(
                                      data['title'],
                                      style: TextStyles.medium(
                                        12,
                                        fontColor:
                                            (controller.myProfileCurrentIndex ==
                                                    index)
                                                ? AppColors.black141414
                                                : (index == 5)
                                                    ? AppColors.redEF4444
                                                    : AppColors.grey5D5D5D,
                                      ),
                                    )
                                  ],
                                ),
                              )
                            : TreeView.simple(
                                shrinkWrap: true,
                                tree: controller.sampleTree,
                                showRootNode: true,
                                expansionIndicatorBuilder: (context, node) =>
                                    ChevronIndicator.upDown(
                                  tree: node,
                                  color: AppColors.black141414,
                                  padding: EdgeInsets.only(top: 5),
                                ),
                                indentation: Indentation(
                                  style: IndentStyle.squareJoint,
                                ),
                                onItemTap: (item) {
                                  controller.myProfileCurrentIndex = 2;
                                  controller.myProfilePageController
                                      .jumpToPage(2);
                                  if (item.key == '0') {
                                    controller.securityPageController
                                        .jumpToPage(0);
                                    controller.selectedTreeIndex = 0;
                                  } else if (item.key == '1') {
                                    controller.securityPageController
                                        .jumpToPage(1);
                                    controller.selectedTreeIndex = 1;
                                  } else if (item.key == '2') {
                                    controller.securityPageController
                                        .jumpToPage(2);
                                    controller.selectedTreeIndex = 2;
                                  }
                                  controller.update();
                                },
                                onTreeReady: (tController) {
                                  controller.treeController = tController;
                                },
                                builder: (context, node) {
                                  return Container(
                                    height: 5.h,
                                    decoration: BoxDecoration(
                                      color: (controller.selectedTreeIndex ==
                                              int.tryParse(node.key))
                                          ? AppColors.primaryColor
                                              .withValues(alpha: 0.1)
                                          : AppColors.transparent,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Gap(1.5.w),
                                        SvgPicture.asset(
                                          node.key == '/'
                                              ? data['image']
                                              : node.key == '0'
                                                  ? Assets.icons.icSecurity.path
                                                  : node.key == '1'
                                                      ? Assets.icons
                                                          .icMultiFactor.path
                                                      : Assets
                                                          .icons
                                                          .icAccountRecovery
                                                          .path,
                                          height: 18,
                                          width: 18,
                                          colorFilter: ColorFilter.mode(
                                            (controller.selectedTreeIndex ==
                                                    int.tryParse(node.key))
                                                ? AppColors.primaryColor
                                                : AppColors.grey5D5D5D,
                                            BlendMode.srcIn,
                                          ),
                                        ),
                                        Gap(1.w),
                                        Text(
                                          node.key == '/'
                                              ? data['title']
                                              : node.key == '0'
                                                  ? 'Forgot password'
                                                  : node.key == '1'
                                                      ? 'Multi Factor'
                                                      : 'Account Recovery',
                                          style: TextStyles.medium(
                                            12,
                                            fontColor: (controller
                                                        .myProfileCurrentIndex ==
                                                    index)
                                                ? AppColors.black141414
                                                : AppColors.grey5D5D5D,
                                          ),
                                        )
                                      ],
                                    ),
                                  );
                                },
                              ),
                      );
                    },
                  ),
                  onSelect: (int index) {
                    if (controller.treeController?.tree.isExpanded ?? false) {
                      controller.treeController
                          ?.collapseNode(controller.sampleTree);
                    }
                    if (controller.selectedTreeIndex != 0) {
                      controller.selectedTreeIndex = 0;
                    }
                    if (index != 5) {
                      controller.myProfileCurrentIndex = index;
                      controller.myProfilePageController
                          .jumpToPage(controller.myProfileCurrentIndex);
                      controller.selectedProfileTab =
                          controller.myProfileSideBarMenu[index]['title'];
                    } else {
                      NavigatorRoute.replace(context, page: AppRoutes.login);
                    }
                    controller.update();
                  },
                  unSelectedTabBackgroundColor: AppColors.whiteFFFFFF,
                  selectedTabBackgroundColor:
                      AppColors.primaryColor.withValues(alpha: 0.1),
                  pageController: controller.myProfilePageController,
                  isShowFullMenu: true,
                  contents: [
                    MyProfileWidget(),
                    ProfessionalTab(),
                    SecurityTab(),
                    NotificationTab(),
                    PrivacyPolicyTab(),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
