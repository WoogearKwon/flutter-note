import 'package:async/async.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter_note/exports.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

part 'api_client.dart';

part 'api_interceptor.dart';

class NetworkDataSourceImpl extends NetworkDataSource {
  final _ApiClient _client;

  NetworkDataSourceImpl() : _client = _ApiClient();

  @override
  Future<List<NetworkUnsplashPhoto>> getUnsplashPhotos() async {
    final response = await _client.get('/photos');
    final photos = (response.data as List)
        .map((e) => NetworkUnsplashPhoto.fromJson(e))
        .toList(growable: false);

    return photos;

    try {
      // final response = await _client.get('/photos');
      // final photos = (response.data as List)
      //     .map((e) => NetworkUnsplashPhoto.fromJson(e))
      //     .toList(growable: false);
      //
      // return photos;
    } on DioException catch (e) {

    } catch (e) {

    }
  }
}
