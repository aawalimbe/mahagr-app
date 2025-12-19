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

$message .= isset($data['category_id']) ? "" : "category_id not received\n";
$message .= isset($data['category_name']) ? "" : "category_name not received\n";

if (empty($message)) {
    $category_id = $data['category_id'];
    $category_name = trim($data['category_name']);

    $message .= empty($category_id) ? "category_id can not be empty\n" : "";
    $message .= empty($category_name) ? "category_name can not be empty\n" : "";

    if (empty($message)) {
        $query = "UPDATE `categories` SET `category_name` = :category_name WHERE `category_id` = :category_id";
        $statement = $connect->prepare($query);
        $statement->execute(array(
            ':category_name' => $category_name,
            ':category_id' => $category_id
        ));

        if ($statement->rowCount() > 0) {
            $response["message"] = "Category updated successfully";
            $response["status"] = 'true';
            echo json_encode($response);
        } else {
            $response["message"] = "Unable to update category";
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
