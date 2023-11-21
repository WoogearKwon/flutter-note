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
    };

final _mainHandler = Handler(
  handlerFunc: (context, params) {
    return MainScreen(
      args: MainScreenArgs(catalogs: ScreenProvider.catalogs),
    );
  },
);

final _catalogsHandler = Handler(
  handlerFunc: (context, params) {
    final CatalogScreenArgs args = context.getScreenArgument();
    return CatalogScreen(args: args);
  },
);

final _unsplash = Handler(
  handlerFunc: (context, params) {
    // return const UnsplashPhotosScreen();
    return ChangeNotifierProvider(
        create: (context) =>
            UnsplashPhotosViewModel(unsplashRepository: Injector.find()),
        child: const UnsplashPhotosScreen());
  },
);
