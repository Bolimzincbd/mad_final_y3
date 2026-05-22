enum Environment { dev, uat, demo, prod }

class AppConfig {
  final Environment environment;
  final String appName;
  final String baseUrl;
  final bool enableCart; // This controls the Demo mode restriction

  // This is a Singleton. It means we can access our config from anywhere in the app.
  static late AppConfig instance;

  AppConfig({
    required this.environment,
    required this.appName,
    required this.baseUrl,
    required this.enableCart,
  }) {
    instance = this; // Save the setup here
  }
}