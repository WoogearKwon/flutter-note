import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

import 'exports.dart';

part 'route_mapping.dart';

void main() async {
  Logger.init();
  await Injector.init();
  AppNavigator.init(_routeMapping);

  runApp(const Application());
}
