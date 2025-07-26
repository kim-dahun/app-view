import 'package:json_annotation/json_annotation.dart';

part 'login_model.g.dart';

@JsonSerializable()
class LoginRequest {
  final String comCd;
  final String userId;
  final String password;

  LoginRequest({
    required this.comCd,
    required this.userId,
    required this.password,
  });

  Map<String, dynamic> toJson() => _$LoginRequestToJson(this);
}

@JsonSerializable()
class LoginResponse {
  final String token;
  final String refreshToken;
  final UserInfo userInfo;
  final bool success;
  final String? message;

  LoginResponse({
    required this.token,
    required this.refreshToken,
    required this.userInfo,
    required this.success,
    this.message,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);
}

@JsonSerializable()
class UserInfo {
  final String userId;
  final String userName;
  final String comCd;
  final String comName;
  final List<String> roles;

  UserInfo({
    required this.userId,
    required this.userName,
    required this.comCd,
    required this.comName,
    required this.roles,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) =>
      _$UserInfoFromJson(json);
}