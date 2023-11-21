
import 'package:flutter_note/exports.dart';

class ScreenProvider {
  const ScreenProvider._();

  static List<AppCatalog> catalogs = [
    AppCatalog(
      title: 'Widget Catalogs',
      description: '',
      type: AppCatalogType.widget,
      screens: [],
    ),
    AppCatalog(
      title: 'Canvas Drawing',
      description: '',
      type: AppCatalogType.canvas,
      screens: [],
    ),
    AppCatalog(
      title: 'Small Apps',
      description: 'Small App Examples',
      type: AppCatalogType.smallApps,
      screens: [
        AppScreen(
          title: "Unsplash demo",
          description: "Using Unsplash API Demo",
          type: AppScreenType.unsplashDemo
        )
      ],
    )
  ];
}