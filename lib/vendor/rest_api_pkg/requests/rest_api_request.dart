import 'package:dio/dio.dart';

export 'package:dio/dio.dart';

enum RequestMethod {
  GET,
  POST,
  PUT,
  PATCH,
  DELETE,
}

abstract class IRestApiRequest {
  String baseUrl = '';
  String endPoint = "/";
  bool authorize = false;
  Map<String, dynamic> queryParameters = {};
  Map<String, dynamic> body = {};
  Map<String, dynamic> headers = {};

  RequestMethod requestMethod = RequestMethod.GET;
  String? bearerToken;

  Future<void> handleRequest(Response response) async {}
}

class RestApiRequest extends IRestApiRequest {
  RestApiRequest({
    String endPoint = "/",
    String? bearerToken,
    Map<String, dynamic> body = const {},
    Map<String, dynamic> queryParameters = const {},
    Map<String, dynamic> headers = const {},
    RequestMethod requestMethod = RequestMethod.GET,
  }) {
    this.endPoint = endPoint;
    this.bearerToken = bearerToken;
    this.body = body;
    this.queryParameters = queryParameters;
    this.requestMethod = requestMethod;
    this.headers = headers;
  }
}
