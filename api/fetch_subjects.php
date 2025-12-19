<?php

require "connect.inc.php";
require "core.inc.php";

header("Content-Type: application/json");
header("Access-Control-Allow-Origin: *");

$data = json_decode(file_get_contents('php://input'), true);
$status_filter = isset($data['status']) ? $data['status'] : 'Active';

if ($status_filter && $status_filter !== 'All') {
    $query = "SELECT subject_id, subject_name, status, timestamp 
              FROM subject_master 
              WHERE status = :status 
              ORDER BY subject_id ASC, subject_name ASC";
    $statement = $connect->prepare($query);
    $statement->execute(array(':status' => $status_filter));
} else {
    $query = "SELECT subject_id, subject_name, status, timestamp 
              FROM subject_master 
              ORDER BY subject_id ASC, subject_name ASC";
    $statement = $connect->prepare($query);
    $statement->execute();
}

if ($statement->rowCount() > 0) {
    $output = $statement->fetchAll(PDO::FETCH_ASSOC);
    echo json_encode($output);
} else {
    echo json_encode(array('message' => 'No subjects found', 'status' => 'false'));
}

?>
