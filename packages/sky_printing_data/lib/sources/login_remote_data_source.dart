import 'package:dartz/dartz.dart';
import 'package:sky_printing_core/sky_printing_core.dart';
import 'package:sky_printing_data/sky_printing_data.dart';
import 'package:sky_printing_domain/sky_printing_domain.dart';

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