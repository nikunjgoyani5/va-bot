import 'package:va_bot_admin/services/pref_service.dart';
import 'package:va_bot_admin/core/theme/app_theme.dart';
import 'package:va_bot_admin/data/api_end_points.dart';
import 'package:va_bot_admin/routes/app_routes.dart';
import 'package:toastification/toastification.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await ApiEndPoint.init();
  await PrefService.init();
  runApp(const VaBotAdmin());
}

class VaBotAdmin extends StatelessWidget {
  const VaBotAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (BuildContext, Orientation, ScreenType) {
        return ToastificationWrapper(
          child: GetMaterialApp.router(
            debugShowCheckedModeBanner: false,
            routerDelegate: AppRoutes.router.routerDelegate,
            routeInformationParser: AppRoutes.router.routeInformationParser,
            routeInformationProvider: AppRoutes.router.routeInformationProvider,
            theme: lightTheme,
            themeMode: ThemeMode.light,
            darkTheme: darkTheme,
          ),
        );
      },
    );
  }
}
