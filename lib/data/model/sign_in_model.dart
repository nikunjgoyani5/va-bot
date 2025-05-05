class SignInData {
  String? token;
  SignInUser? signInUser;

  SignInData({
    this.token,
    this.signInUser,
  });

  factory SignInData.fromJson(Map<String, dynamic> json) => SignInData(
        token: json["token"],
        signInUser:
            json["user"] == null ? null : SignInUser.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "user": signInUser?.toJson(),
      };
}

class SignInUser {
  String? id;
  String? email;
  String? password;
  int? mobileNumber;
  String? firstName;
  String? lastName;
  String? fullName;
  String? profileImage;
  String? providerId;
  String? provider;
  String? role;
  String? otp;
  dynamic otpExpiresAt;
  bool? isDeleted;
  bool? isVerified;
  bool? otpVerified;
  String? twilioNumber;
  String? accessToken;
  String? refreshToken;
  dynamic expiresIn;
  bool? isTwoFactorEnabled;
  List<dynamic>? recoveryCode;
  dynamic onboardingUrl;
  bool? isCompleted;
  List<dynamic>? salesforceAccounts;
  DateTime? createdAt;
  DateTime? updatedAt;

  SignInUser({
    this.id,
    this.email,
    this.password,
    this.mobileNumber,
    this.firstName,
    this.lastName,
    this.fullName,
    this.profileImage,
    this.providerId,
    this.provider,
    this.role,
    this.otp,
    this.otpExpiresAt,
    this.isDeleted,
    this.isVerified,
    this.otpVerified,
    this.twilioNumber,
    this.accessToken,
    this.refreshToken,
    this.expiresIn,
    this.isTwoFactorEnabled,
    this.recoveryCode,
    this.onboardingUrl,
    this.isCompleted,
    this.salesforceAccounts,
    this.createdAt,
    this.updatedAt,
  });

  factory SignInUser.fromJson(Map<String, dynamic> json) => SignInUser(
        id: json["_id"],
        email: json["email"],
        password: json["password"],
        mobileNumber: json["mobileNumber"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        fullName: json["fullName"],
        profileImage: json["profileImage"],
        providerId: json["providerId"],
        provider: json["provider"],
        role: json["role"],
        otp: json["otp"],
        otpExpiresAt: json["otpExpiresAt"],
        isDeleted: json["isDeleted"],
        isVerified: json["isVerified"],
        otpVerified: json["otpVerified"],
        twilioNumber: json["twilioNumber"],
        accessToken: json["accessToken"],
        refreshToken: json["refreshToken"],
        expiresIn: json["expiresIn"],
        isTwoFactorEnabled: json["isTwoFactorEnabled"],
        recoveryCode: json["recoveryCode"] == null
            ? []
            : List<dynamic>.from(json["recoveryCode"]!.map((x) => x)),
        onboardingUrl: json["onboardingUrl"],
        isCompleted: json["isCompleted"],
        salesforceAccounts: json["salesforceAccounts"] == null
            ? []
            : List<dynamic>.from(json["salesforceAccounts"]!.map((x) => x)),
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "email": email,
        "password": password,
        "mobileNumber": mobileNumber,
        "firstName": firstName,
        "lastName": lastName,
        "fullName": fullName,
        "profileImage": profileImage,
        "providerId": providerId,
        "provider": provider,
        "role": role,
        "otp": otp,
        "otpExpiresAt": otpExpiresAt,
        "isDeleted": isDeleted,
        "isVerified": isVerified,
        "otpVerified": otpVerified,
        "twilioNumber": twilioNumber,
        "accessToken": accessToken,
        "refreshToken": refreshToken,
        "expiresIn": expiresIn,
        "isTwoFactorEnabled": isTwoFactorEnabled,
        "recoveryCode": recoveryCode == null
            ? []
            : List<dynamic>.from(recoveryCode!.map((x) => x)),
        "onboardingUrl": onboardingUrl,
        "isCompleted": isCompleted,
        "salesforceAccounts": salesforceAccounts == null
            ? []
            : List<dynamic>.from(salesforceAccounts!.map((x) => x)),
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
      };
}
