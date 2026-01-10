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
$sub_sub_category_id = isset($data['sub_sub_category_id']) ? $data['sub_sub_category_id'] : (isset($_GET['sub_sub_category_id']) ? $_GET['sub_sub_category_id'] : 0);
$sub_category_id = isset($data['sub_category_id']) ? $data['sub_category_id'] : (isset($_GET['sub_category_id']) ? $_GET['sub_category_id'] : 0);
$category_id = isset($data['category_id']) ? $data['category_id'] : (isset($_GET['category_id']) ? $_GET['category_id'] : 0);
$subject_id = isset($data['subject_id']) ? $data['subject_id'] : (isset($_GET['subject_id']) ? $_GET['subject_id'] : null);
$status_filter = isset($data['status']) ? $data['status'] : (isset($_GET['status']) ? $_GET['status'] : 'Active');

try {
    // Determine which filter to use based on priority
    if ($sub_sub_category_id != 0) {
        // Fetch GR list based on sub_sub_category_id
        if ($status_filter && $status_filter !== 'All') {
            $query = "SELECT gr_id, subject_id, category_id, sub_category_id, sub_sub_category_id, gr_name, gr_link, date, file_upload_location, status, timestamp 
                      FROM gr_master 
                      WHERE sub_sub_category_id = :sub_sub_category_id AND status = :status 
                      ORDER BY gr_id DESC, date DESC";
            $statement = $connect->prepare($query);
            $statement->execute(array(
                ':sub_sub_category_id' => $sub_sub_category_id,
                ':status' => $status_filter
            ));
        } else {
            $query = "SELECT gr_id, subject_id, category_id, sub_category_id, sub_sub_category_id, gr_name, gr_link, date, file_upload_location, status, timestamp 
                      FROM gr_master 
                      WHERE sub_sub_category_id = :sub_sub_category_id 
                      ORDER BY gr_id DESC, date DESC";
            $statement = $connect->prepare($query);
            $statement->execute(array(':sub_sub_category_id' => $sub_sub_category_id));
        }
        $filter_used = 'sub_sub_category_id';
        $filter_value = $sub_sub_category_id;
    } elseif ($sub_category_id != 0) {
        // Fetch GR list based on sub_category_id
        if ($status_filter && $status_filter !== 'All') {
            $query = "SELECT gr_id, subject_id, category_id, sub_category_id, sub_sub_category_id, gr_name, gr_link, date, file_upload_location, status, timestamp 
                      FROM gr_master 
                      WHERE sub_category_id = :sub_category_id AND status = :status 
                      ORDER BY gr_id DESC, date DESC";
            $statement = $connect->prepare($query);
            $statement->execute(array(
                ':sub_category_id' => $sub_category_id,
                ':status' => $status_filter
            ));
        } else {
            $query = "SELECT gr_id, subject_id, category_id, sub_category_id, sub_sub_category_id, gr_name, gr_link, date, file_upload_location, status, timestamp 
                      FROM gr_master 
                      WHERE sub_category_id = :sub_category_id 
                      ORDER BY gr_id DESC, date DESC";
            $statement = $connect->prepare($query);
            $statement->execute(array(':sub_category_id' => $sub_category_id));
        }
        $filter_used = 'sub_category_id';
        $filter_value = $sub_category_id;
    } elseif ($category_id != 0) {
        // Fetch GR list based on category_id
        if ($status_filter && $status_filter !== 'All') {
            $query = "SELECT gr_id, subject_id, category_id, sub_category_id, sub_sub_category_id, gr_name, gr_link, date, file_upload_location, status, timestamp 
                      FROM gr_master 
                      WHERE category_id = :category_id AND status = :status 
                      ORDER BY gr_id DESC, date DESC";
            $statement = $connect->prepare($query);
            $statement->execute(array(
                ':category_id' => $category_id,
                ':status' => $status_filter
            ));
        } else {
            $query = "SELECT gr_id, subject_id, category_id, sub_category_id, sub_sub_category_id, gr_name, gr_link, date, file_upload_location, status, timestamp 
                      FROM gr_master 
                      WHERE category_id = :category_id 
                      ORDER BY gr_id DESC, date DESC";
            $statement = $connect->prepare($query);
            $statement->execute(array(':category_id' => $category_id));
        }
        $filter_used = 'category_id';
        $filter_value = $category_id;
    } elseif ($subject_id) {
        // Fetch GR list based on subject_id
        if ($status_filter && $status_filter !== 'All') {
            $query = "SELECT gr_id, subject_id, category_id, sub_category_id, sub_sub_category_id, gr_name, gr_link, date, file_upload_location, status, timestamp 
                      FROM gr_master 
                      WHERE subject_id = :subject_id AND status = :status 
                      ORDER BY gr_id DESC, date DESC";
            $statement = $connect->prepare($query);
            $statement->execute(array(
                ':subject_id' => $subject_id,
                ':status' => $status_filter
            ));
        } else {
            $query = "SELECT gr_id, subject_id, category_id, sub_category_id, sub_sub_category_id, gr_name, gr_link, date, file_upload_location, status, timestamp 
                      FROM gr_master 
                      WHERE subject_id = :subject_id 
                      ORDER BY gr_id DESC, date DESC";
            $statement = $connect->prepare($query);
            $statement->execute(array(':subject_id' => $subject_id));
        }
        $filter_used = 'subject_id';
        $filter_value = $subject_id;
    } else {
        // Fetch all GR records
        if ($status_filter && $status_filter !== 'All') {
            $query = "SELECT gr_id, subject_id, category_id, sub_category_id, sub_sub_category_id, gr_name, gr_link, date, file_upload_location, status, timestamp 
                      FROM gr_master 
                      WHERE status = :status 
                      ORDER BY subject_id ASC, category_id ASC, sub_category_id ASC, sub_sub_category_id ASC, gr_id DESC";
            $statement = $connect->prepare($query);
            $statement->execute(array(':status' => $status_filter));
        } else {
            $query = "SELECT gr_id, subject_id, category_id, sub_category_id, sub_sub_category_id, gr_name, gr_link, date, file_upload_location, status, timestamp 
                      FROM gr_master 
                      ORDER BY subject_id ASC, category_id ASC, sub_category_id ASC, sub_sub_category_id ASC, gr_id DESC";
            $statement = $connect->prepare($query);
            $statement->execute();
        }
        $filter_used = 'all';
        $filter_value = null;
    }

    if ($statement->rowCount() > 0) {
        $output = $statement->fetchAll(PDO::FETCH_ASSOC);
        
        // Add additional metadata to response
        $response = array(
            'status' => 'success',
            'total_count' => count($output),
            'filter_used' => $filter_used,
            'subject_id' => $subject_id,
            'category_id' => $category_id,
            'sub_category_id' => $sub_category_id,
            'sub_sub_category_id' => $sub_sub_category_id,
            'status_filter' => $status_filter,
            'gr_list' => $output
        );
        
        echo json_encode($response);
    } else {
        $message = '';
        if ($sub_sub_category_id != 0) {
            $message = "No GR records found for sub_sub_category_id: $sub_sub_category_id";
        } elseif ($sub_category_id != 0) {
            $message = "No GR records found for sub_category_id: $sub_category_id";
        } elseif ($category_id != 0) {
            $message = "No GR records found for category_id: $category_id";
        } elseif ($subject_id) {
            $message = "No GR records found for subject_id: $subject_id";
        } else {
            $message = "No GR records found";
        }
            
        echo json_encode(array(
            'status' => 'false',
            'message' => $message,
            'total_count' => 0,
            'filter_used' => $filter_used,
            'subject_id' => $subject_id,
            'category_id' => $category_id,
            'sub_category_id' => $sub_category_id,
            'sub_sub_category_id' => $sub_sub_category_id,
            'status_filter' => $status_filter,
            'gr_list' => array()
        ));
    }

} catch (PDOException $e) {
    echo json_encode(array(
        'status' => 'error',
        'message' => 'Database error: ' . $e->getMessage(),
        'total_count' => 0,
        'subject_id' => $subject_id,
        'category_id' => $category_id,
        'sub_category_id' => $sub_category_id,
        'sub_sub_category_id' => $sub_sub_category_id,
        'status_filter' => $status_filter,
        'gr_list' => array()
    ));
}

?>


