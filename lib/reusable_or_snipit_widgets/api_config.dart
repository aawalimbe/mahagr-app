enum ApiEnvironment {
  production,
  emulator,
  local,
}

class ApiConfig {
  // =========================================================
  // CONFIGURATION
  // =========================================================
  
  /// Set the current environment here
  static const ApiEnvironment currentEnvironment = ApiEnvironment.production;

  /// Enable logic logs
  static const bool enableLogging = true;

  // =========================================================
  // URL CONSTANTS
  // =========================================================

  static const String _productionBaseUrl = 'https://mahagralert.com/crm/api/';
  static const String _emulatorBaseUrl = 'http://10.0.2.2/mahagr/mahagr-app/api/';
  static const String _localBaseUrl = 'http://localhost/mahagrweb/api/';
  
  // Physical Device Testing IP (Optional)
  static const String _physicalDeviceUrl = 'http://192.168.1.16/mahagrweb/api/';

  // =========================================================
  // GETTERS
  // =========================================================

  /// Returns the Base URL based on the current environment
  static String get baseUrl {
    switch (currentEnvironment) {
      case ApiEnvironment.production:
        return _productionBaseUrl;
      case ApiEnvironment.emulator:
        return _emulatorBaseUrl;
      case ApiEnvironment.local:
        return _localBaseUrl;
    }
  }

  /// Helper to get the physical device URL directly if needed
  static String get physicalDeviceUrl => _physicalDeviceUrl;

  /// Timeout settings (seconds)
  static const int connectionTimeout = 30;
  static const int receiveTimeout = 30;
}
