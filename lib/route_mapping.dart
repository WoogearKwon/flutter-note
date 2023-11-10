part of 'main.dart';

Map<String, Handler> get _routeMapping => <String, Handler>{
      AppPath.main: _mainHandler,
      AppPath.unsplash: _unsplash,
    };

final _mainHandler = Handler(
  handlerFunc: (context, params) {
    return const MainScreen();
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
