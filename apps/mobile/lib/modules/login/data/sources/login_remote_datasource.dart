import 'package:dartz/dartz.dart';
import 'package:sky_printing/core/error/failure.dart';
import 'package:sky_printing/core/services/remote/api/dio_client.dart';
import 'package:sky_printing/core/services/remote/api/list_api.dart';
import 'package:sky_printing/modules/login/data/models/login_response.dart';
import 'package:sky_printing/modules/login/domain/usecases/post_login.dart';

abstract class LoginRemoteDatasource {
  Future<Either<Failure, LoginResponse>> login(LoginParams loginParams);
  Future<Either<Failure, LoginResponse>> me(String token);
}

class LoginRemoteDatasourceImpl implements LoginRemoteDatasource {
  final DioClient _client;

  LoginRemoteDatasourceImpl(this._client);

  @override
  Future<Either<Failure, LoginResponse>> login(LoginParams loginParams) async =>
      await _client.postRequest(
        ListAPI.login,
        data: loginParams.toJson(),
        converter: (response) =>
            LoginResponse.fromJson(response as Map<String, dynamic>),
      );

  @override
  Future<Either<Failure, LoginResponse>> me(String token) async =>
      await _client.postRequest(
        ListAPI.me,
        data: {"token": token},
  
        converter: (response) =>
            LoginResponse.fromJson(response as Map<String, dynamic>),
      );
}