# API Improvements for Maha GR App

## 🔧 **Immediate Fixes Required**

### 1. **Fix Login Authentication**
```php
// Current login.php - BROKEN
$password_md5 = md5($password);
$query = "SELECT `user_id`, `email`, `mobile`, `status` FROM `users` WHERE `email` = :email AND `status` = 'Active'";

// Fixed login.php
$query = "SELECT `user_id`, `email`, `mobile`, `password`, `status` FROM `users` WHERE `email` = :email AND `status` = 'Active'";
$statement = $connect->prepare($query);
$statement->execute(array(':email' => $email));
$result = $statement->fetch();

if ($result && password_verify($password, $result['password'])) {
    // Login successful
    $token = generateJWT($result['user_id'], $result['email']);
    // Return token
}
```

### 2. **Add Authorization Middleware**
```php
// Create middleware/auth.php
function requireAuth() {
    $headers = getallheaders();
    $token = isset($headers['Authorization']) ? str_replace('Bearer ', '', $headers['Authorization']) : null;
    
    if (!$token) {
        sendErrorResponse('Authorization token required', 401);
    }
    
    $payload = verifyJWT($token);
    if (!$payload) {
        sendErrorResponse('Invalid or expired token', 401);
    }
    
    return $payload;
}

function requireAdmin() {
    $user = requireAuth();
    if ($user['role'] !== 'admin') {
        sendErrorResponse('Admin access required', 403);
    }
    return $user;
}
```

### 3. **Implement Proper Error Handling**
```php
// Replace all error responses with consistent format
function handleAPIError($message, $code = 400) {
    http_response_code($code);
    echo json_encode([
        'status' => 'false',
        'message' => $message,
        'code' => $code,
        'timestamp' => date('Y-m-d H:i:s')
    ]);
    exit();
}
```

### 4. **Fix File Upload Security**
```php
// Enhanced document_upload.php
$file_validation = validateFileUpload($_FILES['file']);
if (!$file_validation['valid']) {
    handleAPIError($file_validation['error']);
}

// Add virus scanning
if (!scanFileForVirus($_FILES['file']['tmp_name'])) {
    handleAPIError('File appears to be malicious');
}

// Generate secure filename
$secure_filename = generateSecureFilename($_FILES['file']['name']);
```

## 📊 **API Endpoint Analysis**

### ✅ **Working Endpoints**
- `departments.php` - GET departments
- `categories.php` - GET categories by department
- `documents.php` - GET documents with filters
- `document_details.php` - GET single document
- `shared_document.php` - GET shared document

### ⚠️ **Endpoints with Issues**
- `register.php` - Missing password verification
- `login.php` - No password verification
- `admin_login.php` - No password verification
- `document_upload.php` - Security vulnerabilities
- `suggestions.php` - No database storage
- `districts.php` - Static data, should be database-driven

### ❌ **Missing Endpoints**
- User profile management
- Password change (authenticated)
- Document versioning
- Bulk document operations
- Advanced search with filters
- User activity logs
- Admin dashboard statistics

## 🔒 **Security Recommendations**

### 1. **Authentication Flow**
```php
// Implement proper authentication
POST /auth/login
{
    "email": "user@example.com",
    "password": "password123"
}

Response:
{
    "status": "true",
    "token": "jwt_token_here",
    "user": {
        "user_id": 123,
        "email": "user@example.com",
        "role": "user"
    }
}
```

### 2. **Protected Endpoints**
```php
// All sensitive endpoints should require authentication
GET /api/documents - Requires valid JWT
POST /api/documents - Requires admin JWT
DELETE /api/documents/{id} - Requires admin JWT
```

### 3. **Rate Limiting**
```php
// Implement rate limiting per IP
- Login attempts: 5 per minute
- File uploads: 10 per hour
- API calls: 1000 per hour
```

## 📈 **Performance Improvements**

### 1. **Database Optimization**
```sql
-- Add composite indexes
CREATE INDEX idx_documents_category_date ON documents(category_id, gr_date);
CREATE INDEX idx_documents_search ON documents(title, description);
```

### 2. **Caching Strategy**
```php
// Implement Redis caching for:
- Department list
- Category list
- Frequently accessed documents
- User sessions
```

### 3. **File Storage Optimization**
```php
// Implement CDN for file storage
- Use AWS S3 or similar for file storage
- Implement file compression
- Add image thumbnails for previews
```

## 🧪 **Testing Recommendations**

### 1. **Unit Tests**
```php
// Test authentication
testUserLogin()
testAdminLogin()
testPasswordVerification()

// Test file uploads
testFileValidation()
testVirusScanning()
testFileSizeLimits()
```

### 2. **Integration Tests**
```php
// Test complete workflows
testDocumentUploadWorkflow()
testUserRegistrationWorkflow()
testDocumentSharingWorkflow()
```

### 3. **Security Tests**
```php
// Test security vulnerabilities
testSQLInjection()
testXSSAttacks()
testFileUploadVulnerabilities()
testAuthenticationBypass()
```

## 📋 **Implementation Priority**

### **Phase 1 (Critical - Immediate)**
1. Fix password authentication
2. Implement JWT tokens
3. Add input validation
4. Fix file upload security

### **Phase 2 (Important - Next Sprint)**
1. Add missing database tables
2. Implement proper error handling
3. Add rate limiting
4. Create audit logs

### **Phase 3 (Enhancement - Future)**
1. Add caching layer
2. Implement CDN
3. Add advanced search
4. Create admin dashboard

## 🔍 **Monitoring & Logging**

### 1. **Application Logs**
```php
// Log all API requests
function logAPIRequest($endpoint, $method, $user_id, $status_code) {
    $log_entry = [
        'timestamp' => date('Y-m-d H:i:s'),
        'endpoint' => $endpoint,
        'method' => $method,
        'user_id' => $user_id,
        'status_code' => $status_code,
        'ip_address' => $_SERVER['REMOTE_ADDR']
    ];
    // Store in database or log file
}
```

### 2. **Error Monitoring**
```php
// Monitor for errors
function logError($error, $context) {
    // Send to error monitoring service
    // Log to database
    // Alert administrators for critical errors
}
```

### 3. **Performance Monitoring**
```php
// Monitor API performance
function logPerformance($endpoint, $execution_time) {
    // Track response times
    // Identify slow endpoints
    // Monitor database query performance
}
```
