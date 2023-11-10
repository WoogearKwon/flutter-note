part of 'network_data_source_impl.dart';

class _ApiInterceptor extends QueuedInterceptorsWrapper {
  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    options.headers['Accept-Version'] = 'v1';
    options.headers['Authorization'] = _accessKey;

    handler.next(options);
  }
}
