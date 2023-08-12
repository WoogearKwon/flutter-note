import 'package:flutter/material.dart';

import 'package:fluro/fluro.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_note/exports.dart';

class Application extends StatefulWidget {
  const Application({super.key});

  @override
  State<Application> createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return _InheritedApplication(
      state: this,
      child: MaterialApp(
        // localizationsDelegates: const [
        //   S.delegate,
        //   GlobalMaterialLocalizations.delegate,
        //   GlobalCupertinoLocalizations.delegate,
        //   GlobalWidgetsLocalizations.delegate,
        // ],
        // supportedLocales: S.delegate.supportedLocales,
        // theme: AppTheme.appTheme,
        themeMode: ThemeMode.light,
        onGenerateRoute: AppNavigator.routeGenerator,
        initialRoute: AppPath.main,
        navigatorKey: _navigatorKey,
        builder: (context, child) => MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
          child: child!,
        ),
      ),
    );
  }
}

class _InheritedApplication extends InheritedWidget {
  final _ApplicationState state;

  const _InheritedApplication({
    Key? key,
    required this.state,
    required Widget child,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(_InheritedApplication old) {
    return old.state != state;
  }
}
