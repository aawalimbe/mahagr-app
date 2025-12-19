class AppConfig {
  // API Configuration
  static const bool isDevelopment =
      false; // Set to false to use online database

  // Base URLs for different environments
  static const String _devBaseUrl =
      'http://192.168.1.42/mahagrweb/api/'; // Physical Device (Your Computer IP)
  static const String _localBaseUrl =
      'http://localhost/mahagrweb/api/'; // Local development
  static const String _productionBaseUrl =
      'https://mahagralert.com/crm/api/'; // Production

  // Get the appropriate base URL based on environment
  static String get baseUrl => isDevelopment ? _devBaseUrl : _productionBaseUrl;

  // Alternative URLs for testing on physical devices
  static const String _physicalDeviceUrl =
      'http://192.168.1.16/mahagrweb/api/'; // Your computer's IP

  // Get URL for physical device testing
  static String get physicalDeviceUrl => _physicalDeviceUrl;

  // Timeout settings
  static const int connectionTimeout = 30; // seconds
  static const int receiveTimeout = 30; // seconds

  // Debug settings
  static const bool enableLogging = true;
}

// class AppConfig {
//   // API Configuration
//   static const bool isDevelopment =
//       false; // Set to false to use online database

//   // Base URLs for different environments
//   static const String _devBaseUrl =
//       'http://192.168.1.42/mahagrweb/api/'; // Physical Device (Your Computer IP)
//   static const String _localBaseUrl =
//       'http://localhost/mahagrweb/api/'; // Local development
//   static const String _productionBaseUrl =
//       'https://mahagralert.com/crm/api/'; // Production

//   // Get the appropriate base URL based on environment
//   static String get baseUrl {
//     if (isDevelopment) {
//       return _devBaseUrl;
//     } else {
//       return _productionBaseUrl;
//     }
//   }

//   // Alternative URLs for testing on physical devices
//   static const String _physicalDeviceUrl =
//       'http://192.168.1.16/mahagrweb/api/'; // Your computer's IP

//   // Get URL for physical device testing
//   static String get physicalDeviceUrl => _physicalDeviceUrl;

//   // Timeout settings
//   static const int connectionTimeout = 30; // seconds
//   static const int receiveTimeout = 30; // seconds

//   // Debug settings
//   static const bool enableLogging = true;
// }
