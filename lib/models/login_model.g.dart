// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginRequest _$LoginRequestFromJson(Map<String, dynamic> json) => LoginRequest(
      comCd: json['comCd'] as String,
      userId: json['userId'] as String,
      password: json['password'] as String,
    );

Map<String, dynamic> _$LoginRequestToJson(LoginRequest instance) =>
    <String, dynamic>{
      'comCd': instance.comCd,
      'userId': instance.userId,
      'password': instance.password,
    };

LoginResponse _$LoginResponseFromJson(Map<String, dynamic> json) =>
    LoginResponse(
      token: json['token'] as String,
      refreshToken: json['refreshToken'] as String,
      userInfo: UserInfo.fromJson(json['userInfo'] as Map<String, dynamic>),
      success: json['success'] as bool,
      message: json['message'] as String?,
    );

Map<String, dynamic> _$LoginResponseToJson(LoginResponse instance) =>
    <String, dynamic>{
      'token': instance.token,
      'refreshToken': instance.refreshToken,
      'userInfo': instance.userInfo,
      'success': instance.success,
      'message': instance.message,
    };

UserInfo _$UserInfoFromJson(Map<String, dynamic> json) => UserInfo(
      userId: json['userId'] as String,
      userName: json['userName'] as String,
      comCd: json['comCd'] as String,
      comName: json['comName'] as String,
      roles: (json['roles'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$UserInfoToJson(UserInfo instance) => <String, dynamic>{
      'userId': instance.userId,
      'userName': instance.userName,
      'comCd': instance.comCd,
      'comName': instance.comName,
      'roles': instance.roles,
    };
