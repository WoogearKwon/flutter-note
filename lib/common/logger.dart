import 'package:logger/logger.dart' as plugin;

class Logger {
  final plugin.Logger? _logger;

  static Logger? _instance;

  Logger._()
      : _logger = plugin.Logger(
          filter: null,
          printer: plugin.PrettyPrinter(
            methodCount: 6,
            errorMethodCount: 10,
            colors: true,
            printEmojis: true,
            lineLength: 120,
          ),
        );

  factory Logger.init() {
    assert(_instance == null, 'Must be initialized only one time.');
    return _instance ??= Logger._();
  }

  static void v(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _log(plugin.Level.verbose, message, error, stackTrace);
  }

  static void d(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _log(plugin.Level.debug, message, error, stackTrace);
  }

  static void i(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _log(plugin.Level.info, message, error, stackTrace);
  }

  static void w(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _log(plugin.Level.warning, message, error, stackTrace);
  }

  static void e(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _log(plugin.Level.error, message, error, stackTrace);
  }

  static void wtf(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _log(plugin.Level.wtf, message, error, stackTrace);
  }

  static void _log(
    plugin.Level level,
    dynamic message, [
    dynamic error,
    StackTrace? stackTrace,
  ]) {
    final logger = _instance?._logger;
    if (logger != null) {
      logger.log(level, message, error, stackTrace);
    }
  }
}
