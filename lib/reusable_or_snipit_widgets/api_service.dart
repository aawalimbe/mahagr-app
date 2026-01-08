import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

import 'api_config.dart';
import 'api_list.dart';

class ApiService {
  static final Dio _dio = Dio();

  // Configure Dio with base settings
  static void initialize() {
    print('=== API SERVICE INITIALIZATION ===');
    print('ApiConfig.currentEnvironment: ${ApiConfig.currentEnvironment}');
    print('ApiConfig.baseUrl: ${ApiConfig.baseUrl}');
    print('================================');

    _dio.options.baseUrl = ApiConfig.baseUrl;
    _dio.options.connectTimeout = const Duration(seconds: 30);
    _dio.options.receiveTimeout = const Duration(seconds: 30);
    _dio.options.headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    // Add logging interceptor for debugging
    if (ApiConfig.enableLogging) {
      _dio.interceptors.add(
        LogInterceptor(
          requestBody: true,
          responseBody: true,
          logPrint: (obj) => print('DIO: $obj'),
        ),
      );
    }
    print(
      'ApiService initialized successfully with base URL: ${_dio.options.baseUrl}',
    );
  }

  // Generic POST request
  static Future<Map<String, dynamic>> post(
    String endpoint,
    Map<String, dynamic> data,
  ) async {
    try {
      final response = await _dio.post(endpoint, data: data);
      return response.data;
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  // Generic GET request
  static Future<Map<String, dynamic>> get(String endpoint) async {
    try {
      final response = await _dio.get(endpoint);
      return response.data;
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  // Handle Dio errors
  static Exception _handleDioError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return Exception(
          'Connection timeout. Please check your internet connection.',
        );
      case DioExceptionType.badResponse:
        final statusCode = e.response?.statusCode;
        final message = e.response?.data?['message'] ?? 'Server error occurred';
        return Exception('HTTP $statusCode: $message');
      case DioExceptionType.cancel:
        return Exception('Request was cancelled');
      case DioExceptionType.connectionError:
        return Exception('No internet connection. Please check your network.');
      default:
        return Exception('Network error occurred');
    }
  }

  // Register user
  static Future<Map<String, dynamic>> registerUser({
    required String name,
    required String email,
    required String password,
    required String mobile,
    required String userType,
    required String district,
    String? department,
  }) async {
    final data = {
      'name': name,
      'email': email,
      'password': password,
      'mobile': mobile,
      'userType': userType,
      'district': district,
    };
    if (department != null) data['department'] = department;
    return await post(ApiList.register, data);
  }

  // Login user
  static Future<Map<String, dynamic>> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      print('=== LOGIN API CALL ===');
      print('Email: $email');
      print('Password: ${password.length} characters');
      print('Base URL: ${_dio.options.baseUrl}');
      print('Full URL: ${_dio.options.baseUrl}${ApiList.login}');
      print('======================');

      final data = {'email': email, 'password': password};
      final response = await _dio.post(ApiList.login, data: data);
      print('Login API Response: ${response.data}');
      return response.data;
    } on DioException catch (e) {
      print('Login DioException: ${e.message}');
      print('Login DioException Type: ${e.type}');
      print('Login DioException Response: ${e.response?.data}');
      throw _handleDioError(e);
    } catch (e) {
      print('Login General Error: $e');
      throw Exception('Network error: $e');
    }
  }

  // Get departments
  static Future<List<Map<String, dynamic>>> getDepartments() async {
    try {
      print(
        'Fetching departments from: ${_dio.options.baseUrl}${ApiList.departments}',
      );
      final response = await _dio.get(ApiList.departments);
      if (response.data is List) {
        return List<Map<String, dynamic>>.from(response.data);
      }
      return [];
    } on DioException catch (e) {
      // Try alternate base URL pattern if server path differs (api vs apis)
      final currentBase = _dio.options.baseUrl;
      String? altBase;
      if (currentBase.contains('/apis/')) {
        altBase = currentBase.replaceFirst('/apis/', '/api/');
      } else if (currentBase.contains('/api/')) {
        altBase = currentBase.replaceFirst('/api/', '/apis/');
      }

      if (altBase != null) {
        try {
          print('Primary URL failed. Retrying with alternate base: $altBase');
          final altDio =
              Dio()..options = _dio.options.copyWith(baseUrl: altBase);
          final altResp = await altDio.get(ApiList.departments);
          if (altResp.data is List) {
            // Switch global base URL for future calls
            _dio.options.baseUrl = altBase;
            print('Switched ApiService baseUrl to: ${_dio.options.baseUrl}');
            return List<Map<String, dynamic>>.from(altResp.data);
          }
        } catch (altErr) {
          print('Alternate base URL also failed: $altErr');
        }
      }
      throw _handleDioError(e);
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  // Get districts
  static Future<List<Map<String, dynamic>>> getDistricts() async {
    try {
      final response = await _dio.get(ApiList.districts);
      if (response.data is List) {
        return List<Map<String, dynamic>>.from(response.data);
      }
      return [];
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  // Get categories (optionally filtered by department)
  static Future<List<Map<String, dynamic>>> getCategories({
    String? subjectID,
  }) async {
    try {
      final data =
          subjectID != null
              ? {'subject_Id': subjectID, 'status': 'Active'}
              : {'status': 'Active'};
      final response = await _dio.post(ApiList.categories, data: data);
      if (response.data is Map && response.data['categories'] is List) {
        return List<Map<String, dynamic>>.from(response.data['categories']);
      }
      return [];
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      throw Exception('network error:$e');
    }
  }

  // Get notifications
  static Future<List<Map<String, dynamic>>> getNotifications({
    String? userId,
  }) async {
    try {
      // Note: Currently the API returns all notifications
      // In the future, we can add user_id as a query parameter when the API supports it
      final response = await _dio.get(ApiList.notifications);
      if (response.data is List) {
        return List<Map<String, dynamic>>.from(response.data);
      }
      return [];
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  // Upload document
  // static Future<Map<String, dynamic>> uploadDocument({
  //   required String title,
  //   required String description,
  //   required String filePath,
  //   String? uploadedBy,
  // }) async {
  //   try {
  //     final formData = FormData.fromMap({
  //       'title': title,
  //       'description': description,
  //
  //       'file': await MultipartFile.fromFile(
  //         filePath,
  //         filename: filePath.split('/').last,
  //       ),
  //       if (uploadedBy != null) 'uploaded_by': uploadedBy,
  //     });
  //
  //     final response = await _dio.post(ApiList.documentUpload, data: formData);
  //     return response.data;
  //   } on DioException catch (e) {
  //     throw _handleDioError(e);
  //   } catch (e) {
  //     throw Exception('Network error: $e');
  //   }
  // }
  static Future<Map<String, dynamic>> uploadDocument({
    required String title,
    required String description,
    required Uint8List fileBytes,
    required String fileName,
    String? uploadedBy,
  }) async {
    try {
      final formData = FormData.fromMap({
        'title': title,
        'description': description,
        'file': MultipartFile.fromBytes(fileBytes, filename: fileName),
        if (uploadedBy != null) 'uploaded_by': uploadedBy,
      });

      // Create a separate Dio instance for file uploads without global Content-Type header
      final uploadDio = Dio(
        BaseOptions(
          baseUrl: _dio.options.baseUrl,
          connectTimeout: _dio.options.connectTimeout,
          receiveTimeout: _dio.options.receiveTimeout,
          headers: {'Accept': 'application/json'},
          validateStatus: (status) => status != null && status < 500,
        ),
      );

      // Add logging interceptor if enabled
      if (ApiConfig.enableLogging) {
        uploadDio.interceptors.add(
          LogInterceptor(
            requestBody: true,
            responseBody: true,
            logPrint: (obj) => print('DIO: $obj'),
          ),
        );
      }

      final response = await uploadDio.post(
        ApiList.documentUpload,
        data: formData,
        options: Options(
          responseType: ResponseType.plain,
          validateStatus: (status) => true,
        ),
      );

      // Check response status
      if (response.statusCode != null && response.statusCode! >= 400) {
        final errorBody = response.data?.toString() ?? '';
        print('Server error response (${response.statusCode}): $errorBody');
        throw Exception('Server error: ${response.statusCode}');
      }

      // Try to parse as JSON
      try {
        final responseData = response.data?.toString() ?? '';

        // Check if response is HTML (PHP error)
        if (responseData.trim().startsWith('<') ||
            responseData.contains('<br') ||
            responseData.contains('<b>')) {
          print('Server returned HTML error page:');
          print(responseData);
          // Try to extract PHP error message
          final errorPatterns = [
            RegExp(r'<b>(.*?)</b>', dotAll: true),
            RegExp(r'Fatal error[:\s]*(.*?)(?:<|$)', dotAll: true),
            RegExp(r'Warning[:\s]*(.*?)(?:<|$)', dotAll: true),
            RegExp(r'Parse error[:\s]*(.*?)(?:<|$)', dotAll: true),
          ];

          String? errorMessage;
          for (final pattern in errorPatterns) {
            final match = pattern.firstMatch(responseData);
            if (match != null) {
              errorMessage = match.group(1)?.trim();
              if (errorMessage != null && errorMessage.isNotEmpty) {
                break;
              }
            }
          }

          throw Exception(
            errorMessage != null
                ? 'Server error: $errorMessage'
                : 'Server returned an error page. Please check server configuration.',
          );
        }

        // Parse JSON response
        if (responseData.isEmpty) {
          throw Exception('Server returned empty response');
        }

        final decoded = json.decode(responseData) as Map<String, dynamic>;
        return decoded;
      } catch (parseError) {
        if (parseError is Exception) {
          rethrow;
        }
        print('Failed to parse server response: $parseError');
        print('Raw response: ${response.data}');
        throw Exception(
          'Failed to parse server response. Server may have returned an error page.',
        );
      }
    } on DioException catch (e) {
      if (e.response != null && e.response!.data != null) {
        final responseData = e.response!.data;
        if (responseData is String) {
          print('Server returned HTML/Text instead of JSON:');
          print(responseData);
          // Try to extract error message from HTML
          final errorMatch = RegExp(
            r'<b>(.*?)</b>',
            dotAll: true,
          ).firstMatch(responseData);
          if (errorMatch != null) {
            throw Exception('Server error: ${errorMatch.group(1)}');
          }
          throw Exception(
            'Server returned an error page. Please check server configuration.',
          );
        } else if (responseData is Map) {
          print('Server error response: $responseData');
        }
      }
      throw _handleDioError(e);
    } catch (e) {
      print('Upload error: $e');
      rethrow;
    }
  }

  // Submit suggestion
  static Future<Map<String, dynamic>> submitSuggestion({
    required String message,
    String? contact,
    String? userId,
  }) async {
    try {
      final data = {
        'message': message,
        if (contact != null) 'contact': contact,
        if (userId != null) 'user_id': userId,
      };

      final response = await _dio.post(ApiList.suggestions, data: data);
      return response.data;
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  // Get Subject Master list
  static Future<List<Map<String, dynamic>>> getSubjects({
    String? status,
  }) async {
    try {
      final data = <String, dynamic>{};
      if (status != null && status.isNotEmpty) data['status'] = status;
      final response = await _dio.post(ApiList.fetchSubjects, data: data);
      if (response.data is List) {
        return List<Map<String, dynamic>>.from(response.data);
      }
      return [];
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  // Test API connectivity
  static Future<bool> testConnection() async {
    try {
      print('Testing connection to: ${_dio.options.baseUrl}departments.php');
      print('Full URL: ${ApiConfig.baseUrl}departments.php');

      // First try with http package
      try {
        final httpResponse = await http.get(
          Uri.parse('${ApiConfig.baseUrl}departments.php'),
        );
        print('HTTP test successful: ${httpResponse.statusCode}');
        print('HTTP response: ${httpResponse.body}');
      } catch (httpError) {
        print('HTTP test failed: $httpError');
      }

      // Then try with Dio
      final response = await _dio.get('departments.php');
      print('Dio test successful: ${response.statusCode}');
      return response.statusCode == 200;
    } catch (e) {
      print('Connection test failed: $e');
      print('Full error details: ${e.toString()}');
      return false;
    }
  }

  // Simple network test using http package
  static Future<bool> testNetworkConnectivity() async {
    try {
      final url = '${ApiConfig.baseUrl}departments.php';
      print('Testing network connectivity to: $url');

      final response = await http.get(Uri.parse(url));
      print('Network test successful: ${response.statusCode}');
      return response.statusCode == 200;
    } catch (e) {
      print('Network test failed: $e');
      return false;
    }
  }

  // Update password with OTP
  static Future<Map<String, dynamic>> updatePassword({
    required String email,
    required String otp,
    required String newPassword,
  }) async {
    try {
      print('ApiService.updatePassword called with:');
      print('Email: $email');
      print('OTP: $otp');
      print('New Password: $newPassword');
      print('Endpoint: ${ApiList.passwordUpdate}');
      print('Full URL: ${_dio.options.baseUrl}${ApiList.passwordUpdate}');

      final data = {'email': email, 'otp': otp, 'newPassword': newPassword};
      print('Sending data: $data');
      final response = await _dio.post(ApiList.passwordUpdate, data: data);
      print('Response received: ${response.data}');
      return response.data;
    } on DioException catch (e) {
      print('DioException in updatePassword: $e');
      throw _handleDioError(e);
    } catch (e) {
      print('General error in updatePassword: $e');
      throw Exception('Network error: $e');
    }
  }

  static Future<Uint8List> downloadFilefromUrl(String url) async {
    final response = await Dio().get(
      url,
      options: Options(responseType: ResponseType.bytes),
    );
    return Uint8List.fromList(response.data);
  }
}
