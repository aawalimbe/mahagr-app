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
$sub_category_id = isset($data['sub_category_id']) ? $data['sub_category_id'] : (isset($_GET['sub_category_id']) ? $_GET['sub_category_id'] : null);
$status_filter = isset($data['status']) ? $data['status'] : (isset($_GET['status']) ? $_GET['status'] : 'Active');

try {
    if ($sub_category_id) {
        // Fetch sub-sub-categories for specific sub_category_id
        if ($status_filter && $status_filter !== 'All') {
            $query = "SELECT sub_sub_category_id, sub_category_id, sub_sub_category_name, status, timestamp 
                      FROM sub_sub_category_master 
                      WHERE sub_category_id = :sub_category_id AND status = :status 
                      ORDER BY sub_sub_category_id ASC, sub_sub_category_name ASC";
            $statement = $connect->prepare($query);
            $statement->execute(array(
                ':sub_category_id' => $sub_category_id,
                ':status' => $status_filter
            ));
        } else {
            $query = "SELECT sub_sub_category_id, sub_category_id, sub_sub_category_name, status, timestamp 
                      FROM sub_sub_category_master 
                      WHERE sub_category_id = :sub_category_id 
                      ORDER BY sub_sub_category_id ASC, sub_sub_category_name ASC";
            $statement = $connect->prepare($query);
            $statement->execute(array(':sub_category_id' => $sub_category_id));
        }
    } else {
        // Fetch all sub-sub-categories
        if ($status_filter && $status_filter !== 'All') {
            $query = "SELECT sub_sub_category_id, sub_category_id, sub_sub_category_name, status, timestamp 
                      FROM sub_sub_category_master 
                      WHERE status = :status 
                      ORDER BY sub_category_id ASC, sub_sub_category_id ASC, sub_sub_category_name ASC";
            $statement = $connect->prepare($query);
            $statement->execute(array(':status' => $status_filter));
        } else {
            $query = "SELECT sub_sub_category_id, sub_category_id, sub_sub_category_name, status, timestamp 
                      FROM sub_sub_category_master 
                      ORDER BY sub_category_id ASC, sub_sub_category_id ASC, sub_sub_category_name ASC";
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
            'sub_category_id' => $sub_category_id,
            'status_filter' => $status_filter,
            'sub_sub_categories' => $output
        );
        
        echo json_encode($response);
    } else {
        $message = $sub_category_id ? 
            "No sub-sub-categories found for sub_category_id: $sub_category_id" : 
            "No sub-sub-categories found";
            
        echo json_encode(array(
            'status' => 'false',
            'message' => $message,
            'total_count' => 0,
            'sub_category_id' => $sub_category_id,
            'status_filter' => $status_filter,
            'sub_sub_categories' => array()
        ));
    }

} catch (PDOException $e) {
    echo json_encode(array(
        'status' => 'error',
        'message' => 'Database error: ' . $e->getMessage(),
        'total_count' => 0,
        'sub_category_id' => $sub_category_id,
        'status_filter' => $status_filter,
        'sub_sub_categories' => array()
    ));
}

?>


