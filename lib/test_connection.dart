// Test script to verify online database connection
// Add this to your main.dart temporarily for testing

import 'package:dio/dio.dart';

Future<void> testOnlineConnection() async {
  final dio = Dio();
  final url = 'https://alphadeveloperteam.com/mahagr/apis/login.php';
  
  print('=== TESTING ONLINE CONNECTION ===');
  print('URL: $url');
  
  try {
    // Test with dummy data
    final response = await dio.post(url, data: {
      'email': 'test@example.com',
      'password': 'testpassword'
    });
    
    print('✅ Connection successful!');
    print('Status Code: ${response.statusCode}');
    print('Response: ${response.data}');
  } on DioException catch (e) {
    print('❌ Connection failed:');
    print('Error Type: ${e.type}');
    print('Error Message: ${e.message}');
    print('Response: ${e.response?.data}');
  } catch (e) {
    print('❌ General error: $e');
  }
  
  print('=== TEST COMPLETE ===');
}










