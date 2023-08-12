import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

class AppNavigator {
  const AppNavigator._();

  static final FluroRouter _router = FluroRouter();

  static RouteFactory get routeGenerator => _router.generator;

  static void init(Map<String, Handler> routeMapping) {
    for (final entry in routeMapping.entries) {
      _router.define(entry.key, handler: entry.value);
    }
  }

  static Future<dynamic>? navigateTo(
    BuildContext context,
    String path, {
    bool replace = false,
    bool clearStack = false,
    TransitionType transition = TransitionType.native,
    dynamic arguments,
  }) {
    return _router.navigateTo(
      context,
      path,
      replace: replace,
      clearStack: clearStack,
      maintainState: true,
      rootNavigator: false,
      transition: transition,
      routeSettings: RouteSettings(arguments: arguments),
    );
  }

  static void popIfAvailable<T>(BuildContext context, {T? result}) {
    if (Navigator.canPop(context)) {
      _router.pop(context, result);
    }
  }

  static void popUntil(BuildContext context, String appPath) {
    Navigator.popUntil(context, (route) => route.settings.name == appPath);
  }

  static Future<dynamic> popUntilAndNavigateTo(
    BuildContext context,
    String pathToPop,
    String pathToNavigate, {
    dynamic arguments,
  }) async {
    popUntil(context, pathToPop);
    return await AppNavigator.navigateTo(
      context,
      pathToNavigate,
      arguments: arguments,
    );
  }
}
