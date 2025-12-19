# 📁 Document Upload Functionality - Maha GR App

## 🔄 **Updated Implementation**

The document upload functionality has been completely rewritten to follow the same pattern as the admin `action.php` file, ensuring consistency and proper folder organization.

## 📂 **Folder Structure**

```
mahagr/
├── api/
│   ├── document_upload.php (Updated)
│   ├── core.inc.php (Enhanced)
│   └── connect.inc.php
├── uploads/
│   ├── Category_Name_1/
│   │   ├── gr_64f8a1b2c3d4e_1698765432.pdf
│   │   └── gr_64f8a1b2c3d5f_1698765433.docx
│   ├── Category_Name_2/
│   │   └── gr_64f8a1b2c3d6g_1698765434.jpg
│   └── ...
└── admin/
    └── documents/
        └── action.php (Reference implementation)
```

## 🚀 **Key Features**

### 1. **Category-Based Organization**
- Documents are organized by category folders
- Each category gets its own folder under `uploads/`
- Category names are sanitized for safe folder creation

### 2. **Secure File Naming**
- Unique filenames prevent conflicts
- Format: `gr_[unique_id]_[timestamp].[extension]`
- Example: `gr_64f8a1b2c3d4e_1698765432.pdf`

### 3. **Automatic Directory Creation**
- Creates `uploads/` directory if it doesn't exist
- Creates category folders automatically
- Handles nested directory creation

### 4. **File Validation**
- Validates file types (PDF, JPG, JPEG, PNG, DOC, DOCX)
- Enforces 10MB file size limit
- Prevents malicious file uploads

### 5. **Error Handling & Cleanup**
- Removes uploaded files if database insertion fails
- Comprehensive error messages
- Proper rollback on failures

## 📋 **API Usage**

### **Endpoint:** `POST /api/document_upload.php`

### **Request Format:**
```http
POST /api/document_upload.php
Content-Type: multipart/form-data

Form Data:
- title: "Document Title"
- description: "Document Description"
- category_id: "1"
- gr_date: "2025-01-15"
- uploaded_by: "1" (optional)
- file: [PDF/Image/Document file]
```

### **Response (Success):**
```json
{
    "message": "Document uploaded successfully",
    "status": "true",
    "document_id": 123,
    "file_url": "uploads/HR/gr_64f8a1b2c3d4e_1698765432.pdf",
    "category_folder": "HR"
}
```

### **Response (Error):**
```json
{
    "message": "Invalid file type. Allowed types: PDF, JPG, JPEG, PNG, DOC, DOCX",
    "status": "false"
}
```

## 🔧 **Implementation Details**

### **1. Folder Creation Process**
```php
// 1. Ensure uploads directory exists
ensureUploadsDirectory();

// 2. Get category name from database
$cat_query = "SELECT category_name FROM categories WHERE category_id = :category_id AND status = 'Active'";

// 3. Sanitize category name for folder
$category_name = sanitizeCategoryName($cat_result['category_name']);

// 4. Create category folder
$upload_dir = __DIR__ . '/../uploads/' . $category_name;
if (!is_dir($upload_dir)) {
    mkdir($upload_dir, 0777, true);
}
```

### **2. File Upload Process**
```php
// 1. Generate secure filename
$unique_filename = generateSecureFilename($file_name, 'gr_');

// 2. Set target path
$target_path = $upload_dir . '/' . $unique_filename;

// 3. Move uploaded file
move_uploaded_file($file_path, $target_path);

// 4. Store relative path in database
$file_upload = 'uploads/' . $category_name . '/' . $unique_filename;
```

### **3. Error Handling**
```php
// If database insertion fails, remove uploaded file
if ($statement->rowCount() == 0) {
    if (!empty($file_upload) && file_exists($target_path)) {
        @unlink($target_path);
    }
    // Return error response
}
```

## 🛡️ **Security Features**

### **1. File Type Validation**
```php
function validateFileType($filename) {
    $allowed_types = ['pdf', 'jpg', 'jpeg', 'png', 'doc', 'docx'];
    $extension = strtolower(pathinfo($filename, PATHINFO_EXTENSION));
    return in_array($extension, $allowed_types);
}
```

### **2. Category Name Sanitization**
```php
function sanitizeCategoryName($category_name) {
    return preg_replace('/[^A-Za-z0-9_-]/', '_', $category_name);
}
```

### **3. Secure Filename Generation**
```php
function generateSecureFilename($original_name, $prefix = '') {
    $extension = pathinfo($original_name, PATHINFO_EXTENSION);
    $unique_id = uniqid($prefix, true);
    $timestamp = time();
    return $unique_id . '_' . $timestamp . '.' . $extension;
}
```

## 📊 **Database Integration**

### **Documents Table Structure**
```sql
CREATE TABLE documents (
    document_id INT PRIMARY KEY AUTO_INCREMENT,
    title TEXT,
    description TEXT,
    category_id INT,
    file_type TEXT,
    file_url TEXT,
    gr_date TEXT,
    uploaded_by INT,
    upload_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    status ENUM('Active', 'Inactive') DEFAULT 'Active'
);
```

### **File URL Storage**
- Stores relative path: `uploads/Category_Name/filename.ext`
- Enables easy file access and management
- Maintains folder structure information

## 🧪 **Testing**

### **Run Test Script:**
```bash
php test_upload.php
```

### **Manual Testing:**
1. Create a test file (PDF, JPG, etc.)
2. Use Postman or curl to test upload
3. Verify file appears in correct category folder
4. Check database entry is created correctly

### **Test with curl:**
```bash
curl -X POST \
  -F "title=Test Document" \
  -F "description=Test Description" \
  -F "category_id=1" \
  -F "gr_date=2025-01-15" \
  -F "file=@/path/to/test.pdf" \
  http://localhost/mahagr/api/document_upload.php
```

## 🔍 **Troubleshooting**

### **Common Issues:**

1. **"Failed to create category folder"**
   - Check write permissions on `mahagr/uploads/` directory
   - Ensure PHP has write access

2. **"Invalid category_id"**
   - Verify category exists in database
   - Check category status is 'Active'

3. **"File upload failed"**
   - Check file size (max 10MB)
   - Verify file type is allowed
   - Check disk space

4. **"Database insert failed"**
   - Check database connection
   - Verify table structure
   - Check for unique constraints

### **Debug Mode:**
Enable error reporting in `connect.inc.php`:
```php
error_reporting(E_ALL);
ini_set('display_errors', 1);
```

## 📈 **Performance Considerations**

### **1. File Size Limits**
- Maximum file size: 10MB
- Configurable in `document_upload.php`

### **2. Directory Structure**
- Flat structure for better performance
- No deep nesting

### **3. Filename Optimization**
- Unique filenames prevent conflicts
- Timestamp-based naming for easy sorting

## 🔄 **Migration from Old System**

If migrating from the old upload system:

1. **Backup existing files**
2. **Update file paths in database**
3. **Reorganize files into category folders**
4. **Test upload functionality**

### **Migration Script:**
```php
// Example migration script
$old_files = glob('uploads/*');
foreach ($old_files as $file) {
    // Move to appropriate category folder
    // Update database record
}
```

## 📝 **Future Enhancements**

### **Planned Features:**
1. **File compression** for large documents
2. **Thumbnail generation** for images
3. **Virus scanning** integration
4. **Cloud storage** (AWS S3) integration
5. **File versioning** support
6. **Bulk upload** functionality

### **Configuration Options:**
```php
// Configurable settings
define('MAX_FILE_SIZE', 10 * 1024 * 1024); // 10MB
define('ALLOWED_EXTENSIONS', ['pdf', 'jpg', 'jpeg', 'png', 'doc', 'docx']);
define('UPLOAD_DIR', __DIR__ . '/../uploads/');
define('FILE_PREFIX', 'gr_');
```

---

**Last Updated:** January 15, 2025  
**Version:** 2.0  
**Status:** Production Ready ✅
