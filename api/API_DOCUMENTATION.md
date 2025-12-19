# 🌲 Maha GR App - API Documentation

**Version:** 1.0  
**Base URL:** `http://localhost/mahagr/api/`  
**Content-Type:** `application/json`  
**Date:** August 7, 2025

---

## 📋 Table of Contents

1. [Authentication APIs](#authentication-apis)
2. [User Management APIs](#user-management-apis)
3. [Department & Category APIs](#department--category-apis)
4. [Document Management APIs](#document-management-apis)
5. [Notification & Feedback APIs](#notification--feedback-apis)
6. [Admin Management APIs](#admin-management-apis)
7. [Integration Examples](#integration-examples)
8. [Error Codes](#error-codes)

---

## 🔐 Authentication APIs

### 1. User Registration
**Endpoint:** `POST /register.php`

**Request Body:**
```json
{
    "name": "John Doe",
    "email": "john@example.com",
    "password": "password123",
    "mobile": "9876543210",
    "userType": "Govt Officer/Employee",
    "department": "Forest Department",
    "district": "Mumbai"
}
```

**Response (Success):**
```json
{
    "message": "Registration successful",
    "status": "true",
    "user_id": 123
}
```

**Response (Error):**
```json
{
    "message": "email not received\nInvalid email format\nUser with this email or mobile already exists",
    "status": "false"
}
```

---

### 2. User Login
**Endpoint:** `POST /login.php`

**Request Body:**
```json
{
    "email": "john@example.com",
    "password": "password123"
}
```

**Response (Success):**
```json
{
    "user_id": 123,
    "email": "john@example.com",
    "mobile": "9876543210",
    "message": "Login successful",
    "status": "true"
}
```

**Response (Error):**
```json
{
    "message": "Invalid email or user not found",
    "status": "false"
}
```

---

### 3. Admin Login
**Endpoint:** `POST /admin_login.php`

**Request Body:**
```json
{
    "email": "admin@example.com",
    "password": "admin123"
}
```

**Response (Success):**
```json
{
    "admin_id": 1,
    "name": "Admin User",
    "email": "admin@example.com",
    "mobile": "9876543210",
    "role": "admin",
    "message": "Admin login successful",
    "status": "true"
}
```

---

### 4. Password Reset Request
**Endpoint:** `POST /password_reset.php`

**Request Body:**
```json
{
    "email": "john@example.com"
}
```

**Response (Success):**
```json
{
    "message": "Password reset OTP sent to your email",
    "status": "true",
    "otp": "123456"
}
```

---

### 5. Password Update
**Endpoint:** `POST /password_update.php`

**Request Body:**
```json
{
    "email": "john@example.com",
    "otp": "123456",
    "newPassword": "newpassword123"
}
```

**Response (Success):**
```json
{
    "message": "Password updated successfully",
    "status": "true"
}
```

---

## 👥 User Management APIs

### 6. Get All Users (Admin)
**Endpoint:** `GET /users.php`

**Response (Success):**
```json
[
    {
        "user_id": 123,
        "email": "john@example.com",
        "mobile": "9876543210",
        "status": "Active",
        "timestamp": "2025-08-07 13:30:00"
    }
]
```

---

### 7. Update User Status (Admin)
**Endpoint:** `POST /update_user_status.php`

**Request Body:**
```json
{
    "user_id": 123,
    "status": "Inactive"
}
```

**Response (Success):**
```json
{
    "message": "User status updated successfully",
    "status": "true"
}
```

---

## 🏢 Department & Category APIs

### 8. Get All Departments
**Endpoint:** `GET /departments.php`

**Response (Success):**
```json
[
    {
        "department_id": 1,
        "department_name": "Forest",
        "status": "Active",
        "timestamp": "2025-08-07 13:30:00"
    },
    {
        "department_id": 2,
        "department_name": "Revenue",
        "status": "Active",
        "timestamp": "2025-08-07 13:30:00"
    }
]
```

---

### 9. Get Categories
**Endpoint:** `POST /categories.php`

**Request Body (Optional):**
```json
{
    "department_id": 1
}
```

**Response (Success):**
```json
[
    {
        "category_id": 1,
        "category_name": "HR",
        "status": "Active",
        "timestamp": "2025-08-07 13:30:00",
        "department_name": "Forest"
    }
]
```

---

### 10. Add Category (Admin)
**Endpoint:** `POST /add_category.php`

**Request Body:**
```json
{
    "category_name": "New Category",
    "department_id": 1
}
```

**Response (Success):**
```json
{
    "message": "Category added successfully",
    "status": "true",
    "category_id": 15
}
```

---

### 11. Update Category (Admin)
**Endpoint:** `POST /update_category.php`

**Request Body:**
```json
{
    "category_id": 15,
    "category_name": "Updated Category Name"
}
```

**Response (Success):**
```json
{
    "message": "Category updated successfully",
    "status": "true"
}
```

---

### 12. Delete Category (Admin)
**Endpoint:** `POST /delete_category.php`

**Request Body:**
```json
{
    "category_id": 15
}
```

**Response (Success):**
```json
{
    "message": "Category deleted successfully",
    "status": "true"
}
```

---

### 13. Get Districts
**Endpoint:** `GET /districts.php`

**Response (Success):**
```json
[
    {
        "id": 1,
        "name": "Mumbai"
    },
    {
        "id": 2,
        "name": "Pune"
    }
]
```

---

## 📄 Document Management APIs

### 14. Get Documents
**Endpoint:** `POST /documents.php`

**Request Body (Optional Filters):**
```json
{
    "department": "Forest",
    "date": "2025-08-07",
    "search": "GR notification",
    "category_id": 1
}
```

**Response (Success):**
```json
[
    {
        "document_id": 1,
        "title": "Forest GR Notification",
        "description": "Important notification about forest regulations",
        "file_type": "application/pdf",
        "file_url": "uploads/Forest/HR/gr_123456.pdf",
        "gr_date": "2025-08-07",
        "upload_date": "2025-08-07 13:30:00",
        "category_name": "HR",
        "department_name": "Forest",
        "uploaded_by_name": "Admin User"
    }
]
```

---

### 15. Get Document Details
**Endpoint:** `POST /document_details.php`

**Request Body:**
```json
{
    "document_id": 1,
    "user_id": 123
}
```

**Response (Success):**
```json
{
    "document_id": 1,
    "title": "Forest GR Notification",
    "description": "Important notification about forest regulations",
    "file_type": "application/pdf",
    "file_url": "uploads/Forest/HR/gr_123456.pdf",
    "gr_date": "2025-08-07",
    "upload_date": "2025-08-07 13:30:00",
    "category_name": "HR",
    "department_name": "Forest"
}
```

---

### 16. Upload Document (Admin)
**Endpoint:** `POST /document_upload.php`

**Request Body (Multipart Form Data):**
```
title: Forest GR Notification
description: Important notification about forest regulations
category_id: 1
gr_date: 2025-08-07
uploaded_by: 1
file: [PDF/Image file]
```

**Response (Success):**
```json
{
    "message": "Document uploaded successfully",
    "status": "true",
    "document_id": 2,
    "file_url": "uploads/Forest/HR/gr_678901.pdf"
}
```

---

### 17. Update Document (Admin)
**Endpoint:** `POST /update_document.php`

**Request Body:**
```json
{
    "document_id": 1,
    "title": "Updated Forest GR Notification",
    "description": "Updated description",
    "category_id": 2,
    "gr_date": "2025-08-08"
}
```

**Response (Success):**
```json
{
    "message": "Document updated successfully",
    "status": "true"
}
```

---

### 18. Delete Document (Admin)
**Endpoint:** `POST /delete_document.php`

**Request Body:**
```json
{
    "document_id": 1
}
```

**Response (Success):**
```json
{
    "message": "Document deleted successfully",
    "status": "true"
}
```

---

### 19. Download Document
**Endpoint:** `POST /download_document.php`

**Request Body:**
```json
{
    "document_id": 1
}
```

**Response:** Returns the actual file for download

---

### 20. Share Document
**Endpoint:** `POST /share_document.php`

**Request Body:**
```json
{
    "document_id": 1
}
```

**Response (Success):**
```json
{
    "message": "Shareable link generated successfully",
    "status": "true",
    "share_url": "https://yourdomain.com/api/shared_document.php?token=gr_123456_1234567890",
    "token": "gr_123456_1234567890"
}
```

---

### 21. Access Shared Document
**Endpoint:** `GET /shared_document.php?token=gr_123456_1234567890`

**Response (Success):**
```json
{
    "share_id": 1,
    "document_id": 1,
    "title": "Forest GR Notification",
    "description": "Important notification about forest regulations",
    "file_type": "application/pdf",
    "file_url": "uploads/Forest/HR/gr_123456.pdf",
    "gr_date": "2025-08-07",
    "upload_date": "2025-08-07 13:30:00",
    "status": "Active"
}
```

---

### 22. Document Access Logs (Admin)
**Endpoint:** `POST /document_access_logs.php`

**Request Body (Optional Filters):**
```json
{
    "document_id": 1,
    "user_id": 123
}
```

**Response (Success):**
```json
[
    {
        "log_id": 1,
        "user_id": 123,
        "email": "john@example.com",
        "document_id": 1,
        "title": "Forest GR Notification",
        "access_time": "2025-08-07 13:30:00",
        "timestamp": "2025-08-07 13:30:00"
    }
]
```

---

## 🔔 Notification & Feedback APIs

### 23. Get Notifications
**Endpoint:** `POST /notifications.php`

**Request Body (Optional):**
```json
{
    "user_id": 123
}
```

**Response (Success):**
```json
[
    {
        "notification_id": 1,
        "title": "New GR Available",
        "message": "A new Government Resolution has been uploaded",
        "related_document_id": 1,
        "scheduled_at": "2025-08-07 13:30:00",
        "sent_at": "2025-08-07 13:30:00",
        "status": "sent",
        "timestamp": "2025-08-07 13:30:00"
    }
]
```

---

### 24. Submit Suggestion/Feedback
**Endpoint:** `POST /suggestions.php`

**Request Body:**
```json
{
    "message": "Please add more categories for better organization",
    "contact": "john@example.com",
    "user_id": 123
}
```

**Response (Success):**
```json
{
    "message": "Suggestion submitted successfully",
    "status": "true"
}
```

---

## 👨‍💼 Admin Management APIs

### 25. Get All Admin Users
**Endpoint:** `GET /admin_users.php`

**Response (Success):**
```json
[
    {
        "admin_id": 1,
        "name": "Admin User",
        "email": "admin@example.com",
        "mobile_number": "9876543210",
        "role": "admin",
        "status": "Active",
        "timestamp": "2025-08-07 13:30:00"
    }
]
```

---

## 🔧 Integration Examples

### Flutter/Dart Integration

#### User Registration
```dart
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<Map<String, dynamic>> registerUser({
  required String name,
  required String email,
  required String password,
  required String mobile,
  required String userType,
  required String district,
  String? department,
}) async {
  final response = await http.post(
    Uri.parse('http://localhost/mahagr/api/register.php'),
    headers: {'Content-Type': 'application/json'},
    body: json.encode({
      'name': name,
      'email': email,
      'password': password,
      'mobile': mobile,
      'userType': userType,
      'district': district,
      'department': department,
    }),
  );

  return json.decode(response.body);
}
```

#### User Login
```dart
Future<Map<String, dynamic>> loginUser({
  required String email,
  required String password,
}) async {
  final response = await http.post(
    Uri.parse('http://localhost/mahagr/api/login.php'),
    headers: {'Content-Type': 'application/json'},
    body: json.encode({
      'email': email,
      'password': password,
    }),
  );

  return json.decode(response.body);
}
```

#### Get Documents
```dart
Future<List<Map<String, dynamic>>> getDocuments({
  String? department,
  String? date,
  String? search,
  int? categoryId,
}) async {
  final response = await http.post(
    Uri.parse('http://localhost/mahagr/api/documents.php'),
    headers: {'Content-Type': 'application/json'},
    body: json.encode({
      if (department != null) 'department': department,
      if (date != null) 'date': date,
      if (search != null) 'search': search,
      if (categoryId != null) 'category_id': categoryId,
    }),
  );

  final data = json.decode(response.body);
  return List<Map<String, dynamic>>.from(data);
}
```

#### Upload Document
```dart
Future<Map<String, dynamic>> uploadDocument({
  required String title,
  required String description,
  required int categoryId,
  required String grDate,
  required int uploadedBy,
  required File file,
}) async {
  var request = http.MultipartRequest(
    'POST',
    Uri.parse('http://localhost/mahagr/api/document_upload.php'),
  );

  request.fields['title'] = title;
  request.fields['description'] = description;
  request.fields['category_id'] = categoryId.toString();
  request.fields['gr_date'] = grDate;
  request.fields['uploaded_by'] = uploadedBy.toString();

  request.files.add(
    await http.MultipartFile.fromPath('file', file.path),
  );

  final response = await request.send();
  final responseData = await response.stream.bytesToString();
  return json.decode(responseData);
}
```

### JavaScript/React Integration

#### User Registration
```javascript
const registerUser = async (userData) => {
  try {
    const response = await fetch('http://localhost/mahagr/api/register.php', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify(userData),
    });
    
    const data = await response.json();
    return data;
  } catch (error) {
    console.error('Registration error:', error);
    throw error;
  }
};

// Usage
const userData = {
  name: 'John Doe',
  email: 'john@example.com',
  password: 'password123',
  mobile: '9876543210',
  userType: 'Govt Officer/Employee',
  district: 'Mumbai',
  department: 'Forest Department'
};

const result = await registerUser(userData);
```

#### Get Documents with Filters
```javascript
const getDocuments = async (filters = {}) => {
  try {
    const response = await fetch('http://localhost/mahagr/api/documents.php', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify(filters),
    });
    
    const data = await response.json();
    return data;
  } catch (error) {
    console.error('Get documents error:', error);
    throw error;
  }
};

// Usage
const documents = await getDocuments({
  department: 'Forest',
  search: 'GR notification',
  category_id: 1
});
```

### PHP Integration

#### User Registration
```php
<?php
function registerUser($userData) {
    $url = 'http://localhost/mahagr/api/register.php';
    
    $ch = curl_init();
    curl_setopt($ch, CURLOPT_URL, $url);
    curl_setopt($ch, CURLOPT_POST, true);
    curl_setopt($ch, CURLOPT_POSTFIELDS, json_encode($userData));
    curl_setopt($ch, CURLOPT_HTTPHEADER, array(
        'Content-Type: application/json'
    ));
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
    
    $response = curl_exec($ch);
    curl_close($ch);
    
    return json_decode($response, true);
}

// Usage
$userData = array(
    'name' => 'John Doe',
    'email' => 'john@example.com',
    'password' => 'password123',
    'mobile' => '9876543210',
    'userType' => 'Govt Officer/Employee',
    'district' => 'Mumbai',
    'department' => 'Forest Department'
);

$result = registerUser($userData);
?>
```

#### Upload Document
```php
<?php
function uploadDocument($documentData, $filePath) {
    $url = 'http://localhost/mahagr/api/document_upload.php';
    
    $postData = array(
        'title' => $documentData['title'],
        'description' => $documentData['description'],
        'category_id' => $documentData['category_id'],
        'gr_date' => $documentData['gr_date'],
        'uploaded_by' => $documentData['uploaded_by'],
        'file' => new CURLFile($filePath)
    );
    
    $ch = curl_init();
    curl_setopt($ch, CURLOPT_URL, $url);
    curl_setopt($ch, CURLOPT_POST, true);
    curl_setopt($ch, CURLOPT_POSTFIELDS, $postData);
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
    
    $response = curl_exec($ch);
    curl_close($ch);
    
    return json_decode($response, true);
}
?>
```

---

## ❌ Error Codes

### Common Error Messages

| Error Message | Description | Solution |
|---------------|-------------|----------|
| `field_name not received` | Required field is missing | Include the required field in request body |
| `field_name can not be empty` | Field value is empty | Provide a valid value for the field |
| `Invalid email format` | Email format is incorrect | Use valid email format (e.g., user@domain.com) |
| `Invalid mobile number format` | Mobile number format is incorrect | Use 10-digit Indian mobile number |
| `User with this email or mobile already exists` | User already registered | Use different email/mobile or login instead |
| `Invalid email or user not found` | User doesn't exist | Check email or register new user |
| `Invalid password` | Password is incorrect | Check password and try again |
| `File size exceeds 10MB limit` | Uploaded file is too large | Compress or use smaller file |
| `Invalid file type` | File type not allowed | Use PDF, JPG, JPEG, PNG, DOC, or DOCX |
| `Document not found` | Document doesn't exist | Check document_id |
| `Category has associated documents` | Cannot delete category with documents | Remove documents first or reassign them |

### HTTP Status Codes

| Status Code | Description |
|-------------|-------------|
| 200 | Success |
| 400 | Bad Request (validation errors) |
| 401 | Unauthorized |
| 403 | Forbidden |
| 404 | Not Found |
| 500 | Internal Server Error |

---

## 🔒 Security Considerations

1. **Password Security**: Currently using MD5 (should be upgraded to bcrypt)
2. **Input Validation**: All inputs are validated and sanitized
3. **SQL Injection Prevention**: Using PDO prepared statements
4. **File Upload Security**: File type and size validation
5. **CORS**: Configured for cross-origin requests
6. **Authentication**: Token-based authentication recommended for production

---

## 📝 Notes

1. **Base URL**: Update the base URL in your integration code to match your server configuration
2. **File Uploads**: Ensure the `uploads/` directory has proper write permissions
3. **Database**: Make sure the `maha_gr` database is properly configured
4. **Error Handling**: Always implement proper error handling in your client applications
5. **Rate Limiting**: Consider implementing rate limiting for production use
6. **SSL**: Use HTTPS for production environments

---

## 📞 Support

For technical support or questions about the API, please contact the development team.

**Last Updated:** August 7, 2025  
**Version:** 1.0

