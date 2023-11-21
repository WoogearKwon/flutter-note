class AppCatalog {
  final String title;
  final String description;
  final AppCatalogType type;
  final List<AppScreen> screens;

  AppCatalog({
    required this.title,
    required this.description,
    required this.type,
    required this.screens,
  });
}

enum AppCatalogType {
  widget,
  canvas,
  smallApps,
}

class AppScreen {
  final String title;
  final String description;
  final AppScreenType type;

  AppScreen({
    required this.title,
    required this.description,
    required this.type,
  });
}

enum AppScreenType {
  unsplashDemo
}