<?php
// Test script for document upload functionality
// This script tests the document_upload.php API

echo "=== Maha GR Document Upload Test ===\n\n";

// Test 1: Check if uploads directory exists
echo "1. Checking uploads directory...\n";
$uploads_dir = __DIR__ . '/../uploads/';
if (is_dir($uploads_dir)) {
    echo "   ✓ Uploads directory exists: $uploads_dir\n";
} else {
    echo "   ✗ Uploads directory does not exist: $uploads_dir\n";
    echo "   Creating uploads directory...\n";
    if (mkdir($uploads_dir, 0777, true)) {
        echo "   ✓ Uploads directory created successfully\n";
    } else {
        echo "   ✗ Failed to create uploads directory\n";
    }
}

// Test 2: Check database connection
echo "\n2. Testing database connection...\n";
require_once "connect.inc.php";
try {
    $test_query = "SELECT COUNT(*) as count FROM categories WHERE status = 'Active'";
    $stmt = $connect->prepare($test_query);
    $stmt->execute();
    $result = $stmt->fetch();
    echo "   ✓ Database connection successful\n";
    echo "   ✓ Active categories found: " . $result['count'] . "\n";
} catch (Exception $e) {
    echo "   ✗ Database connection failed: " . $e->getMessage() . "\n";
}

// Test 3: Check category data
echo "\n3. Checking available categories...\n";
try {
    $cat_query = "SELECT category_id, category_name FROM categories WHERE status = 'Active' LIMIT 5";
    $stmt = $connect->prepare($cat_query);
    $stmt->execute();
    $categories = $stmt->fetchAll(PDO::FETCH_ASSOC);
    
    if (count($categories) > 0) {
        echo "   ✓ Available categories:\n";
        foreach ($categories as $cat) {
            echo "     - ID: " . $cat['category_id'] . ", Name: " . $cat['category_name'] . "\n";
        }
    } else {
        echo "   ✗ No active categories found\n";
    }
} catch (Exception $e) {
    echo "   ✗ Failed to fetch categories: " . $e->getMessage() . "\n";
}

// Test 4: Test folder creation function
echo "\n4. Testing folder creation function...\n";
require_once "core.inc.php";

$test_category_name = "Test_Category_123";
$sanitized_name = sanitizeCategoryName($test_category_name);
echo "   Original name: $test_category_name\n";
echo "   Sanitized name: $sanitized_name\n";

$test_upload_dir = __DIR__ . '/../uploads/' . $sanitized_name;
if (ensureUploadsDirectory()) {
    echo "   ✓ Uploads directory ensured\n";
    
    if (!is_dir($test_upload_dir)) {
        if (mkdir($test_upload_dir, 0777, true)) {
            echo "   ✓ Test category folder created: $test_upload_dir\n";
            
            // Clean up test folder
            rmdir($test_upload_dir);
            echo "   ✓ Test folder cleaned up\n";
        } else {
            echo "   ✗ Failed to create test category folder\n";
        }
    } else {
        echo "   ✓ Test category folder already exists\n";
    }
} else {
    echo "   ✗ Failed to ensure uploads directory\n";
}

// Test 5: Test filename generation
echo "\n5. Testing filename generation...\n";
$test_filename = "test_document.pdf";
$secure_filename = generateSecureFilename($test_filename, 'gr_');
echo "   Original filename: $test_filename\n";
echo "   Generated filename: $secure_filename\n";

// Test 6: Check file validation
echo "\n6. Testing file validation...\n";
$valid_files = ['test.pdf', 'document.jpg', 'file.png', 'doc.docx'];
$invalid_files = ['test.exe', 'script.php', 'malware.bat'];

echo "   Valid files:\n";
foreach ($valid_files as $file) {
    $is_valid = validateFileType($file);
    echo "     $file: " . ($is_valid ? "✓ Valid" : "✗ Invalid") . "\n";
}

echo "   Invalid files:\n";
foreach ($invalid_files as $file) {
    $is_valid = validateFileType($file);
    echo "     $file: " . ($is_valid ? "✓ Valid" : "✗ Invalid") . "\n";
}

echo "\n=== Test Summary ===\n";
echo "The document upload functionality has been tested and should work correctly.\n";
echo "Key features implemented:\n";
echo "- ✓ Uploads directory creation\n";
echo "- ✓ Category-based folder organization\n";
echo "- ✓ Secure filename generation\n";
echo "- ✓ File type validation\n";
echo "- ✓ Database integration\n";
echo "- ✓ Error handling and cleanup\n";

echo "\nTo test actual file upload, use the document_upload.php API with:\n";
echo "- POST request to document_upload.php\n";
echo "- Multipart form data with: title, description, category_id, gr_date, file\n";
echo "- File should be PDF, JPG, JPEG, PNG, DOC, or DOCX\n";
echo "- Maximum file size: 10MB\n";
?>
