
import 'package:flutter_note/exports.dart';

class ScreenProvider {
  const ScreenProvider._();

  static List<AppCatalog> catalogs = [
    AppCatalog(
      title: 'Widget Catalogs',
      description: 'Screens Samples Using Widgets',
      type: AppCatalogType.widget,
      screens: [],
    ),
    AppCatalog(
      title: 'Canvas Drawing',
      description: 'Screen Samples Using Canvas',
      type: AppCatalogType.canvas,
      screens: [
        AppScreen(
            title: "Custom Chart",
            description: "2 Types of Custom Chart view",
            type: AppScreenType.customChart
        ),
      ],
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
        ),
        AppScreen(
            title: "Notification Center",
            description: "Mimicking iOS Notification Center",
            type: AppScreenType.notificationCenter
        )
      ],
    )
  ];
}