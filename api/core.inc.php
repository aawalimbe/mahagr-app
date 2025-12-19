<?php
error_reporting(E_ALL);
ini_set('display_errors', '1');

ob_start();

date_default_timezone_set('Asia/Kolkata');
$timestamp = date('Y-m-d');

// Generate unique token for sharing
function generateUniqueToken() {
    return uniqid('gr_', true) . '_' . time();
}

// Generate OTP for password reset
function generateOTP() {
    return str_pad(rand(0, 999999), 6, '0', STR_PAD_LEFT);
}

// Validate email format
function validateEmail($email) {
    return filter_var($email, FILTER_VALIDATE_EMAIL);
}

// Validate mobile number (Indian format)
function validateMobile($mobile) {
    return preg_match('/^[6-9]\d{9}$/', $mobile);
}

// Get department name by ID
function getDepartmentName($connect, $department_id) {
    $query = "SELECT department_name FROM department WHERE department_id = :department_id AND status = 'Active'";
    $statement = $connect->prepare($query);
    $statement->execute(array(':department_id' => $department_id));
    $result = $statement->fetch();
    return $result ? $result['department_name'] : null;
}

// Get category name by ID
function getCategoryName($connect, $category_id) {
    $query = "SELECT category_name FROM categories WHERE category_id = :category_id AND status = 'Active'";
    $statement = $connect->prepare($query);
    $statement->execute(array(':category_id' => $category_id));
    $result = $statement->fetch();
    return $result ? $result['category_name'] : null;
}

// Get user details by ID
function getUserDetails($connect, $user_id) {
    $query = "SELECT user_id, email, mobile, status FROM users WHERE user_id = :user_id AND status = 'Active'";
    $statement = $connect->prepare($query);
    $statement->execute(array(':user_id' => $user_id));
    return $statement->fetch(PDO::FETCH_ASSOC);
}

// Get admin details by ID
function getAdminDetails($connect, $admin_id) {
    $query = "SELECT admin_id, name, email, mobile_number, role FROM admin_users WHERE admin_id = :admin_id AND status = 'Active'";
    $statement = $connect->prepare($query);
    $statement->execute(array(':admin_id' => $admin_id));
    return $statement->fetch(PDO::FETCH_ASSOC);
}

// Get document details by ID
function getDocumentDetails($connect, $document_id) {
    $query = "SELECT d.*, c.category_name, dept.department_name 
              FROM documents d 
              LEFT JOIN categories c ON d.category_id = c.category_id 
              LEFT JOIN department dept ON c.department_id = dept.department_id 
              WHERE d.document_id = :document_id AND d.status = 'Active'";
    $statement = $connect->prepare($query);
    $statement->execute(array(':document_id' => $document_id));
    return $statement->fetch(PDO::FETCH_ASSOC);
}

// Log document access
function logDocumentAccess($connect, $user_id, $document_id) {
    $query = "INSERT INTO document_access_logs (user_id, document_id, status) VALUES (:user_id, :document_id, 'Active')";
    $statement = $connect->prepare($query);
    return $statement->execute(array(
        ':user_id' => $user_id,
        ':document_id' => $document_id
    ));
}

// Check if user exists
function userExists($connect, $email, $mobile = null) {
    $query = "SELECT user_id FROM users WHERE (email = :email";
    $params = array(':email' => $email);
    
    if ($mobile) {
        $query .= " OR mobile = :mobile";
        $params[':mobile'] = $mobile;
    }
    
    $query .= ") AND status = 'Active'";
    $statement = $connect->prepare($query);
    $statement->execute($params);
    return $statement->rowCount() > 0;
}

// Check if admin exists
function adminExists($connect, $email) {
    $query = "SELECT admin_id FROM admin_users WHERE email = :email AND status = 'Active'";
    $statement = $connect->prepare($query);
    $statement->execute(array(':email' => $email));
    return $statement->rowCount() > 0;
}

// Format file size
function formatFileSize($bytes) {
    if ($bytes >= 1073741824) {
        return number_format($bytes / 1073741824, 2) . ' GB';
    } elseif ($bytes >= 1048576) {
        return number_format($bytes / 1048576, 2) . ' MB';
    } elseif ($bytes >= 1024) {
        return number_format($bytes / 1024, 2) . ' KB';
    } else {
        return $bytes . ' bytes';
    }
}

// Get file extension
function getFileExtension($filename) {
    return strtolower(pathinfo($filename, PATHINFO_EXTENSION));
}

// Validate file type
function validateFileType($filename, $allowed_types = ['pdf', 'jpg', 'jpeg', 'png', 'doc', 'docx']) {
    $extension = getFileExtension($filename);
    return in_array($extension, $allowed_types);
}

// Create upload directory if not exists
function createUploadDirectory($path) {
    if (!file_exists($path)) {
        mkdir($path, 0777, true);
    }
    return is_dir($path);
}

// Ensure uploads directory exists
function ensureUploadsDirectory() {
    $uploads_dir = __DIR__ . '/../uploads/';
    if (!is_dir($uploads_dir)) {
        mkdir($uploads_dir, 0777, true);
    }
    return is_dir($uploads_dir);
}

// Generate secure filename
function generateSecureFilename($original_name, $prefix = '') {
    $extension = getFileExtension($original_name);
    $unique_id = uniqid($prefix, true);
    $timestamp = time();
    return $unique_id . '_' . $timestamp . '.' . $extension;
}

// Validate and sanitize category name for folder
function sanitizeCategoryName($category_name) {
    return preg_replace('/[^A-Za-z0-9_-]/', '_', $category_name);
}

// Generate unique filename
function generateUniqueFilename($original_name, $prefix = '') {
    $extension = getFileExtension($original_name);
    $unique_id = uniqid($prefix, true);
    return $unique_id . '.' . $extension;
}

// Get total documents count
function getTotalDocuments($connect) {
    $query = "SELECT COUNT(*) as total FROM documents WHERE status = 'Active'";
    $statement = $connect->prepare($query);
    $statement->execute();
    $result = $statement->fetch();
    return $result['total'];
}

// Get total users count
function getTotalUsers($connect) {
    $query = "SELECT COUNT(*) as total FROM users WHERE status = 'Active'";
    $statement = $connect->prepare($query);
    $statement->execute();
    $result = $statement->fetch();
    return $result['total'];
}

// Get total departments count
function getTotalDepartments($connect) {
    $query = "SELECT COUNT(*) as total FROM department WHERE status = 'Active'";
    $statement = $connect->prepare($query);
    $statement->execute();
    $result = $statement->fetch();
    return $result['total'];
}

// Get total categories count
function getTotalCategories($connect) {
    $query = "SELECT COUNT(*) as total FROM categories WHERE status = 'Active'";
    $statement = $connect->prepare($query);
    $statement->execute();
    $result = $statement->fetch();
    return $result['total'];
}
?>
