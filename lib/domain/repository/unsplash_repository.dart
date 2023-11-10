import 'package:flutter_note/exports.dart';

abstract class UnsplashRepository {

  Future<List<UnsplashPhoto>> getPhotos();
}