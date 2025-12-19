# MahaGR App - Detailed API Contracts

**Version:** 2.0  
**Base URL:** `http://localhost/mahagrweb/api/` (Development) | `https://mahagralert.com/crm/api/` (Production)  
**Content-Type:** `application/json` (except file uploads: `multipart/form-data`)  
**Date:** January 2025

---

## Table of Contents

1. [API Contract Standards](#api-contract-standards)
2. [Common Data Types](#common-data-types)
3. [Standard Response Format](#standard-response-format)
4. [Error Response Format](#error-response-format)
5. [Authentication APIs](#authentication-apis)
6. [User Management APIs](#user-management-apis)
7. [Department & Category APIs](#department--category-apis)
8. [Document Management APIs](#document-management-apis)
9. [Notification & Feedback APIs](#notification--feedback-apis)
10. [Admin Management APIs](#admin-management-apis)
11. [Subject Master APIs](#subject-master-apis)

---

## API Contract Standards

### HTTP Methods
- **GET:** Retrieve data (no request body)
- **POST:** Create/Update data (with request body)
- **PUT:** Update data (not currently used)
- **DELETE:** Delete data (not currently used - soft delete via POST)

### Request Headers
```http
Content-Type: application/json
Accept: application/json
```

### Response Headers
```http
Content-Type: application/json
Access-Control-Allow-Origin: *
Access-Control-Allow-Method: POST, GET
Access-Control-Allow-Headers: Access-Control-Allow-Headers, Content-Type, Access-Control-Allow-Method, Authorization, X-Requested-With
```

### Status Codes
- **200 OK:** Successful request
- **400 Bad Request:** Invalid request parameters
- **401 Unauthorized:** Authentication required
- **403 Forbidden:** Insufficient permissions
- **404 Not Found:** Resource not found
- **500 Internal Server Error:** Server error

---

## Common Data Types

### Primitive Types
- **String:** Text data (UTF-8 encoded)
- **Integer:** Whole numbers
- **Boolean:** `true` or `false` (may be string `"true"`/`"false"` in responses)
- **Date:** ISO 8601 format `YYYY-MM-DD` (e.g., `2025-01-07`)
- **DateTime:** ISO 8601 format `YYYY-MM-DD HH:MM:SS` (e.g., `2025-01-07 13:30:00`)
- **Email:** Valid email format (e.g., `user@example.com`)
- **Mobile:** 10-digit Indian mobile number starting with 6-9 (e.g., `9876543210`)

### Complex Types

#### User Object
```typescript
{
  user_id: Integer,
  name: String,
  email: Email,
  mobile: Mobile,
  user_type: String,           // e.g., "Govt Officer/Employee"
  district: String,
  department: String | null,    // Optional
  status: "Active" | "Inactive",
  timestamp: DateTime
}
```

#### Document Object
```typescript
{
  document_id: Integer,
  title: String,
  description: String | null,
  category_id: Integer,
  category_name: String,
  department_name: String | null,
  file_type: String,           // MIME type (e.g., "application/pdf")
  file_url: String,            // Relative path (e.g., "uploads/HR/gr_123.pdf")
  gr_date: Date,
  upload_date: DateTime,
  uploaded_by: Integer,
  uploaded_by_name: String | null,
  status: "Active" | "Inactive"
}
```

#### Category Object
```typescript
{
  category_id: Integer,
  category_name: String,
  department_id: Integer,
  department_name: String | null,
  status: "Active" | "Inactive",
  timestamp: DateTime
}
```

#### Department Object
```typescript
{
  department_id: Integer,
  department_name: String,
  status: "Active" | "Inactive",
  timestamp: DateTime
}
```

---

## Standard Response Format

### Success Response
```json
{
  "status": true | "true",
  "message": "Success message",
  "data": { /* Optional response data */ }
}
```

### Error Response
```json
{
  "status": false | "false",
  "message": "Error message(s) - may contain multiple lines separated by \\n"
}
```

**Note:** Status may be boolean `true`/`false` or string `"true"`/`"false"`. Always check both formats.

---

## Error Response Format

### Validation Errors
```json
{
  "status": "false",
  "message": "field_name not received\nfield_name can not be empty\nInvalid field format"
}
```

### Business Logic Errors
```json
{
  "status": "false",
  "message": "User with this email or mobile already exists"
}
```

### Server Errors
```json
{
  "status": "false",
  "message": "Unable to register user"
}
```

---

## Authentication APIs

### 1. User Registration

**Endpoint:** `POST /register.php`

**Request Contract:**
```typescript
{
  name: String,              // Required, non-empty, max 255 chars
  email: Email,              // Required, valid email format, unique
  password: String,          // Required, non-empty, will be MD5 hashed
  mobile: Mobile,            // Required, 10 digits, starts with 6-9, unique
  userType: String,          // Required, non-empty (e.g., "Govt Officer/Employee")
  district: String,          // Required, non-empty
  department?: String | null // Optional
}
```

**Request Example:**
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

**Success Response (200 OK):**
```json
{
  "status": "true",
  "message": "Registration successful",
  "user_id": 123
}
```

**Error Response (400 Bad Request):**
```json
{
  "status": "false",
  "message": "name not received\nemail not received\nInvalid email format\nUser with this email or mobile already exists"
}
```

**Validation Rules:**
- `name`: Required, non-empty string, max 255 characters
- `email`: Required, valid email format, must be unique
- `password`: Required, non-empty string (will be MD5 hashed server-side)
- `mobile`: Required, must match pattern `^[6-9]\d{9}$`, must be unique
- `userType`: Required, non-empty string
- `district`: Required, non-empty string
- `department`: Optional string

**Business Rules:**
- Email and mobile must be unique across all users
- User is created with status "Active" by default
- Password is hashed using MD5 (security upgrade recommended)

---

### 2. User Login

**Endpoint:** `POST /login.php`

**Request Contract:**
```typescript
{
  email: Email,      // Required, must exist in database
  password: String    // Required, must match MD5 hash
}
```

**Request Example:**
```json
{
  "email": "john@example.com",
  "password": "password123"
}
```

**Success Response (200 OK):**
```json
{
  "status": "true",
  "message": "Login successful",
  "user_id": 123,
  "email": "john@example.com",
  "mobile": "9876543210"
}
```

**Error Response (400 Bad Request):**
```json
{
  "status": "false",
  "message": "email not received\npassword not received"
}
```

**Error Response (401 Unauthorized):**
```json
{
  "status": "false",
  "message": "Invalid email or user not found"
}
```

**Error Response (403 Forbidden):**
```json
{
  "status": "false",
  "message": "Account is inactive"
}
```

**Validation Rules:**
- `email`: Required, must exist in users table
- `password`: Required, must match MD5 hash of stored password

**Business Rules:**
- Only users with status "Active" can login
- Password comparison uses MD5 hash

---

### 3. Admin Login

**Endpoint:** `POST /admin_login.php`

**Request Contract:**
```typescript
{
  email: Email,      // Required, must exist in admin_users table
  password: String    // Required, must match MD5 hash
}
```

**Request Example:**
```json
{
  "email": "admin@example.com",
  "password": "admin123"
}
```

**Success Response (200 OK):**
```json
{
  "status": "true",
  "message": "Admin login successful",
  "admin_id": 1,
  "name": "Admin User",
  "email": "admin@example.com",
  "mobile_number": "9876543210",
  "role": "admin"
}
```

**Error Response (400 Bad Request):**
```json
{
  "status": "false",
  "message": "email not received\npassword not received"
}
```

**Error Response (401 Unauthorized):**
```json
{
  "status": "false",
  "message": "Invalid email or admin not found"
}
```

---

### 4. Password Reset Request

**Endpoint:** `POST /password_reset.php`

**Request Contract:**
```typescript
{
  email: Email  // Required, must exist in users table
}
```

**Request Example:**
```json
{
  "email": "john@example.com"
}
```

**Success Response (200 OK):**
```json
{
  "status": "true",
  "message": "Password reset OTP sent to your email",
  "otp": "123456"  // 6-digit OTP (for testing, remove in production)
}
```

**Error Response (400 Bad Request):**
```json
{
  "status": "false",
  "message": "email not received"
}
```

**Error Response (404 Not Found):**
```json
{
  "status": "false",
  "message": "User not found"
}
```

**Business Rules:**
- Generates 6-digit OTP
- OTP should be sent via email (currently returned in response for testing)
- OTP should expire after a set time (implementation pending)

---

### 5. Password Update

**Endpoint:** `POST /password_update.php`

**Request Contract:**
```typescript
{
  email: Email,        // Required, must exist in users table
  otp: String,         // Required, 6-digit OTP from password reset
  newPassword: String   // Required, non-empty, will be MD5 hashed
}
```

**Request Example:**
```json
{
  "email": "john@example.com",
  "otp": "123456",
  "newPassword": "newpassword123"
}
```

**Success Response (200 OK):**
```json
{
  "status": "true",
  "message": "Password updated successfully"
}
```

**Error Response (400 Bad Request):**
```json
{
  "status": "false",
  "message": "email not received\notp not received\nnewPassword not received"
}
```

**Error Response (401 Unauthorized):**
```json
{
  "status": "false",
  "message": "Invalid OTP"
}
```

**Business Rules:**
- OTP must be valid and not expired
- New password is MD5 hashed before storage

---

## User Management APIs

### 6. Get All Users (Admin)

**Endpoint:** `GET /users.php`

**Request:** No request body

**Success Response (200 OK):**
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

**Empty Response (200 OK):**
```json
[]
```

**Note:** Returns array of user objects. Empty array if no users found.

---

### 7. Update User Status (Admin)

**Endpoint:** `POST /update_user_status.php`

**Request Contract:**
```typescript
{
  user_id: Integer,                    // Required, must exist
  status: "Active" | "Inactive"         // Required, enum value
}
```

**Request Example:**
```json
{
  "user_id": 123,
  "status": "Inactive"
}
```

**Success Response (200 OK):**
```json
{
  "status": "true",
  "message": "User status updated successfully"
}
```

**Error Response (400 Bad Request):**
```json
{
  "status": "false",
  "message": "user_id not received\nstatus not received"
}
```

**Error Response (404 Not Found):**
```json
{
  "status": "false",
  "message": "User not found"
}
```

**Validation Rules:**
- `user_id`: Required, must be valid integer, must exist in users table
- `status`: Required, must be exactly "Active" or "Inactive"

---

## Department & Category APIs

### 8. Get All Departments

**Endpoint:** `GET /departments.php`

**Request:** No request body

**Success Response (200 OK):**
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

**Empty Response (200 OK):**
```json
[]
```

**Business Rules:**
- Returns only departments with status "Active"
- Ordered by timestamp (newest first)

---

### 9. Get Categories

**Endpoint:** `POST /categories.php`

**Request Contract:**
```typescript
{
  department_id?: Integer  // Optional, filter by department
}
```

**Request Example (All Categories):**
```json
{}
```

**Request Example (Filtered by Department):**
```json
{
  "department_id": 1
}
```

**Success Response (200 OK):**
```json
[
  {
    "category_id": 1,
    "category_name": "HR",
    "department_id": 1,
    "department_name": "Forest",
    "status": "Active",
    "timestamp": "2025-01-07 13:30:00"
  }
]
```

**Empty Response (200 OK):**
```json
[]
```

**Business Rules:**
- If `department_id` provided, returns only categories for that department
- If `department_id` not provided, returns all active categories
- Only returns categories with status "Active"

---

### 10. Add Category (Admin)

**Endpoint:** `POST /add_category.php`

**Request Contract:**
```typescript
{
  category_name: String,   // Required, non-empty, max 255 chars
  department_id: Integer   // Required, must exist in department table
}
```

**Request Example:**
```json
{
  "category_name": "New Category",
  "department_id": 1
}
```

**Success Response (200 OK):**
```json
{
  "status": "true",
  "message": "Category added successfully",
  "category_id": 15
}
```

**Error Response (400 Bad Request):**
```json
{
  "status": "false",
  "message": "category_name not received\ndepartment_id not received"
}
```

**Error Response (404 Not Found):**
```json
{
  "status": "false",
  "message": "Department not found"
}
```

**Validation Rules:**
- `category_name`: Required, non-empty string, max 255 characters
- `department_id`: Required, must be valid integer, must exist in department table

**Business Rules:**
- Category is created with status "Active" by default

---

### 11. Update Category (Admin)

**Endpoint:** `POST /update_category.php`

**Request Contract:**
```typescript
{
  category_id: Integer,    // Required, must exist
  category_name: String     // Required, non-empty, max 255 chars
}
```

**Request Example:**
```json
{
  "category_id": 15,
  "category_name": "Updated Category Name"
}
```

**Success Response (200 OK):**
```json
{
  "status": "true",
  "message": "Category updated successfully"
}
```

**Error Response (400 Bad Request):**
```json
{
  "status": "false",
  "message": "category_id not received\ncategory_name not received"
}
```

**Error Response (404 Not Found):**
```json
{
  "status": "false",
  "message": "Category not found"
}
```

---

### 12. Delete Category (Admin)

**Endpoint:** `POST /delete_category.php`

**Request Contract:**
```typescript
{
  category_id: Integer  // Required, must exist
}
```

**Request Example:**
```json
{
  "category_id": 15
}
```

**Success Response (200 OK):**
```json
{
  "status": "true",
  "message": "Category deleted successfully"
}
```

**Error Response (400 Bad Request):**
```json
{
  "status": "false",
  "message": "category_id not received"
}
```

**Error Response (409 Conflict):**
```json
{
  "status": "false",
  "message": "Category has associated documents"
}
```

**Business Rules:**
- Soft delete (sets status to "Inactive")
- Cannot delete if category has associated active documents

---

### 13. Get Districts

**Endpoint:** `GET /districts.php`

**Request:** No request body

**Success Response (200 OK):**
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

**Note:** Currently returns static data for 36 districts in Maharashtra.

---

## Document Management APIs

### 14. Get Documents

**Endpoint:** `POST /documents.php`

**Request Contract:**
```typescript
{
  department?: String,      // Optional, partial match on department_name
  date?: Date,              // Optional, exact match on gr_date (YYYY-MM-DD)
  search?: String,          // Optional, searches in title and description
  category_id?: Integer     // Optional, filter by category
}
```

**Request Example (All Documents):**
```json
{}
```

**Request Example (With Filters):**
```json
{
  "department": "Forest",
  "date": "2025-01-07",
  "search": "GR notification",
  "category_id": 1
}
```

**Success Response (200 OK):**
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

**Empty Response (200 OK):**
```json
{
  "message": "No documents found",
  "status": "false"
}
```

**Business Rules:**
- All filters are optional and can be combined
- Returns only documents with status "Active"
- Ordered by upload_date DESC (newest first)
- `department` uses LIKE search (partial match)
- `search` searches in both title and description (LIKE search)
- `date` requires exact match (YYYY-MM-DD format)
- `category_id` requires exact match

---

### 15. Get Document Details

**Endpoint:** `POST /document_details.php`

**Request Contract:**
```typescript
{
  document_id: Integer,  // Required, must exist
  user_id?: Integer      // Optional, for access logging
}
```

**Request Example:**
```json
{
  "document_id": 1,
  "user_id": 123
}
```

**Success Response (200 OK):**
```json
{
  "document_id": 1,
  "title": "Forest GR Notification",
  "description": "Important notification about forest regulations",
  "category_id": 1,
  "category_name": "HR",
  "department_name": "Forest",
  "file_type": "application/pdf",
  "file_url": "uploads/Forest/HR/gr_123456.pdf",
  "gr_date": "2025-01-07",
  "upload_date": "2025-01-07 13:30:00",
  "uploaded_by": 1,
  "status": "Active"
}
```

**Error Response (400 Bad Request):**
```json
{
  "status": "false",
  "message": "document_id not received"
}
```

**Error Response (404 Not Found):**
```json
{
  "status": "false",
  "message": "Document not found"
}
```

**Business Rules:**
- If `user_id` provided, logs document access in `document_access_logs` table
- Returns only active documents

---

### 16. Upload Document (Admin)

**Endpoint:** `POST /document_upload.php`

**Content-Type:** `multipart/form-data` (not `application/json`)

**Request Contract:**
```typescript
{
  title: String,              // Required, non-empty, max 255 chars
  description?: String,        // Optional
  category_id: Integer,        // Required, must exist
  gr_date: Date,               // Required, format YYYY-MM-DD
  uploaded_by?: Integer,       // Optional, admin_id
  file: File                   // Required, multipart file upload
}
```

**Request Example (Form Data):**
```
title: Forest GR Notification
description: Important notification about forest regulations
category_id: 1
gr_date: 2025-01-07
uploaded_by: 1
file: [PDF/Image file]
```

**Success Response (200 OK):**
```json
{
  "status": "true",
  "message": "Document uploaded successfully",
  "document_id": 2,
  "file_url": "uploads/Forest/HR/gr_678901.pdf"
}
```

**Error Response (400 Bad Request):**
```json
{
  "status": "false",
  "message": "title not received\ncategory_id not received\ngr_date not received\nfile not received"
}
```

**Error Response (400 Bad Request - File Validation):**
```json
{
  "status": "false",
  "message": "Invalid file type. Allowed types: PDF, JPG, JPEG, PNG, DOC, DOCX\nFile size exceeds 10MB limit"
}
```

**File Requirements:**
- **Maximum size:** 10MB (10 * 1024 * 1024 bytes)
- **Allowed types:** PDF, JPG, JPEG, PNG, DOC, DOCX
- **Storage:** Files stored in `uploads/{category_name}/` directory
- **Filename:** Sanitized and prefixed with `gr_` + unique ID + timestamp

**Validation Rules:**
- `title`: Required, non-empty string, max 255 characters
- `description`: Optional string
- `category_id`: Required, must be valid integer, must exist in categories table
- `gr_date`: Required, format YYYY-MM-DD
- `uploaded_by`: Optional integer (admin_id)
- `file`: Required, must pass type and size validation

**Business Rules:**
- File is stored in category-specific folder
- Filename is sanitized and made unique
- Document is created with status "Active" by default
- File extension is preserved

---

### 17. Update Document (Admin)

**Endpoint:** `POST /update_document.php`

**Request Contract:**
```typescript
{
  document_id: Integer,    // Required, must exist
  title?: String,           // Optional, max 255 chars
  description?: String,     // Optional
  category_id?: Integer,    // Optional, must exist
  gr_date?: Date           // Optional, format YYYY-MM-DD
}
```

**Request Example:**
```json
{
  "document_id": 1,
  "title": "Updated Forest GR Notification",
  "description": "Updated description",
  "category_id": 2,
  "gr_date": "2025-01-08"
}
```

**Success Response (200 OK):**
```json
{
  "status": "true",
  "message": "Document updated successfully"
}
```

**Error Response (400 Bad Request):**
```json
{
  "status": "false",
  "message": "document_id not received"
}
```

**Error Response (404 Not Found):**
```json
{
  "status": "false",
  "message": "Document not found"
}
```

**Business Rules:**
- At least one field besides `document_id` must be provided
- Only provided fields are updated

---

### 18. Delete Document (Admin)

**Endpoint:** `POST /delete_document.php`

**Request Contract:**
```typescript
{
  document_id: Integer  // Required, must exist
}
```

**Request Example:**
```json
{
  "document_id": 1
}
```

**Success Response (200 OK):**
```json
{
  "status": "true",
  "message": "Document deleted successfully"
}
```

**Error Response (400 Bad Request):**
```json
{
  "status": "false",
  "message": "document_id not received"
}
```

**Error Response (404 Not Found):**
```json
{
  "status": "false",
  "message": "Document not found"
}
```

**Business Rules:**
- Soft delete (sets status to "Inactive")
- Physical file is not deleted from server

---

### 19. Download Document

**Endpoint:** `POST /download_document.php`

**Request Contract:**
```typescript
{
  document_id: Integer  // Required, must exist
}
```

**Request Example:**
```json
{
  "document_id": 1
}
```

**Success Response (200 OK):**
- **Content-Type:** Based on file type (e.g., `application/pdf`, `image/jpeg`)
- **Content-Disposition:** `attachment; filename="original_filename.ext"`
- **Body:** Binary file content

**Error Response (400 Bad Request):**
```json
{
  "status": "false",
  "message": "document_id not received"
}
```

**Error Response (404 Not Found):**
```json
{
  "status": "false",
  "message": "Document not found"
}
```

**Business Rules:**
- Returns actual file content
- File path is constructed from `file_url` in database
- Access should be logged (implementation pending)

---

### 20. Share Document

**Endpoint:** `POST /share_document.php`

**Request Contract:**
```typescript
{
  document_id: Integer  // Required, must exist
}
```

**Request Example:**
```json
{
  "document_id": 1
}
```

**Success Response (200 OK):**
```json
{
  "status": "true",
  "message": "Shareable link generated successfully",
  "share_url": "https://yourdomain.com/api/shared_document.php?token=gr_123456_1234567890",
  "token": "gr_123456_1234567890"
}
```

**Error Response (400 Bad Request):**
```json
{
  "status": "false",
  "message": "document_id not received"
}
```

**Business Rules:**
- Generates unique token for sharing
- Token format: `gr_{unique_id}_{timestamp}`
- Share URL includes token as query parameter

---

### 21. Access Shared Document

**Endpoint:** `GET /shared_document.php?token={token}`

**Request:** Query parameter `token` (required)

**Success Response (200 OK):**
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

**Error Response (400 Bad Request):**
```json
{
  "status": "false",
  "message": "Token not provided"
}
```

**Error Response (404 Not Found):**
```json
{
  "status": "false",
  "message": "Invalid or expired token"
}
```

**Business Rules:**
- Token must be valid and not expired
- Returns document details without requiring authentication

---

### 22. Document Access Logs (Admin)

**Endpoint:** `POST /document_access_logs.php`

**Request Contract:**
```typescript
{
  document_id?: Integer,  // Optional, filter by document
  user_id?: Integer       // Optional, filter by user
}
```

**Request Example (All Logs):**
```json
{}
```

**Request Example (Filtered):**
```json
{
  "document_id": 1,
  "user_id": 123
}
```

**Success Response (200 OK):**
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

**Empty Response (200 OK):**
```json
[]
```

**Business Rules:**
- All filters are optional
- Returns only logs with status "Active"
- Ordered by timestamp DESC (newest first)

---

## Notification & Feedback APIs

### 23. Get Notifications

**Endpoint:** `POST /notifications.php`

**Request Contract:**
```typescript
{
  user_id?: Integer  // Optional, filter by user (currently not implemented)
}
```

**Request Example:**
```json
{
  "user_id": 123
}
```

**Success Response (200 OK):**
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

**Empty Response (200 OK):**
```json
[]
```

**Note:** Currently returns all notifications. User-specific filtering pending implementation.

---

### 24. Submit Suggestion/Feedback

**Endpoint:** `POST /suggestions.php`

**Request Contract:**
```typescript
{
  message: String,        // Required, non-empty
  contact?: String,        // Optional, email or phone
  user_id?: Integer        // Optional
}
```

**Request Example:**
```json
{
  "message": "Please add more categories for better organization",
  "contact": "john@example.com",
  "user_id": 123
}
```

**Success Response (200 OK):**
```json
{
  "status": "true",
  "message": "Suggestion submitted successfully"
}
```

**Error Response (400 Bad Request):**
```json
{
  "status": "false",
  "message": "message not received"
}
```

**Note:** Currently returns success message. Database persistence pending implementation.

---

## Admin Management APIs

### 25. Get All Admin Users

**Endpoint:** `GET /admin_users.php`

**Request:** No request body

**Success Response (200 OK):**
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

**Empty Response (200 OK):**
```json
[]
```

**Business Rules:**
- Returns only admin users with status "Active"
- Ordered by timestamp DESC

---

## Subject Master APIs

### 26. Fetch Subjects

**Endpoint:** `POST /fetch_subjects.php`

**Request Contract:**
```typescript
{
  status?: "Active" | "Inactive"  // Optional, filter by status
}
```

**Request Example (All Subjects):**
```json
{}
```

**Request Example (Active Only):**
```json
{
  "status": "Active"
}
```

**Success Response (200 OK):**
```json
[
  {
    "subject_id": 1,
    "subject_name": "Subject Name",
    "status": "Active",
    "timestamp": "2025-01-07 13:30:00"
  }
]
```

**Empty Response (200 OK):**
```json
[]
```

---

### 27. Fetch Categories (Subject-based)

**Endpoint:** `GET /fetch_categories.php?subject_id={subject_id}`

**Request:** Query parameter `subject_id` (required)

**Success Response (200 OK):**
```json
[
  {
    "category_id": 1,
    "category_name": "Category Name",
    "subject_id": 1,
    "status": "Active"
  }
]
```

---

### 28. Fetch Subcategories

**Endpoint:** `GET /fetch_subcategories.php?category_id={category_id}`

**Request:** Query parameter `category_id` (required)

**Success Response (200 OK):**
```json
[
  {
    "subcategory_id": 1,
    "subcategory_name": "Subcategory Name",
    "category_id": 1,
    "status": "Active"
  }
]
```

---

### 29. Fetch GR (Government Resolutions)

**Endpoint:** `POST /fetch_gr.php`

**Request Contract:**
```typescript
{
  subcategory_id?: Integer,  // Optional, filter by subcategory
  date?: Date,                // Optional, filter by date
  search?: String             // Optional, search in title/description
}
```

**Request Example:**
```json
{
  "subcategory_id": 1,
  "date": "2025-01-07",
  "search": "notification"
}
```

**Success Response (200 OK):**
```json
[
  {
    "gr_id": 1,
    "title": "GR Title",
    "description": "GR Description",
    "file_url": "uploads/gr_123.pdf",
    "gr_date": "2025-01-07",
    "subcategory_id": 1,
    "status": "Active"
  }
]
```

---

## Testing & Validation

### Client-Side Validation Checklist

Before making API calls, validate:

1. **Required Fields:** All required fields are present
2. **Data Types:** Fields match expected types
3. **Format Validation:**
   - Email format (regex: `/^[^\s@]+@[^\s@]+\.[^\s@]+$/`)
   - Mobile format (regex: `/^[6-9]\d{9}$/`)
   - Date format (YYYY-MM-DD)
4. **Length Validation:**
   - String max lengths
   - File size limits
5. **Enum Values:** Status fields match allowed values

### Error Handling Best Practices

1. **Always check response status** (handle both boolean and string)
2. **Parse error messages** (may contain multiple errors separated by `\n`)
3. **Show user-friendly messages** (translate technical errors)
4. **Log errors for debugging** (when `AppConfig.enableLogging` is true)
5. **Handle network errors** (timeout, connection errors)

### Example Error Handling (Flutter/Dart)

```dart
try {
  final response = await ApiService.loginUser(
    email: email,
    password: password,
  );
  
  // Check status (handle both boolean and string)
  final status = response["status"];
  final isSuccess = status == true || 
                    status?.toString().toLowerCase() == "true";
  
  if (isSuccess) {
    // Handle success
    final userId = response["user_id"];
    // Navigate to home
  } else {
    // Handle error
    final message = (response["message"] ?? "Login failed").toString();
    _showError(message);
  }
} on DioException catch (e) {
  // Handle network errors
  if (e.type == DioExceptionType.connectionTimeout) {
    _showError("Connection timeout. Please check your internet.");
  } else if (e.type == DioExceptionType.connectionError) {
    _showError("No internet connection.");
  } else {
    _showError("Network error: ${e.message}");
  }
} catch (e) {
  // Handle unexpected errors
  _showError("An unexpected error occurred: $e");
}
```

---

## Version History

- **v2.0** (January 2025): Comprehensive API contracts with detailed schemas
- **v1.0** (November 2024): Initial API documentation

---

## Notes

1. **Status Field:** May be boolean `true`/`false` or string `"true"`/`"false"`. Always check both formats.

2. **Date Formats:** 
   - Dates: `YYYY-MM-DD` (e.g., `2025-01-07`)
   - DateTime: `YYYY-MM-DD HH:MM:SS` (e.g., `2025-01-07 13:30:00`)

3. **File Uploads:** Use `multipart/form-data` content type, not `application/json`.

4. **Error Messages:** May contain multiple errors separated by `\n`. Parse and display appropriately.

5. **Empty Arrays:** Endpoints returning arrays return empty array `[]` when no data found, not error response.

6. **Soft Deletes:** Delete operations set status to "Inactive", don't physically delete records.

7. **Password Security:** Currently using MD5 hashing. Upgrade to bcrypt/Argon2 recommended (see `api_improvements.md`).

---

**Last Updated:** January 2025  
**Version:** 2.0

