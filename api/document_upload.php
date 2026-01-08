<?php

require "connect.inc.php";
require "core.inc.php";

header("Content-Type: application/json");
header("Access-Control-Allow-Origin: *");
header('Access-Control-Allow-Methods: POST, OPTIONS');
header('Access-Control-Allow-Headers: Access-Control-Allow-Headers, Content-Type, Access-Control-Allow-Method, Authorization, X-Requested-With');

// Handle OPTIONS request for CORS preflight
if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(200);
    exit;
}

// Validate that request is multipart/form-data
$contentType = $_SERVER['CONTENT_TYPE'] ?? '';
if ($_SERVER['REQUEST_METHOD'] === 'POST' && strpos($contentType, 'multipart/form-data') === false) {
    $response = array(
        "status" => 'false',
        "message" => "Content-Type must be multipart/form-data for file uploads"
    );
    echo json_encode($response);
    exit;
}

$response = array();
$message = '';

$message .= isset($_POST['title']) ? "" : "title not received\n";
$message .= isset($_FILES['file']) ? "" : "file not received\n";

if (empty($message)) {
    $title = trim($_POST['title']);
    $description = isset($_POST['description']) ? trim($_POST['description']) : '';
    $category_id = isset($_POST['category_id']) && !empty($_POST['category_id']) ? $_POST['category_id'] : null;
    $gr_date = isset($_POST['gr_date']) && !empty($_POST['gr_date']) ? $_POST['gr_date'] : null;
    $uploaded_by = isset($_POST['uploaded_by']) ? $_POST['uploaded_by'] : null;
    $file_upload = "";
    $target_path = "";

    $message .= empty($title) ? "title can not be empty\n" : "";

    if (empty($message)) {
        if (isset($_FILES['file']) && $_FILES['file']['error'] === UPLOAD_ERR_OK) {
            $file = $_FILES['file'];
            $file_name = $file['name'];
            $file_path = $file['tmp_name'];
            $file_size = $file['size'];
            $file_type = $file['type'];

            // Validate file type
            if (!validateFileType($file_name)) {
                $message .= "Invalid file type. Allowed types: PDF, JPG, JPEG, PNG, DOC, DOCX\n";
            } elseif ($file_size > 10 * 1024 * 1024) { // 10MB limit
                $message .= "File size exceeds 10MB limit\n";
            } else {
                // Ensure uploads directory exists
                if (!ensureUploadsDirectory()) {
                    $message .= "Failed to create uploads directory\n";
                } else {
                    $category_name = null;
                    
                    // If category_id is provided, get category name for folder creation
                    if ($category_id !== null) {
                        $cat_query = "SELECT category_name FROM categories WHERE category_id = :category_id AND status = 'Active'";
                        $cat_stmt = $connect->prepare($cat_query);
                        $cat_stmt->execute(array(':category_id' => $category_id));
                        $cat_result = $cat_stmt->fetch();

                        if ($cat_result) {
                            // Sanitize category name for folder name (remove special characters)
                            $category_name = sanitizeCategoryName($cat_result['category_name']);
                        }
                        // If category_id is invalid, we'll use default folder (don't fail)
                    }
                    
                    // If category_id is not provided or invalid, use default folder
                    if ($category_name === null) {
                        $category_name = 'user_uploads';
                    }
                    
                    if (empty($message)) {
                        
                        // Create upload directory path (relative to mahagr folder)
                        $upload_dir = __DIR__ . '/../uploads/' . $category_name;
                        
                        // Create directory if it doesn't exist
                        if (!is_dir($upload_dir)) {
                            if (!mkdir($upload_dir, 0777, true)) {
                                $message .= "Failed to create upload folder\n";
                            }
                        }
                        
                        if (empty($message)) {
                            // Generate secure unique filename to prevent conflicts
                            $unique_filename = generateSecureFilename($file_name, 'gr_');
                            $target_path = $upload_dir . '/' . $unique_filename;
                            
                            // Relative path for database storage
                            $file_upload = 'uploads/' . $category_name . '/' . $unique_filename;
                            
                            // Move uploaded file to target directory
                            if (move_uploaded_file($file_path, $target_path)) {
                                // File uploaded successfully, continue with database insertion
                            } else {
                                $message .= "Failed to upload file\n";
                            }
                        }
                    }
                }
            }
        } else {
            $message .= "File upload error or no file received\n";
        }

        if (empty($message)) {
            try {
                $query = "INSERT INTO `documents` (`title`, `description`, `category_id`, `file_type`, `file_url`, `gr_date`, `uploaded_by`, `status`) 
                          VALUES (:title, :description, :category_id, :file_type, :file_url, :gr_date, :uploaded_by, :status)";
                $statement = $connect->prepare($query);
                $statement->execute(array(
                    ':title' => $title,
                    ':description' => $description,
                    ':category_id' => $category_id,
                    ':file_type' => $file_type,
                    ':file_url' => $file_upload,
                    ':gr_date' => $gr_date,
                    ':uploaded_by' => $uploaded_by,
                    ':status' => 'Active'
                ));

                if ($statement->rowCount() > 0) {
                    $document_id = $connect->lastInsertId();
                    $response["message"] = "Document uploaded successfully";
                    $response["status"] = 'true';
                    $response["document_id"] = $document_id;
                    $response["file_url"] = $file_upload;
                    $response["category_folder"] = $category_name;
                    echo json_encode($response);
                } else {
                    // If database insertion fails, remove the uploaded file
                    if (!empty($file_upload) && !empty($target_path) && file_exists($target_path)) {
                        @unlink($target_path);
                    }
                    $response["message"] = "Unable to upload document to database";
                    $response["status"] = 'false';
                    echo json_encode($response);
                }
            } catch (PDOException $e) {
                // If database insertion fails, remove the uploaded file
                if (!empty($file_upload) && !empty($target_path) && file_exists($target_path)) {
                    @unlink($target_path);
                }
                
                // Check if error is related to AUTO_INCREMENT
                if (strpos($e->getMessage(), 'Duplicate entry') !== false && strpos($e->getMessage(), 'PRIMARY') !== false) {
                    $response["message"] = "Database error: The document_id column requires AUTO_INCREMENT. Please run the database fix: ALTER TABLE `documents` MODIFY `document_id` int(11) NOT NULL AUTO_INCREMENT;";
                    $response["status"] = 'false';
                } else {
                    $response["message"] = "Database error: " . $e->getMessage();
                    $response["status"] = 'false';
                }
                echo json_encode($response);
            }
        } else {
            $response["message"] = "$message";
            $response["status"] = 'false';
            echo json_encode($response);
        }
    } else {
        $response["message"] = "$message";
        $response["status"] = 'false';
        echo json_encode($response);
    }
} else {
    $response["message"] = "$message";
    $response["status"] = 'false';
    echo json_encode($response);
}

?>
