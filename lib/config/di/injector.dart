import 'dart:async';

import 'package:flutter_note/exports.dart';
import 'package:get_it/get_it.dart';

class Injector {
  const Injector._();

  static GetIt get _instance => GetIt.instance;

  static T find<T extends Object>() {
    return _instance.get<T>();
  }

  static Future<void> init() async {
    _instance.registerSingleton<NetworkDataSource>(NetworkDataSourceImpl());

    _instance.registerSingleton<UnsplashRepository>(
        UnsplashRepositoryImpl(networkDataSource: Injector.find()));
  }
}
