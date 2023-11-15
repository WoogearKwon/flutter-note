import 'package:flutter/cupertino.dart';
import 'package:flutter_note/exports.dart';

class UnsplashPhotosViewModel extends ChangeNotifier {
  final UnsplashRepository unsplashRepository;

  List<UnsplashPhoto> photos = [];

  UnsplashPhotosViewModel({required this.unsplashRepository}) {
    getPhotos();
  }

  getPhotos() async {
    try {
      photos = await unsplashRepository.getPhotos();
      notifyListeners();
    } on DomainError catch (error) {
      Logger.e('[unsplash:photos] :: $error => ${error.cause}');
    } catch (error, stack) {
      Logger.e('[unsplash:photos] :: $error => $stack');
      rethrow;
    }
  }
}
