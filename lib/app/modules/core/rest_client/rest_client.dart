import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:hello_pokemon/app/modules/core/configuration/config_enviroment.dart';

class RestClient extends DioForNative {
  RestClient()
    : super(
        BaseOptions(
          baseUrl: ConfigEnviroment.apirUrl,
          connectTimeout: const Duration(seconds: 10),
          receiveTimeout: const Duration(seconds: 10),
        ),
      ) {
    interceptors.addAll([
      LogInterceptor(requestBody: true, responseBody: true),
    ]);
  }
}
