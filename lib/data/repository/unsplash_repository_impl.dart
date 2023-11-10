import 'package:flutter_note/exports.dart';

class UnsplashRepositoryImpl extends UnsplashRepository {
  final NetworkDataSource networkDataSource;


  UnsplashRepositoryImpl({required this.networkDataSource});

  @override
  Future<List<UnsplashPhoto>> getPhotos() async {
    final networkPhotos = await networkDataSource.getUnsplashPhotos();
    return networkPhotos.map((e) => e.asDomainModel()).toList();
  }
}