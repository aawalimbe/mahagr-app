<?php

require "connect.inc.php";
require "core.inc.php";

header("Content-Type: application/json");
header("Access-Control-Allow-Origin: *");

$data = json_decode(file_get_contents('php://input'), true);
$department_id = isset($data['department_id']) ? $data['department_id'] : null;

if ($department_id) {
    $query = "SELECT c.category_id, c.category_name, c.status, c.timestamp, d.department_name 
              FROM categories c 
              LEFT JOIN department d ON c.department_id = d.department_id 
              WHERE c.department_id = :department_id AND c.status = 'Active' 
              ORDER BY c.category_name ASC";
    $statement = $connect->prepare($query);
    $statement->execute(array(':department_id' => $department_id));
} else {
    $query = "SELECT c.category_id, c.category_name, c.status, c.timestamp, d.department_name 
              FROM categories c 
              LEFT JOIN department d ON c.department_id = d.department_id 
              WHERE c.status = 'Active' 
              ORDER BY c.category_name ASC";
    $statement = $connect->prepare($query);
    $statement->execute();
}

if ($statement->rowCount() > 0) {
    $output = $statement->fetchAll(PDO::FETCH_ASSOC);
    echo json_encode($output);
} else {
    echo json_encode(array('message' => 'No categories found', 'status' => 'false'));
}

?>
