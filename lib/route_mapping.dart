part of 'main.dart';

extension _ContextArgumentExtension on BuildContext? {
  T getScreenArgument<T>() {
    assert(this?.settings?.arguments != null);
    return this!.settings!.arguments as T;
  }
}

Map<String, Handler> get _routeMapping => <String, Handler>{
      AppPath.main: _mainHandler,
      AppPath.catalogs: _catalogsHandler,
      AppPath.unsplash: _unsplash,
      AppPath.customChart: _customChart,
      AppPath.notificationCenter: _notificationCenter,
    };

final _mainHandler = Handler(
  handlerFunc: (context, params) {
    return HomeScreen(
      args: HomeScreenArgs(catalogs: ScreenProvider.catalogs),
    );
  },
);

final _catalogsHandler = Handler(
  handlerFunc: (context, params) {
    final CatalogScreenArgs args = context.getScreenArgument();
    return CatalogScreen(args: args);
  },
);

final _customChart = Handler(
  handlerFunc: (context, params) {
    return const CustomChartScreen();
  },
);

final _unsplash = Handler(
  handlerFunc: (context, params) {
    return ChangeNotifierProvider(
        create: (context) =>
            UnsplashPhotosViewModel(unsplashRepository: Injector.find()),
        child: const UnsplashPhotosScreen());
  },
);

final _notificationCenter = Handler(
  handlerFunc: (context, params) {
    return const NotificationCenterScreen();
  },
);