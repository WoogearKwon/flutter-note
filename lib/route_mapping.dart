part of 'main.dart';

Map<String, Handler> get _routeMapping => <String, Handler>{
  AppPath.main: _mainHandler,
};

final _mainHandler = Handler(
  handlerFunc: (context, params) {
    return const MainScreen();
  },
);