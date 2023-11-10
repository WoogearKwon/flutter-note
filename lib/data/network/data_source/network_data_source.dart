
import 'package:flutter_note/exports.dart';

abstract class NetworkDataSource {

  Future<List<NetworkUnsplashPhoto>> getUnsplashPhotos();
}