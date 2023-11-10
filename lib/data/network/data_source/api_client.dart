part of 'network_data_source_impl.dart';

class _ApiClient extends DioForNative {
  static const int _connectTimeout = 15000;
  static const int _receiveTimeout = 15000;

  _ApiClient() : super() {
    options.baseUrl = "https://api.unsplash.com/";
    options.connectTimeout = const Duration(milliseconds: _connectTimeout);
    options.receiveTimeout = const Duration(milliseconds: _receiveTimeout);
    options.validateStatus = (statusCode) => statusCode == 200;

    interceptors.addAll([
      _ApiInterceptor(),
      if (kDebugMode)
        PrettyDioLogger(
          request: true,
          requestHeader: true,
          requestBody: true,
          responseHeader: true,
          responseBody: true,
          error: true,
          compact: true,
        ),
    ]);
  }
}
