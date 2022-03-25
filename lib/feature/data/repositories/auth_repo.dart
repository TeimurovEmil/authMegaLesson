import 'package:auth_mega_lesson/feature/data/model/auth_model.dart';
import 'package:dio/dio.dart';
import 'dart:convert';

class AuthRepo {
  AuthRepo({required this.dio});

  late final Dio dio;
  String basicAuth = 'Basic ' + base64Encode(utf8.encode('testEmil:123456'));

  Future<AuthModel> sendNumber({required String phone}) async {
    final result = await dio.get(
      'auth/generateUserId/test?msisdn=996559172405',
      options: Options(
        headers: {
          'Authorization': basicAuth,
        },
      ),
    );

    return AuthModel.fromJson(result.data);
  }

  Future<AuthModel> sendSms({
    required String sms,
    required String token,
  }) async {
    final result = await dio.get(
      'auth/checkCode/test?code=$sms&uuId=$token',
      options: Options(
        headers: {
          'Authorization': basicAuth,
        },
      ),
    );

    return AuthModel.fromJson(result.data);
  }
}
