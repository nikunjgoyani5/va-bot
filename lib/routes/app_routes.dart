import 'package:va_bot_admin/presentation/authentication/create_new_pass_screen/view/create_new_pass_screen.dart';
import 'package:va_bot_admin/presentation/authentication/forgot_pass_screen/view/forgot_pass_screen.dart';
import 'package:va_bot_admin/presentation/authentication/login_screen/controller/login_controller.dart';
import 'package:va_bot_admin/presentation/main/dashboard/controller/dashboard_controller.dart';
import 'package:va_bot_admin/presentation/onboard/onboard_screen/controller/onboard_controller.dart';
import 'package:va_bot_admin/presentation/authentication/sign_up_screen/view/signup_screen.dart';
import 'package:va_bot_admin/presentation/authentication/otp_screen/view/otp_screen.dart';
import 'package:va_bot_admin/presentation/onboard/onboard_screen/view/onboard_screen.dart';
import 'package:va_bot_admin/presentation/onboard/welcome_screen/view/welcome_screen.dart';
import 'package:va_bot_admin/presentation/main/dashboard/view/dashboard_screen.dart';
import '../presentation/authentication/login_screen/view/login_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:get/get.dart';

class AppRoutes {
  static const String welcome = '/';
  static const String onBoarding = '/onBoarding';
  static const String login = '/login';
  static const String signUp = '/signup';
  static const String otp = '/otp';
  static const String forgotPassword = '/forgotPassword';
  static const String createNewPass = '/createNewPass';
  static const String dashboard = '/dashboard';

  static final GoRouter router = GoRouter(
    initialLocation: welcome,
    routes: [
      GoRoute(
        path: welcome,
        builder: (context, state) => WelcomeScreen(),
      ),
      GoRoute(
        path: onBoarding,
        builder: (context, state) => OnBoardScreen(),
        onExit: (context, state) {
          Get.delete<OnBoardController>();
          return true;
        },
      ),
      GoRoute(
        path: login,
        builder: (context, state) => const LoginScreen(),
        onExit: (context, state) {
          Get.delete<LoginController>();
          return true;
        },
      ),
      GoRoute(
        path: signUp,
        builder: (context, state) => const SignUpScreen(),
      ),
      GoRoute(
        path: otp,
        builder: (context, state) {
          Map<String, dynamic>? argumentData =
              state.extra as Map<String, dynamic>?;
          return OtpScreen(
            email: argumentData?['email'],
            page: argumentData?['page'],
          );
        },
      ),
      GoRoute(
        path: forgotPassword,
        builder: (context, state) => const ForgotPassScreen(),
      ),
      GoRoute(
        path: createNewPass,
        builder: (context, state) {
          Map<String, dynamic>? argumentData =
              state.extra as Map<String, dynamic>?;
          return CreateNewPassScreen(email: argumentData?['email']);
        },
      ),
      GoRoute(
        path: dashboard,
        builder: (context, state) => DashboardScreen(),
        onExit: (context, state) {
          Future.delayed(Duration.zero, () {
            Get.delete<DashboardScreenController>();
          });
          return true;
        },
      ),
    ],
  );
}
