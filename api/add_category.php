<?php

require "connect.inc.php";
require "core.inc.php";

header("Content-Type: application/json");
header("Access-Control-Allow-Origin: *");
header('Access-Control-Allow-Method: POST');
header('Access-Control-Allow-Headers: Access-Control-Allow-Headers, Content-Type, Access-Control-Allow-Method, Authorization, X-Requested-With');

$response = array();
$message = '';

$data = json_decode(file_get_contents('php://input'), true);

$message .= isset($data['category_name']) ? "" : "category_name not received\n";
$message .= isset($data['department_id']) ? "" : "department_id not received\n";

if (empty($message)) {
    $category_name = trim($data['category_name']);
    $department_id = $data['department_id'];

    $message .= empty($category_name) ? "category_name can not be empty\n" : "";
    $message .= empty($department_id) ? "department_id can not be empty\n" : "";

    if (empty($message)) {
        $query = "INSERT INTO `categories` (`department_id`, `category_name`, `status`) VALUES (:department_id, :category_name, :status)";
        $statement = $connect->prepare($query);
        $statement->execute(array(
            ':department_id' => $department_id,
            ':category_name' => $category_name,
            ':status' => 'Active'
        ));

        if ($statement->rowCount() > 0) {
            $category_id = $connect->lastInsertId();
            $response["message"] = "Category added successfully";
            $response["status"] = 'true';
            $response["category_id"] = $category_id;
            echo json_encode($response);
        } else {
            $response["message"] = "Unable to add category";
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
