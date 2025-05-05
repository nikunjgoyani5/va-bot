import 'package:va_bot_admin/core/constant/app_constant.dart';
import 'package:va_bot_admin/data/model/response_model.dart';
import 'package:va_bot_admin/core/constant/app_strings.dart';
import 'package:logic_go_network/network/api_type.dart';
import 'package:va_bot_admin/data/api_end_points.dart';
import 'package:logic_go_network/utils/failure.dart';

class AuthRepository {
  static Future<ResponseModel> loginWithEmail({
    required Map<String, dynamic> data,
  }) async {
    try {
      dynamic response = await restClient.post(
        APIType.protected,
        data,
        path: "$baseUrl/${ApiEndPoint.signIn}",
      );
      return ResponseModel.fromJson((response.data));
    } catch (e) {
      String errorMessage = AppStrings.anErrorOccured;
      if (e is BadRequest) {
        errorMessage = e.error['message'] ?? 'Bad Request';
      } else if (e is InternetNotAvailable) {
        errorMessage = 'Internet Not Available';
      }
      return ResponseModel(message: errorMessage, body: null, status: false);
    }
  }

  static Future<ResponseModel> signUpWithEmail({
    required Map<String, dynamic> data,
  }) async {
    try {
      dynamic response = await restClient.post(
        APIType.protected,
        data,
        path: "$baseUrl/${ApiEndPoint.signUp}",
      );
      return ResponseModel.fromJson((response.data));
    } catch (e) {
      String errorMessage = AppStrings.anErrorOccured;
      if (e is BadRequest) {
        errorMessage = e.error['message'] ?? 'Bad Request';
      } else if (e is InternetNotAvailable) {
        errorMessage = 'Internet Not Available';
      }
      return ResponseModel(message: errorMessage, body: null, status: false);
    }
  }

  static Future<ResponseModel> sendOTP({
    required Map<String, dynamic> data,
  }) async {
    try {
      dynamic response = await restClient.post(
        APIType.protected,
        data,
        path: "$baseUrl/${ApiEndPoint.forgotPassword}",
      );
      return ResponseModel.fromJson((response.data));
    } catch (e) {
      String errorMessage = AppStrings.anErrorOccured;
      if (e is BadRequest) {
        errorMessage = e.error['message'] ?? 'Bad Request';
      } else if (e is InternetNotAvailable) {
        errorMessage = 'Internet Not Available';
      }
      return ResponseModel(message: errorMessage, body: null, status: false);
    }
  }

  static Future<ResponseModel> verifyOTP({
    required Map<String, dynamic> data,
  }) async {
    try {
      dynamic response = await restClient.post(
        APIType.protected,
        data,
        path: "$baseUrl/${ApiEndPoint.verifyOTP}",
      );
      return ResponseModel.fromJson((response.data));
    } catch (e) {
      String errorMessage = AppStrings.anErrorOccured;
      if (e is BadRequest) {
        errorMessage = e.error['message'] ?? 'Bad Request';
      } else if (e is InternetNotAvailable) {
        errorMessage = 'Internet Not Available';
      }
      return ResponseModel(message: errorMessage, body: null, status: false);
    }
  }

  static Future<ResponseModel> resetPassword({
    required Map<String, dynamic> data,
  }) async {
    try {
      dynamic response = await restClient.post(
        APIType.protected,
        data,
        path: "$baseUrl/${ApiEndPoint.resetPassword}",
      );
      return ResponseModel.fromJson((response.data));
    } catch (e) {
      String errorMessage = AppStrings.anErrorOccured;
      if (e is BadRequest) {
        errorMessage = e.error['message'] ?? 'Bad Request';
      } else if (e is InternetNotAvailable) {
        errorMessage = 'Internet Not Available';
      }
      return ResponseModel(message: errorMessage, body: null, status: false);
    }
  }

  static Future<ResponseModel> loginWithGoogle({
    required Map<String, dynamic> data,
  }) async {
    try {
      dynamic response = await restClient.post(
        APIType.protected,
        data,
        path: "$baseUrl/${ApiEndPoint.googleAuth}",
      );
      return ResponseModel.fromJson((response.data));
    } catch (e) {
      String errorMessage = AppStrings.anErrorOccured;
      if (e is BadRequest) {
        errorMessage = e.error['message'] ?? 'Bad Request';
      } else if (e is InternetNotAvailable) {
        errorMessage = 'Internet Not Available';
      }
      return ResponseModel(message: errorMessage, body: null, status: false);
    }
  }
}
