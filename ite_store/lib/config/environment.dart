enum Environment { dev, uat, demo, prod }

class AppConfig {
  final Environment environment;
  final String appName;
  final String baseUrl;
  final bool enableCart; 
  final String logoPath;
 
  static late AppConfig instance;

  AppConfig({
    required this.environment,
    required this.appName,
    required this.baseUrl,
    required this.enableCart,
    required this.logoPath,
  }) {
    instance = this; 
  }
}