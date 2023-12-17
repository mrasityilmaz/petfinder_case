part of '../rest_api_package.dart';

final class RestApiHttpService {
  ///! Make sure base url ends with /
  ///So you can call your API like in the examples.
  RestApiHttpService(
    this.dio,
    this.cookieJar,
    this.baseUrl,
  ) {
    //log('Cookie interceptor adding');
    if (!kIsWeb) dio.interceptors.add(CookieManager(cookieJar));
    //log('Cookie interceptor added');
  }
  Map<String, String> publicHeaders = <String, String>{};
  Dio dio;
  final CookieJar cookieJar;

  ///! Make sure base url ends with /
  ///So you can call your API like in the examples.
  final String baseUrl;

  Future<Options> prepareOptions({String? bearerToken, Map<String, String>? header}) async {
    final headers = <String, String>{};

    if (header != null) {
      for (final element in header.entries) {
        headers.update(element.key, (value) => element.value, ifAbsent: () => element.value);
      }
    }

    if (headers.containsKey(HttpHeaders.contentTypeHeader) != true) {
      headers.putIfAbsent(HttpHeaders.contentTypeHeader, () => 'application/json');
    }
    //headers.putIfAbsent(HttpHeaders.acceptHeader, () => 'application/json');

    if (bearerToken != null) {
      headers.putIfAbsent(HttpHeaders.authorizationHeader, () => 'Bearer $bearerToken');
    }
    return Options(
      headers: headers,
      followRedirects: false,
      validateStatus: (status) {
        return (status ?? 501) <= 500;
      },
    );
  }

  Future<T> requestAndHandle<T>(
    IRestApiRequest apiRequest, {
    required T Function(Map<String, dynamic> json) parseModel,
    bool removeBaseUrl = false,
    bool isRawJson = false,
  }) async {
    final response = await request(apiRequest, removeBaseUrl: removeBaseUrl);
    return handleResponse<T>(response, parseModel: parseModel, isRawJson: isRawJson);
  }

  Future<List<T>> requestAndHandleList<T>(
    IRestApiRequest apiRequest, {
    required T Function(Map<String, dynamic> json) parseModel,
    bool removeBaseUrl = false,
    bool isRawJson = false,
  }) async {
    final response = await request(apiRequest, removeBaseUrl: removeBaseUrl);
    return handleResponseList<T>(
      response,
      parseModel: parseModel,
      isRawJson: isRawJson,
    );
  }

  Future<Response> request(IRestApiRequest apiRequest, {bool removeBaseUrl = false}) async {
    Response resp;

    var url = baseUrl + apiRequest.endPoint;

    if (apiRequest.baseUrl.isNotEmpty) {
      url = apiRequest.baseUrl + apiRequest.endPoint;
    }

    final options = await prepareOptions(
      bearerToken: apiRequest.bearerToken,
    );

    try {
      switch (apiRequest.requestMethod) {
        case RequestMethod.GET:
          resp = await dio.get(
            url,
            options: options,
            queryParameters: apiRequest.queryParameters,
          );
        case RequestMethod.PUT:
          resp = await dio.put(
            url,
            options: options,
            data: apiRequest.body,
            queryParameters: apiRequest.queryParameters,
          );
        case RequestMethod.POST:
          resp = await dio.post(
            url,
            options: options,
            data: apiRequest.body,
            queryParameters: apiRequest.queryParameters,
          );
        case RequestMethod.DELETE:
          resp = await dio.delete(
            url,
            options: options,
            queryParameters: apiRequest.queryParameters,
            data: apiRequest.body,
          );

        case RequestMethod.PATCH:
          resp = await dio.patch(
            url,
            options: options,
            queryParameters: apiRequest.queryParameters,
            data: apiRequest.body,
          );
        default:
          throw Exception("Error this request's method is undefined");
      }
    } on DioException catch (e) {
      if (e.response != null) {
        return e.response!;
      }
      throw Exception('DIO Error: $e');
    }
    return resp;
  }

  Future<T> requestFormAndHandle<T>(
    IRestApiRequest apiRequest, {
    required dynamic parseModel,
    bool isRawJson = false,
  }) async {
    final response = await requestForm(apiRequest);
    return handleResponse<T>(response, parseModel: parseModel, isRawJson: isRawJson);
  }

  Future<List<T>> requestFormAndHandleList<T>(
    IRestApiRequest apiRequest, {
    required dynamic parseModel,
    bool isRawJson = false,
  }) async {
    final response = await requestForm(apiRequest);
    return handleResponseList<T>(response, parseModel: parseModel, isRawJson: isRawJson);
  }

  Future<Response> requestForm(
    IRestApiRequest apiRequest,
  ) async {
    Response resp;
    final url = baseUrl + apiRequest.endPoint;

    final options = await prepareOptions(bearerToken: apiRequest.bearerToken);

    final formData = FormData();

    apiRequest.body.forEach((key, value) {
      formData.fields.add(MapEntry(key, value));
    });

    try {
      if (apiRequest.requestMethod == RequestMethod.GET) {
        resp = await dio.get(
          url,
          options: options,
          queryParameters: apiRequest.queryParameters,
        );
      } else if (apiRequest.requestMethod == RequestMethod.PUT) {
        resp = await dio.put(
          url,
          options: options,
          data: formData,
          queryParameters: apiRequest.queryParameters,
        );
      } else if (apiRequest.requestMethod == RequestMethod.POST) {
        resp = await dio.post(
          url,
          options: options,
          data: formData,
          queryParameters: apiRequest.queryParameters,
        );
      } else {
        throw Exception("Error this request's method is undefined");
      }
    } on DioException catch (e) {
      if (e.response != null) {
        return e.response!;
      }
      throw Exception('DIO Error: $e');
    }
    return resp;
  }

  Future<Response> requestFile(
    IRestApiRequest apiRequest, {
    required String fileFieldName,
    File? file,
    Uint8List? fileBytes,
    String? fileName,
    Function(int, int)? onSendProgress,
  }) async {
    if (fileBytes != null && file != null) {
      throw Exception('Filebytes and File can not be null.');
    }
    Response resp;
    final url = baseUrl + apiRequest.endPoint;

    final options = await prepareOptions(bearerToken: apiRequest.bearerToken);

    final mfile = MultipartFile.fromBytes(
      file != null ? file.readAsBytesSync() : fileBytes!,
      filename: file != null ? file.path.split('/').last : fileName,
    );
    final formData = FormData();

    formData.files.add(MapEntry(fileFieldName, mfile));

    apiRequest.body.forEach((key, value) {
      formData.fields.add(MapEntry(key, value.toString()));
    });

    try {
      if (apiRequest.requestMethod == RequestMethod.PUT) {
        resp = await Dio().put(
          url,
          options: options,
          data: formData,
          queryParameters: apiRequest.queryParameters,
        );
      } else if (apiRequest.requestMethod == RequestMethod.POST) {
        resp = await Dio().post(
          url,
          options: options,
          data: formData,
          queryParameters: apiRequest.queryParameters,
          onSendProgress: onSendProgress,
        );
      } else {
        throw Exception("Error this request's method is undefined");
      }
    } on DioException catch (e) {
      if (e.response != null) {
        return e.response!;
      }
      throw Exception('DIO Error: $e');
    }
    return resp;
  }

  T handleResponse<T>(Response response, {required T Function(Map<String, dynamic> json) parseModel, required bool isRawJson}) {
    if (response.statusCode == 200 || response.statusCode == 201) {
      try {
        final data = response.data;
        T result;
        if (isRawJson) {
          result = parseModel(json.decode(data));
        } else {
          result = parseModel(data);
        }
        return result;
      } catch (e) {
        throw response;
      }
    } else {
      throw response;
    }
  }

  List<T> handleResponseList<T>(Response response, {required T Function(Map<String, dynamic> json) parseModel, required bool isRawJson}) {
    if (response.statusCode == 200 || response.statusCode == 201) {
      try {
        final data = response.data;
        //log('Response data: $data');
        if (isRawJson) {
          final list = json.decode(data) as List;
          return List<T>.from(list.map((x) => parseModel(x)));
        }
        return List<T>.from(data.map((x) => parseModel(x)));
      } catch (e) {
        log('Error: $e');
        return [];
      }
    } else {
      return [];
    }
  }
}
