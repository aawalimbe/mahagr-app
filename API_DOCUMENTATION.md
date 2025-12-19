# Maha GR App - API Documentation

**Version:** 2.0  
**Base URL:** `http://localhost/mahagr/api/`  
**Content-Type:** `application/json`  
**Date:** January 7, 2025

---

## Table of Contents

1. [Authentication APIs](#authentication-apis)
2. [User Management APIs](#user-management-apis)
3. [Department & Category APIs](#department--category-apis)
4. [Document Management APIs](#document-management-apis)
5. [Notification & Feedback APIs](#notification--feedback-apis)
6. [Admin Management APIs](#admin-management-apis)
7. [Integration Examples](#integration-examples)
8. [Error Codes](#error-codes)
9. [Database Schema](#database-schema)

---

## Authentication APIs

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
    "district": "Mumbai",
    "department": "Forest Department"
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

**Notes:** 
- `department` field is optional
- Password is hashed using MD5 (as per existing implementation)
- Mobile validation follows Indian format (6-9 followed by 9 digits)

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

## User Management APIs

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
        "timestamp": "2025-01-07 13:30:00"
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

## Department & Category APIs

### 8. Get All Departments
**Endpoint:** `GET /departments.php`

**Response (Success):**
```json
[
    {
        "department_id": 1,
        "department_name": "Forest",
        "status": "Active",
        "timestamp": "2025-01-07 13:30:00"
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
        "timestamp": "2025-01-07 13:30:00",
        "department_name": "Forest"
    }
]
```

**Notes:** If no `department_id` is provided, returns all active categories

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

**Notes:** Currently returns static data for 36 districts in Maharashtra

---

## Document Management APIs

### 14. Get Documents
**Endpoint:** `POST /documents.php`

**Request Body (Optional Filters):**
```json
{
    "department": "Forest",
    "date": "2025-01-07",
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
        "gr_date": "2025-01-07",
        "upload_date": "2025-01-07 13:30:00",
        "category_name": "HR",
        "department_name": "Forest",
        "uploaded_by_name": "Admin User"
    }
]
```

**Notes:** All filters are optional. Returns documents ordered by upload date (newest first)

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
    "gr_date": "2025-01-07",
    "upload_date": "2025-01-07 13:30:00",
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
gr_date: 2025-01-07
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

**File Requirements:**
- Maximum size: 10MB
- Allowed types: PDF, JPG, JPEG, PNG, DOC, or DOCX
- Files are stored in category-specific folders
- Filenames are sanitized and prefixed with 'gr_'

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
    "gr_date": "2025-01-08"
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
    "gr_date": "2025-01-07",
    "upload_date": "2025-01-07 13:30:00",
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
        "access_time": "2025-01-07 13:30:00",
        "timestamp": "2025-01-07 13:30:00"
    }
]
```

---

## Notification & Feedback APIs

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
        "scheduled_at": "2025-01-07 13:30:00",
        "sent_at": "2025-01-07 13:30:00",
        "status": "sent",
        "timestamp": "2025-01-07 13:30:00"
    }
]
```

**Notes:** Currently returns all notifications (user_id filter not implemented)

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

**Notes:** Currently returns success message without saving to database

---

## Admin Management APIs

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
        "timestamp": "2025-01-07 13:30:00"
    }
]
```

---

## Integration Examples

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

#### Get Documents with Filters
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

### JavaScript/React Integration

#### User Login
```javascript
const loginUser = async (email, password) => {
  try {
    const response = await fetch('http://localhost/mahagr/api/login.php', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({ email, password }),
    });
    
    const data = await response.json();
    return data;
  } catch (error) {
    console.error('Login error:', error);
    throw error;
  }
};
```

#### Upload Document
```javascript
const uploadDocument = async (formData) => {
  try {
    const response = await fetch('http://localhost/mahagr/api/document_upload.php', {
      method: 'POST',
      body: formData, // FormData with file and other fields
    });
    
    const data = await response.json();
    return data;
  } catch (error) {
    console.error('Upload error:', error);
    throw error;
  }
};
```

### PHP Integration

#### Get Categories
```php
<?php
function getCategories($departmentId = null) {
    $url = 'http://localhost/mahagr/api/categories.php';
    
    $postData = array();
    if ($departmentId) {
        $postData['department_id'] = $departmentId;
    }
    
    $ch = curl_init();
    curl_setopt($ch, CURLOPT_URL, $url);
    curl_setopt($ch, CURLOPT_POST, true);
    curl_setopt($ch, CURLOPT_POSTFIELDS, json_encode($postData));
    curl_setopt($ch, CURLOPT_HTTPHEADER, array(
        'Content-Type: application/json'
    ));
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
    
    $response = curl_exec($ch);
    curl_close($ch);
    
    return json_decode($response, true);
}
?>
```

---

## Error Codes

### Common Error Messages

| Error Message | Description | Solution |
|---------------|-------------|----------|
| `field_name not received` | Required field is missing | Include the required field in request body |
| `field_name can not be empty` | Field value is empty | Provide a valid value for the field |
| `Invalid email format` | Email format is incorrect | Use valid email format (e.g., user@domain.com) |
| `Invalid mobile number format` | Mobile number format is incorrect | Use 10-digit Indian mobile number starting with 6-9 |
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

## Database Schema

### Core Tables

#### users
- `user_id` (INT, Primary Key, Auto Increment)
- `name` (VARCHAR(255))
- `email` (VARCHAR(255), Unique)
- `mobile` (VARCHAR(15), Unique)
- `password` (VARCHAR(255), MD5 hashed)
- `user_type` (VARCHAR(100))
- `district` (VARCHAR(100))
- `status` (ENUM: 'Active', 'Inactive')
- `timestamp` (TIMESTAMP)

#### admin_users
- `admin_id` (INT, Primary Key, Auto Increment)
- `name` (VARCHAR(255))
- `email` (VARCHAR(255), Unique)
- `mobile_number` (VARCHAR(15))
- `password` (VARCHAR(255), MD5 hashed)
- `role` (VARCHAR(50))
- `status` (ENUM: 'Active', 'Inactive')
- `timestamp` (TIMESTAMP)

#### department
- `department_id` (INT, Primary Key, Auto Increment)
- `department_name` (VARCHAR(255))
- `status` (ENUM: 'Active', 'Inactive')
- `timestamp` (TIMESTAMP)

#### categories
- `category_id` (INT, Primary Key, Auto Increment)
- `category_name` (VARCHAR(255))
- `department_id` (INT, Foreign Key to department)
- `status` (ENUM: 'Active', 'Inactive')
- `timestamp` (TIMESTAMP)

#### documents
- `document_id` (INT, Primary Key, Auto Increment)
- `title` (VARCHAR(255))
- `description` (TEXT)
- `category_id` (INT, Foreign Key to categories)
- `file_type` (VARCHAR(100))
- `file_url` (VARCHAR(500))
- `gr_date` (DATE)
- `uploaded_by` (INT, Foreign Key to admin_users)
- `upload_date` (TIMESTAMP)
- `status` (ENUM: 'Active', 'Inactive')

#### document_access_logs
- `log_id` (INT, Primary Key, Auto Increment)
- `user_id` (INT, Foreign Key to users)
- `document_id` (INT, Foreign Key to documents)
- `status` (ENUM: 'Active', 'Inactive')
- `timestamp` (TIMESTAMP)

#### notifications
- `notification_id` (INT, Primary Key, Auto Increment)
- `title` (VARCHAR(255))
- `message` (TEXT)
- `related_document_id` (INT, Foreign Key to documents)
- `scheduled_at` (DATETIME)
- `sent_at` (DATETIME)
- `status` (ENUM: 'pending', 'sent', 'failed')
- `timestamp` (TIMESTAMP)

### Additional Tables (from database_fixes.sql)

#### suggestions
- `suggestion_id` (INT, Primary Key, Auto Increment)
- `user_id` (INT, Foreign Key to users)
- `message` (TEXT)
- `contact` (VARCHAR(255))
- `status` (ENUM: 'pending', 'reviewed', 'implemented')
- `timestamp` (TIMESTAMP)

#### districts
- `district_id` (INT, Primary Key, Auto Increment)
- `district_name` (VARCHAR(255))
- `status` (ENUM: 'Active', 'Inactive')
- `timestamp` (TIMESTAMP)

#### audit_logs
- `log_id` (INT, Primary Key, Auto Increment)
- `user_id` (INT, Foreign Key to users)
- `action` (VARCHAR(100))
- `table_name` (VARCHAR(100))
- `record_id` (INT)
- `old_values` (TEXT)
- `new_values` (TEXT)
- `ip_address` (VARCHAR(45))
- `user_agent` (TEXT)
- `timestamp` (TIMESTAMP)

---

## Security Considerations

1. **Password Security**: Currently using MD5 (should be upgraded to bcrypt/Argon2)
2. **Input Validation**: All inputs are validated and sanitized
3. **SQL Injection Prevention**: Using PDO prepared statements
4. **File Upload Security**: File type and size validation
5. **CORS**: Configured for cross-origin requests
6. **Authentication**: Token-based authentication recommended for production
7. **Rate Limiting**: Basic rate limiting table structure available

---

## Notes

1. **Base URL**: Update the base URL in your integration code to match your server configuration
2. **File Uploads**: Ensure the `uploads/` directory has proper write permissions
3. **Database**: Make sure the `mahagr` database is properly configured
4. **Error Handling**: Always implement proper error handling in your client applications
5. **Rate Limiting**: Consider implementing rate limiting for production use
6. **SSL**: Use HTTPS for production environments
7. **File Storage**: Files are organized by category in the uploads directory
8. **Districts**: Currently hardcoded for Maharashtra (36 districts)

---

## Support

For technical support or questions about the API, please contact the development team.

**Last Updated:** January 7, 2025  
**Version:** 2.0

