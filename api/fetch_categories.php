<?php

require "connect.inc.php";
require "core.inc.php";

header("Content-Type: application/json");
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, POST, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type");

// Handle preflight OPTIONS request
if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(200);
    exit();
}

$data = json_decode(file_get_contents('php://input'), true);

// Get parameters from both POST data and GET parameters
$subject_id = isset($data['subject_id']) ? $data['subject_id'] : (isset($_GET['subject_id']) ? $_GET['subject_id'] : null);
$status_filter = isset($data['status']) ? $data['status'] : (isset($_GET['status']) ? $_GET['status'] : 'Active');

try {
    if ($subject_id) {
        // Fetch categories for specific subject_id
        if ($status_filter && $status_filter !== 'All') {
            $query = "SELECT category_id, subject_id, category_name, status, timestamp 
                      FROM category_master 
                      WHERE subject_id = :subject_id AND status = :status 
                      ORDER BY category_id ASC, category_name ASC";
            $statement = $connect->prepare($query);
            $statement->execute(array(
                ':subject_id' => $subject_id,
                ':status' => $status_filter
            ));
        } else {
            $query = "SELECT category_id, subject_id, category_name, status, timestamp 
                      FROM category_master 
                      WHERE subject_id = :subject_id 
                      ORDER BY category_id ASC, category_name ASC";
            $statement = $connect->prepare($query);
            $statement->execute(array(':subject_id' => $subject_id));
        }
    } else {
        // Fetch all categories
        if ($status_filter && $status_filter !== 'All') {
            $query = "SELECT category_id, subject_id, category_name, status, timestamp 
                      FROM category_master 
                      WHERE status = :status 
                      ORDER BY subject_id ASC, category_id ASC, category_name ASC";
            $statement = $connect->prepare($query);
            $statement->execute(array(':status' => $status_filter));
        } else {
            $query = "SELECT category_id, subject_id, category_name, status, timestamp 
                      FROM category_master 
                      ORDER BY subject_id ASC, category_id ASC, category_name ASC";
            $statement = $connect->prepare($query);
            $statement->execute();
        }
    }

    if ($statement->rowCount() > 0) {
        $output = $statement->fetchAll(PDO::FETCH_ASSOC);
        
        // Add additional metadata to response
        $response = array(
            'status' => 'success',
            'total_count' => count($output),
            'subject_id' => $subject_id,
            'status_filter' => $status_filter,
            'categories' => $output
        );
        
        echo json_encode($response);
    } else {
        $message = $subject_id ? 
            "No categories found for subject_id: $subject_id" : 
            "No categories found";
            
        echo json_encode(array(
            'status' => 'false',
            'message' => $message,
            'total_count' => 0,
            'subject_id' => $subject_id,
            'status_filter' => $status_filter,
            'categories' => array()
        ));
    }

} catch (PDOException $e) {
    echo json_encode(array(
        'status' => 'error',
        'message' => 'Database error: ' . $e->getMessage(),
        'total_count' => 0,
        'subject_id' => $subject_id,
        'status_filter' => $status_filter,
        'categories' => array()
    ));
}

?>
