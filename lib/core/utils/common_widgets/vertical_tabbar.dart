import 'package:va_bot_admin/core/constant/app_constant.dart';
import 'package:va_bot_admin/core/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class VerticalTabView extends StatelessWidget {
  final int initialIndex;
  final double tabsWidth;

  final List<Tab> tabs;
  final List<Widget> contents;

  final Color selectedTabBackgroundColor;
  final Color unSelectedTabBackgroundColor;

  final Color tabsShadowColor;
  final double tabsElevation;
  final Function(int tabIndex) onSelect;
  final PageController pageController;
  final bool isShowFullMenu;
  final bool isShowBGColor;

  const VerticalTabView({
    super.key,
    required this.tabs,
    required this.contents,
    this.tabsWidth = 90,
    this.initialIndex = 0,
    this.selectedTabBackgroundColor = const Color.fromARGB(17, 90, 210, 240),
    this.tabsShadowColor = Colors.black54,
    this.tabsElevation = 0.0,
    required this.onSelect,
    required this.unSelectedTabBackgroundColor,
    required this.pageController,
    required this.isShowFullMenu,
    this.isShowBGColor = true,
  });

  // late int _selectedIndex;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: tabsWidth,
          height: double.infinity,
          color: (isDarkTheme(context))
              ? AppColors.black1C1C1C
              : AppColors.whiteFFFFFF,
          child: ListView.builder(
            itemCount: tabs.length,
            itemBuilder: (context, index) {
              Tab tab = tabs[index];

              return Padding(
                padding: EdgeInsets.only(
                  left: 0.5.w,
                  right: 0.5.w,
                  bottom: 0.5.h,
                  top: (index == 7)
                      ? (isShowFullMenu)
                          ? 100
                          : 30.h
                      : 0.h,
                ),
                child: InkWell(
                  onTap: () {
                    onSelect(index);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: (initialIndex == index && isShowBGColor)
                          ? selectedTabBackgroundColor
                          : unSelectedTabBackgroundColor,
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(
                        color: (initialIndex == index && isShowBGColor)
                            ? AppColors.primaryColor.withValues(
                                alpha: (isDarkTheme(context)) ? 0.3 : 0.1)
                            : AppColors.transparent,
                      ),
                    ),
                    child: tab.child,
                  ),
                ),
              );
            },
          ),
        ),
        Expanded(
          child: PageView.builder(
            scrollDirection: Axis.vertical,
            physics: NeverScrollableScrollPhysics(),
            controller: pageController,
            itemCount: contents.length,
            itemBuilder: (BuildContext context, int index) {
              return contents[index];
            },
          ),
        ),
      ],
    );
  }
}
