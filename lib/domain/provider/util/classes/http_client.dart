import 'dart:io';

import 'package:dio/dio.dart';

class HttpClient {
  final Dio _instance;
  final String _defaultErrorMessagePrefix = 'Ocorreu um erro: ';

  BaseOptions get options => _instance.options;

  HttpClient(this._instance);

  Future<dynamic> get(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    dynamic response;
    if (queryParameters != null) {
      response = await _instance.get(path, queryParameters: queryParameters).catchError((e, st) => e, test: (t) => true);
    } else {
      response = await _instance.get(path).catchError((e, st) => e, test: (t) => true);
    }

    response = handleError(response);
    return response;
  }

  Future<dynamic> post(
    String path,
    Map<String, dynamic> json,
  ) async {
    dynamic response;
    try {
      response = await _instance.post(
        path,
        data: json,
        options: Options(
          contentType: ContentType.json.value,
        ),
      );
    } on DioError catch (e) {
      response = e;
    }

    response = handleError(response);
    return response;
  }

  dynamic handleError(response) {
    if(response is DioError) {
      if(response.type == DioErrorType.response) {
        String message = _defaultErrorMessagePrefix + '(' + response.response!.statusCode!.toString() + ') ';
        return message += handleCodes(response.response!.statusCode!);
      }
      return _defaultErrorMessagePrefix + response.message;
    } else if (response.statusCode == HttpStatus.ok) {
      return response.data;
    } else {
      return _defaultErrorMessagePrefix + '(' + response.statusCode + ') ' + response.statusMessage;
    }
  }
  String handleCodes(int code) {
    switch(code) {
      case 401:
        return 'Usuário/Senha Incorretos.';
      default:
        return '.';
    }
  }
}
