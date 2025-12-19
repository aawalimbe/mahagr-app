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
$category_id = isset($data['category_id']) ? $data['category_id'] : (isset($_GET['category_id']) ? $_GET['category_id'] : null);
$status_filter = isset($data['status']) ? $data['status'] : (isset($_GET['status']) ? $_GET['status'] : 'Active');

try {
    if ($category_id) {
        // Fetch sub-categories for specific category_id
        if ($status_filter && $status_filter !== 'All') {
            $query = "SELECT sub_category_id, category_id, sub_category_name, status, timestamp 
                      FROM sub_category_master 
                      WHERE category_id = :category_id AND status = :status 
                      ORDER BY sub_category_id ASC, sub_category_name ASC";
            $statement = $connect->prepare($query);
            $statement->execute(array(
                ':category_id' => $category_id,
                ':status' => $status_filter
            ));
        } else {
            $query = "SELECT sub_category_id, category_id, sub_category_name, status, timestamp 
                      FROM sub_category_master 
                      WHERE category_id = :category_id 
                      ORDER BY sub_category_id ASC, sub_category_name ASC";
            $statement = $connect->prepare($query);
            $statement->execute(array(':category_id' => $category_id));
        }
    } else {
        // Fetch all sub-categories
        if ($status_filter && $status_filter !== 'All') {
            $query = "SELECT sub_category_id, category_id, sub_category_name, status, timestamp 
                      FROM sub_category_master 
                      WHERE status = :status 
                      ORDER BY category_id ASC, sub_category_id ASC, sub_category_name ASC";
            $statement = $connect->prepare($query);
            $statement->execute(array(':status' => $status_filter));
        } else {
            $query = "SELECT sub_category_id, category_id, sub_category_name, status, timestamp 
                      FROM sub_category_master 
                      ORDER BY category_id ASC, sub_category_id ASC, sub_category_name ASC";
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
            'category_id' => $category_id,
            'status_filter' => $status_filter,
            'sub_categories' => $output
        );
        
        echo json_encode($response);
    } else {
        $message = $category_id ? 
            "No sub-categories found for category_id: $category_id" : 
            "No sub-categories found";
            
        echo json_encode(array(
            'status' => 'false',
            'message' => $message,
            'total_count' => 0,
            'category_id' => $category_id,
            'status_filter' => $status_filter,
            'sub_categories' => array()
        ));
    }

} catch (PDOException $e) {
    echo json_encode(array(
        'status' => 'error',
        'message' => 'Database error: ' . $e->getMessage(),
        'total_count' => 0,
        'category_id' => $category_id,
        'status_filter' => $status_filter,
        'sub_categories' => array()
    ));
}

?>

