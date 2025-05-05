import 'package:flutter/material.dart';

class CommonAppbar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? leading;
  final Widget? title;
  final List<Widget>? actions;
  final bool automaticallyImplyLeading;
  final Color? backgroundColor;
  final bool? centerTitle;
  const CommonAppbar({
    super.key,
    this.leading,
    this.title,
    this.actions,
    this.automaticallyImplyLeading = false,
    this.backgroundColor,
    this.centerTitle,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: leading,
      title: title,
      actions: actions,
      automaticallyImplyLeading: automaticallyImplyLeading,
      backgroundColor: backgroundColor,
      centerTitle: centerTitle,
      scrolledUnderElevation: 0,
    );
  }

  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
