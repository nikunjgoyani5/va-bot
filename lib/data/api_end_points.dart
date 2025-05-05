import 'package:va_bot_admin/core/constant/app_constant.dart';
import 'package:logic_go_network/network/api_type.dart';
import 'package:logic_go_network/network.dart';

class ApiEndPoint {
  /// AUTH - END POINTS
  static const String signIn = 'auth/login-by-email';
  static const String signUp = 'auth/register-by-email';
  static const String forgotPassword = 'auth/forgot-password';
  static const String verifyOTP = 'auth/verify-email-otp';
  static const String resetPassword = 'auth/reset-password';
  static const String googleAuth = 'auth/google-auth';

  static Future<void> init() async {
    restClient = await RestClient(
      baseUrl: baseUrl,
      token: token,
      connectionTO: 30000,
      receiveTO: 30000,
    );
  }
}

Map<String, String> requestHeader(APIType apiType, {bool? passRefreshToken}) {
  return {
    // if (apiType == APIType.protected)
    //   RequestHeaderKey.authorization:
    //       "Bearer ${PrefService.getString(PrefService.accessToken)}",
  };
}
