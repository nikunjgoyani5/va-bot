import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';

class NavigatorRoute {
  static navigateTo(
    BuildContext context, {
    required String page,
    dynamic arguments,
  }) async {
    context.go(page, extra: arguments);
  }

  static navigateBack({required BuildContext context}) async {
    context.pop();
  }

  static replace(BuildContext context, {required String page}) async {
    context.replace(page);
  }
}
