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

$message .= isset($data['document_id']) ? "" : "document_id not received\n";

if (empty($message)) {
    $document_id = $data['document_id'];
    $title = isset($data['title']) ? trim($data['title']) : null;
    $description = isset($data['description']) ? trim($data['description']) : null;
    $category_id = isset($data['category_id']) ? $data['category_id'] : null;
    $gr_date = isset($data['gr_date']) ? $data['gr_date'] : null;

    $fields = array();
    $params = array(':document_id' => $document_id);

    if ($title !== null) {
        $fields[] = "title = :title";
        $params[':title'] = $title;
    }
    if ($description !== null) {
        $fields[] = "description = :description";
        $params[':description'] = $description;
    }
    if ($category_id !== null) {
        $fields[] = "category_id = :category_id";
        $params[':category_id'] = $category_id;
    }
    if ($gr_date !== null) {
        $fields[] = "gr_date = :gr_date";
        $params[':gr_date'] = $gr_date;
    }

    if (count($fields) > 0) {
        $query = "UPDATE documents SET " . implode(", ", $fields) . " WHERE document_id = :document_id";
        $statement = $connect->prepare($query);
        $statement->execute($params);

        if ($statement->rowCount() > 0) {
            $response["message"] = "Document updated successfully";
            $response["status"] = 'true';
            echo json_encode($response);
        } else {
            $response["message"] = "Unable to update document or no changes made";
            $response["status"] = 'false';
            echo json_encode($response);
        }
    } else {
        $response["message"] = "No fields to update";
        $response["status"] = 'false';
        echo json_encode($response);
    }
} else {
    $response["message"] = "$message";
    $response["status"] = 'false';
    echo json_encode($response);
}

?>

