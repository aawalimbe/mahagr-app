import 'api_config.dart';

class ApiList {
  // Base URL for all API endpoints
  static String get baseUrl => ApiConfig.baseUrl;

  // Authentication APIs
  static const String login = 'login.php';
  static const String register = 'register.php';
  static const String adminLogin = 'admin_login.php';
  static const String passwordReset = 'password_reset.php';
  static const String passwordUpdate = 'password_update.php';

  // User Management APIs
  static const String users = 'users.php';
  static const String adminUsers = 'admin_users.php';
  static const String updateUserStatus = 'update_user_status.php';

  // Department and Category APIs
  static const String departments = 'departments.php';
  static const String categories = 'categories.php';
  static const String addCategory = 'add_category.php';
  static const String updateCategory = 'update_category.php';
  static const String deleteCategory = 'delete_category.php';

  // Document Management APIs
  static const String documents = 'documents.php';
  static const String documentDetails = 'document_details.php';
  static const String documentUpload = 'document_upload.php';
  static const String updateDocument = 'update_document.php';
  static const String deleteDocument = 'delete_document.php';
  static const String downloadDocument = 'download_document.php';
  static const String documentAccessLogs = 'document_access_logs.php';

  // Document Sharing APIs
  static const String shareDocument = 'share_document.php';
  static const String sharedDocument = 'shared_document.php';

  // Location APIs
  static const String districts = 'districts.php';

  // Notification and Feedback APIs
  static const String notifications = 'notifications.php';
  static const String suggestions = 'suggestions.php';

  // Subject Master APIs
  static const String fetchSubjects = 'fetch_subjects.php';
  static final String FetchCategories = '${baseUrl}fetch_categories.php';
  static final String FetchSubcategories = '${baseUrl}fetch_subcategories.php';
  static final String FetchSubSubcategories =
      '${baseUrl}fetch_sub_sub_categories.php';
  static final String FetchGR = '${baseUrl}fetch_gr.php';

  // Test and Utility APIs
  static const String testUpload = 'test_upload.php';
  static const String securityFixes = 'security_fixes.php';

  // Helper method to get full URL for any endpoint
  static String getFullUrl(String endpoint) => baseUrl + endpoint;

  // API Endpoints with descriptions and methods
  static const Map<String, Map<String, dynamic>> apiEndpoints = {
    'login': {
      'url': login,
      'method': 'POST',
      'description': 'User login authentication',
      'parameters': ['email', 'password'],
    },
    'register': {
      'url': register,
      'method': 'POST',
      'description': 'User registration',
      'parameters': [
        'name',
        'email',
        'password',
        'mobile',
        'userType',
        'district',
      ],
    },
    'adminLogin': {
      'url': adminLogin,
      'method': 'POST',
      'description': 'Admin login authentication',
      'parameters': ['email', 'password'],
    },
    'passwordReset': {
      'url': passwordReset,
      'method': 'POST',
      'description': 'Request password reset',
      'parameters': ['email'],
    },
    'passwordUpdate': {
      'url': passwordUpdate,
      'method': 'POST',
      'description': 'Update user password with OTP',
      'parameters': ['email', 'otp', 'newPassword'],
    },
    'users': {
      'url': users,
      'method': 'GET',
      'description': 'Get all users list',
      'parameters': [],
    },
    'adminUsers': {
      'url': adminUsers,
      'method': 'GET',
      'description': 'Get all admin users',
      'parameters': [],
    },
    'updateUserStatus': {
      'url': updateUserStatus,
      'method': 'POST',
      'description': 'Update user status (Active/Inactive)',
      'parameters': ['user_id', 'status'],
    },
    'departments': {
      'url': departments,
      'method': 'GET',
      'description': 'Get all active departments',
      'parameters': [],
    },
    'categories': {
      'url': categories,
      'method': 'POST',
      'description': 'Get categories (optionally filtered by department)',
      'parameters': ['department_id (optional)'],
    },
    'addCategory': {
      'url': addCategory,
      'method': 'POST',
      'description': 'Add new category',
      'parameters': ['category_name', 'department_id'],
    },
    'updateCategory': {
      'url': updateCategory,
      'method': 'POST',
      'description': 'Update existing category',
      'parameters': ['category_id', 'category_name', 'department_id'],
    },
    'deleteCategory': {
      'url': deleteCategory,
      'method': 'POST',
      'description': 'Delete category (soft delete)',
      'parameters': ['category_id'],
    },
    'documents': {
      'url': documents,
      'method': 'POST',
      'description': 'Get documents with optional filters',
      'parameters': [
        'department (optional)',
        'date (optional)',
        'search (optional)',
        'category_id (optional)',
      ],
    },
    'documentDetails': {
      'url': documentDetails,
      'method': 'POST',
      'description': 'Get detailed information of a specific document',
      'parameters': ['document_id'],
    },
    'documentUpload': {
      'url': documentUpload,
      'method': 'POST',
      'description': 'Upload new document',
      'parameters': ['title', 'description', 'category_id', 'file', 'gr_date'],
    },
    'updateDocument': {
      'url': updateDocument,
      'method': 'POST',
      'description': 'Update existing document',
      'parameters': [
        'document_id',
        'title',
        'description',
        'category_id',
        'gr_date',
      ],
    },
    'deleteDocument': {
      'url': deleteDocument,
      'method': 'POST',
      'description': 'Delete document (soft delete)',
      'parameters': ['document_id'],
    },
    'downloadDocument': {
      'url': downloadDocument,
      'method': 'POST',
      'description': 'Download document file',
      'parameters': ['document_id'],
    },
    'documentAccessLogs': {
      'url': documentAccessLogs,
      'method': 'POST',
      'description': 'Get document access logs',
      'parameters': ['document_id'],
    },
    'shareDocument': {
      'url': shareDocument,
      'method': 'POST',
      'description': 'Share document with other users',
      'parameters': ['document_id', 'shared_with_user_id'],
    },
    'sharedDocument': {
      'url': sharedDocument,
      'method': 'POST',
      'description': 'Get documents shared with current user',
      'parameters': ['user_id'],
    },
    'districts': {
      'url': districts,
      'method': 'GET',
      'description': 'Get all districts',
      'parameters': [],
    },
    'notifications': {
      'url': notifications,
      'method': 'GET',
      'description': 'Get user notifications',
      'parameters': [],
    },
    'suggestions': {
      'url': suggestions,
      'method': 'POST',
      'description': 'Submit user suggestions/feedback',
      'parameters': ['user_id', 'suggestion_text'],
    },
    'fetchSubjects': {
      'url': fetchSubjects,
      'method': 'POST',
      'description': 'Get subject master list (optionally filter by status)',
      'parameters': ['status (optional)'],
    },
    'testUpload': {
      'url': testUpload,
      'method': 'POST',
      'description': 'Test file upload functionality',
      'parameters': ['file'],
    },
    'securityFixes': {
      'url': securityFixes,
      'method': 'GET',
      'description': 'Security fixes and updates',
      'parameters': [],
    },
  };

  // Get API endpoint information
  static Map<String, dynamic>? getEndpointInfo(String endpointName) =>
      apiEndpoints[endpointName];

  // Get full URL for an endpoint
  static String getEndpointUrl(String endpointName) {
    final info = apiEndpoints[endpointName];
    return info != null ? baseUrl + info['url'] : '';
  }

  // Get HTTP method for an endpoint
  static String getEndpointMethod(String endpointName) =>
      apiEndpoints[endpointName]?['method'] ?? 'GET';

  // Get description for an endpoint
  static String getEndpointDescription(String endpointName) =>
      apiEndpoints[endpointName]?['description'] ?? '';

  // Get parameters for an endpoint
  static List<String> getEndpointParameters(String endpointName) {
    final params = apiEndpoints[endpointName]?['parameters'];
    return params is List ? List<String>.from(params) : [];
  }

  // Get all endpoint names
  static List<String> getAllEndpointNames() => apiEndpoints.keys.toList();

  // Get all endpoints with information
  static Map<String, Map<String, dynamic>> getAllEndpoints() =>
      Map.from(apiEndpoints);
}

// import 'app_config.dart';

// class ApiList {
//   // Base URL for all API endpoints
//   //static const String baseUrl = 'localhost/mahagrweb/api/';
//   static String get baseUrl => AppConfig.baseUrl;

//   // Authentication APIs
//   static const String login = 'login.php';
//   static const String register = 'register.php';
//   static const String adminLogin = 'admin_login.php';
//   static const String passwordReset = 'password_reset.php';
//   static const String passwordUpdate = 'password_update.php';

//   // User Management APIs
//   static const String users = 'users.php';
//   static const String adminUsers = 'admin_users.php';
//   static const String updateUserStatus = 'update_user_status.php';

//   // Department and Category APIs
//   static const String departments = 'departments.php';
//   static const String categories = 'categories.php';
//   static const String addCategory = 'add_category.php';
//   static const String updateCategory = 'update_category.php';
//   static const String deleteCategory = 'delete_category.php';

//   // Document Management APIs
//   static const String documents = 'documents.php';
//   static const String documentDetails = 'document_details.php';
//   static const String documentUpload = 'document_upload.php';
//   static const String updateDocument = 'update_document.php';
//   static const String deleteDocument = 'delete_document.php';
//   static const String downloadDocument = 'download_document.php';
//   static const String documentAccessLogs = 'document_access_logs.php';

//   // Document Sharing APIs
//   static const String shareDocument = 'share_document.php';
//   static const String sharedDocument = 'shared_document.php';

//   // Location APIs
//   static const String districts = 'districts.php';

//   // Notification and Feedback APIs
//   static const String notifications = 'notifications.php';
//   static const String suggestions = 'suggestions.php';

//   // Subject Master APIs
//   static const String fetchSubjects = 'fetch_subjects.php';
//   static final String FetchCategories = '${baseUrl}fetch_categories.php';
//   static final String FetchSubcategories = '${baseUrl}fetch_subcategories.php';
//   static final String FetchGR = '${baseUrl}fetch_gr.php';

//   // Test and Utility APIs
//   static const String testUpload = 'test_upload.php';
//   static const String securityFixes = 'security_fixes.php';

//   // Helper method to get full URL for any endpoint
//   static String getFullUrl(String endpoint) {
//     return baseUrl + endpoint;
//   }

//   // API Endpoints with descriptions and methods
//   static const Map<String, Map<String, dynamic>> apiEndpoints = {
//     'login': {
//       'url': login,
//       'method': 'POST',
//       'description': 'User login authentication',
//       'parameters': ['email', 'password'],
//     },
//     'register': {
//       'url': register,
//       'method': 'POST',
//       'description': 'User registration',
//       'parameters': [
//         'name',
//         'email',
//         'password',
//         'mobile',
//         'userType',
//         'district',
//       ],
//     },
//     'adminLogin': {
//       'url': adminLogin,
//       'method': 'POST',
//       'description': 'Admin login authentication',
//       'parameters': ['email', 'password'],
//     },
//     'passwordReset': {
//       'url': passwordReset,
//       'method': 'POST',
//       'description': 'Request password reset',
//       'parameters': ['email'],
//     },
//     'passwordUpdate': {
//       'url': passwordUpdate,
//       'method': 'POST',
//       'description': 'Update user password with OTP',
//       'parameters': ['email', 'otp', 'newPassword'],
//     },
//     'users': {
//       'url': users,
//       'method': 'GET',
//       'description': 'Get all users list',
//       'parameters': [],
//     },
//     'adminUsers': {
//       'url': adminUsers,
//       'method': 'GET',
//       'description': 'Get all admin users',
//       'parameters': [],
//     },
//     'updateUserStatus': {
//       'url': updateUserStatus,
//       'method': 'POST',
//       'description': 'Update user status (Active/Inactive)',
//       'parameters': ['user_id', 'status'],
//     },
//     'departments': {
//       'url': departments,
//       'method': 'GET',
//       'description': 'Get all active departments',
//       'parameters': [],
//     },
//     'categories': {
//       'url': categories,
//       'method': 'POST',
//       'description': 'Get categories (optionally filtered by department)',
//       'parameters': ['department_id (optional)'],
//     },
//     'addCategory': {
//       'url': addCategory,
//       'method': 'POST',
//       'description': 'Add new category',
//       'parameters': ['category_name', 'department_id'],
//     },
//     'updateCategory': {
//       'url': updateCategory,
//       'method': 'POST',
//       'description': 'Update existing category',
//       'parameters': ['category_id', 'category_name', 'department_id'],
//     },
//     'deleteCategory': {
//       'url': deleteCategory,
//       'method': 'POST',
//       'description': 'Delete category (soft delete)',
//       'parameters': ['category_id'],
//     },
//     'documents': {
//       'url': documents,
//       'method': 'POST',
//       'description': 'Get documents with optional filters',
//       'parameters': [
//         'department (optional)',
//         'date (optional)',
//         'search (optional)',
//         'category_id (optional)',
//       ],
//     },
//     'documentDetails': {
//       'url': documentDetails,
//       'method': 'POST',
//       'description': 'Get detailed information of a specific document',
//       'parameters': ['document_id'],
//     },
//     'documentUpload': {
//       'url': documentUpload,
//       'method': 'POST',
//       'description': 'Upload new document',
//       'parameters': ['title', 'description', 'category_id', 'file', 'gr_date'],
//     },
//     'updateDocument': {
//       'url': updateDocument,
//       'method': 'POST',
//       'description': 'Update existing document',
//       'parameters': [
//         'document_id',
//         'title',
//         'description',
//         'category_id',
//         'gr_date',
//       ],
//     },
//     'deleteDocument': {
//       'url': deleteDocument,
//       'method': 'POST',
//       'description': 'Delete document (soft delete)',
//       'parameters': ['document_id'],
//     },
//     'downloadDocument': {
//       'url': downloadDocument,
//       'method': 'POST',
//       'description': 'Download document file',
//       'parameters': ['document_id'],
//     },
//     'documentAccessLogs': {
//       'url': documentAccessLogs,
//       'method': 'POST',
//       'description': 'Get document access logs',
//       'parameters': ['document_id'],
//     },
//     'shareDocument': {
//       'url': shareDocument,
//       'method': 'POST',
//       'description': 'Share document with other users',
//       'parameters': ['document_id', 'shared_with_user_id'],
//     },
//     'sharedDocument': {
//       'url': sharedDocument,
//       'method': 'POST',
//       'description': 'Get documents shared with current user',
//       'parameters': ['user_id'],
//     },
//     'districts': {
//       'url': districts,
//       'method': 'GET',
//       'description': 'Get all districts',
//       'parameters': [],
//     },
//     'notifications': {
//       'url': notifications,
//       'method': 'GET',
//       'description': 'Get user notifications',
//       'parameters': [],
//     },
//     'suggestions': {
//       'url': suggestions,
//       'method': 'POST',
//       'description': 'Submit user suggestions/feedback',
//       'parameters': ['user_id', 'suggestion_text'],
//     },
//     'fetchSubjects': {
//       'url': fetchSubjects,
//       'method': 'POST',
//       'description': 'Get subject master list (optionally filter by status)',
//       'parameters': ['status (optional)'],
//     },
//     'testUpload': {
//       'url': testUpload,
//       'method': 'POST',
//       'description': 'Test file upload functionality',
//       'parameters': ['file'],
//     },
//     'securityFixes': {
//       'url': securityFixes,
//       'method': 'GET',
//       'description': 'Security fixes and updates',
//       'parameters': [],
//     },
//   };

//   // Get API endpoint information
//   static Map<String, dynamic>? getEndpointInfo(String endpointName) {
//     return apiEndpoints[endpointName];
//   }

//   // Get full URL for an endpoint
//   static String getEndpointUrl(String endpointName) {
//     final endpointInfo = apiEndpoints[endpointName];
//     if (endpointInfo != null) {
//       return baseUrl + endpointInfo['url'];
//     }
//     return '';
//   }

//   // Get HTTP method for an endpoint
//   static String getEndpointMethod(String endpointName) {
//     final endpointInfo = apiEndpoints[endpointName];
//     return endpointInfo?['method'] ?? 'GET';
//   }

//   // Get description for an endpoint
//   static String getEndpointDescription(String endpointName) {
//     final endpointInfo = apiEndpoints[endpointName];
//     return endpointInfo?['description'] ?? '';
//   }

//   // Get parameters for an endpoint
//   static List<String> getEndpointParameters(String endpointName) {
//     final endpointInfo = apiEndpoints[endpointName];
//     final parameters = endpointInfo?['parameters'];
//     if (parameters is List) {
//       return parameters.cast<String>();
//     }
//     return [];
//   }

//   // Get all endpoint names
//   static List<String> getAllEndpointNames() {
//     return apiEndpoints.keys.toList();
//   }

//   // Get all endpoints with their information
//   static Map<String, Map<String, dynamic>> getAllEndpoints() {
//     return Map.from(apiEndpoints);
//   }
// }
