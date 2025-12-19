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

if (empty($message)) {
    $category_id = $data['category_id'];

    $message .= empty($category_id) ? "category_id can not be empty\n" : "";

    if (empty($message)) {
        // Check if category has documents
        $check_query = "SELECT COUNT(*) as doc_count FROM documents WHERE category_id = :category_id AND status = 'Active'";
        $check_stmt = $connect->prepare($check_query);
        $check_stmt->execute(array(':category_id' => $category_id));
        $check_result = $check_stmt->fetch();

        if ($check_result['doc_count'] > 0) {
            $response["message"] = "Cannot delete category. It has associated documents.";
            $response["status"] = 'false';
            echo json_encode($response);
        } else {
            $query = "UPDATE `categories` SET `status` = 'Inactive' WHERE `category_id` = :category_id";
            $statement = $connect->prepare($query);
            $statement->execute(array(':category_id' => $category_id));

            if ($statement->rowCount() > 0) {
                $response["message"] = "Category deleted successfully";
                $response["status"] = 'true';
                echo json_encode($response);
            } else {
                $response["message"] = "Unable to delete category";
                $response["status"] = 'false';
                echo json_encode($response);
            }
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
