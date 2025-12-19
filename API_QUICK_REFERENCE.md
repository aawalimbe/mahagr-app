# Maha GR API - Quick Reference

## Base URL
```
http://localhost/mahagr/api/
```

## Authentication Endpoints

| Method | Endpoint | Description | Auth Required |
|--------|----------|-------------|---------------|
| POST | `/register.php` | User registration | No |
| POST | `/login.php` | User login | No |
| POST | `/admin_login.php` | Admin login | No |
| POST | `/password_reset.php` | Request password reset | No |
| POST | `/password_update.php` | Update password with OTP | No |

## User Management

| Method | Endpoint | Description | Auth Required |
|--------|----------|-------------|---------------|
| GET | `/users.php` | Get all users | Admin |
| POST | `/update_user_status.php` | Update user status | Admin |
| GET | `/admin_users.php` | Get admin users | Admin |

## Content Management

| Method | Endpoint | Description | Auth Required |
|--------|----------|-------------|---------------|
| GET | `/departments.php` | Get all departments | No |
| POST | `/categories.php` | Get categories (optional dept filter) | No |
| POST | `/add_category.php` | Add new category | Admin |
| POST | `/update_category.php` | Update category | Admin |
| POST | `/delete_category.php` | Delete category | Admin |
| GET | `/districts.php` | Get Maharashtra districts | No |

## Document Management

| Method | Endpoint | Description | Auth Required |
|--------|----------|-------------|---------------|
| POST | `/documents.php` | Get documents with filters | No |
| POST | `/document_details.php` | Get document details | No |
| POST | `/document_upload.php` | Upload document | Admin |
| POST | `/update_document.php` | Update document | Admin |
| POST | `/delete_document.php` | Delete document | Admin |
| POST | `/download_document.php` | Download document | No |
| POST | `/share_document.php` | Generate share link | No |
| GET | `/shared_document.php` | Access shared document | No |
| POST | `/document_access_logs.php` | Get access logs | Admin |

## Notifications & Feedback

| Method | Endpoint | Description | Auth Required |
|--------|----------|-------------|---------------|
| POST | `/notifications.php` | Get notifications | No |
| POST | `/suggestions.php` | Submit suggestion | No |

## Common Request Headers

```http
Content-Type: application/json
Access-Control-Allow-Origin: *
```

## Response Format

### Success
```json
{
    "status": "true",
    "message": "Operation successful",
    "data": {...}
}
```

### Error
```json
{
    "status": "false",
    "message": "Error description"
}
```

## File Upload

- **Max Size**: 10MB
- **Allowed Types**: PDF, JPG, JPEG, PNG, DOC, DOCX
- **Storage**: `uploads/{category_name}/`
- **Naming**: `gr_{unique_id}_{filename}`

## Key Parameters

### User Registration
```json
{
    "name": "string (required)",
    "email": "string (required, unique)",
    "password": "string (required)",
    "mobile": "string (required, 10 digits, 6-9 start)",
    "userType": "string (required)",
    "district": "string (required)",
    "department": "string (optional)"
}
```

### Document Search
```json
{
    "department": "string (optional)",
    "date": "YYYY-MM-DD (optional)",
    "search": "string (optional)",
    "category_id": "integer (optional)"
}
```

### Category Operations
```json
{
    "category_name": "string (required)",
    "department_id": "integer (required)"
}
```

## Error Messages

| Error | Meaning | Solution |
|-------|---------|----------|
| `field_name not received` | Missing field | Add required field |
| `field_name can not be empty` | Empty value | Provide valid value |
| `Invalid email format` | Bad email | Use valid email format |
| `Invalid mobile number format` | Bad mobile | Use 10-digit Indian number |
| `User with this email or mobile already exists` | Duplicate | Use different email/mobile |
| `File size exceeds 10MB limit` | File too large | Compress or use smaller file |
| `Invalid file type` | Bad file type | Use allowed file types |

## Testing

### Test Upload
```bash
php test_upload.php
```

### Test Registration
```bash
curl -X POST http://localhost/mahagr/api/register.php \
  -H "Content-Type: application/json" \
  -d '{"name":"Test","email":"test@example.com","password":"pass123","mobile":"9876543210","userType":"Employee","district":"Mumbai"}'
```

### Test Login
```bash
curl -X POST http://localhost/mahagr/api/login.php \
  -H "Content-Type: application/json" \
  -d '{"email":"test@example.com","password":"pass123"}'
```

## Database Tables

- `users` - User accounts
- `admin_users` - Admin accounts
- `department` - Departments
- `categories` - Document categories
- `documents` - Document metadata
- `document_access_logs` - Access tracking
- `notifications` - System notifications
- `suggestions` - User feedback
- `districts` - Maharashtra districts

## Security Notes

- ✅ PDO prepared statements
- ✅ Input validation
- ✅ File type validation
- ⚠️ MD5 passwords (upgrade needed)
- 🔄 Rate limiting structure available

## Quick Integration

### JavaScript
```javascript
const apiCall = async (endpoint, data = {}) => {
    const response = await fetch(`http://localhost/mahagr/api/${endpoint}`, {
        method: 'POST',
        headers: {'Content-Type': 'application/json'},
        body: JSON.stringify(data)
    });
    return response.json();
};
```

### PHP
```php
function apiCall($endpoint, $data = []) {
    $ch = curl_init();
    curl_setopt($ch, CURLOPT_URL, "http://localhost/mahagr/api/$endpoint");
    curl_setopt($ch, CURLOPT_POST, true);
    curl_setopt($ch, CURLOPT_POSTFIELDS, json_encode($data));
    curl_setopt($ch, CURLOPT_HTTPHEADER, ['Content-Type: application/json']);
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
    $response = curl_exec($ch);
    curl_close($ch);
    return json_decode($response, true);
}
```

---

**For detailed documentation**: See `API_DOCUMENTATION.md`  
**For setup instructions**: See `README.md`  
**Last Updated**: January 7, 2025
