class AppConfig {
  // static instance variable to hold the single instance of AppConfig
  static AppConfig? _instance;

  AppConfig._(); //private constructor

  // public static method to provide access to the single instance of AppConfig
  // instance would only be created when it is first accessed (lazy initialization)
  static AppConfig get instance => _instance ??= AppConfig._();
}

void main() {
  final config1 = AppConfig.instance;
  final config2 = AppConfig.instance;

  print(
    identical(config1, config2),
  ); // true, both references point to the same instance
}
