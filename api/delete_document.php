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
    $message .= empty($document_id) ? "document_id can not be empty\n" : "";

    if (empty($message)) {
        $query = "UPDATE documents SET status = 'Inactive' WHERE document_id = :document_id";
        $statement = $connect->prepare($query);
        $statement->execute(array(':document_id' => $document_id));

        if ($statement->rowCount() > 0) {
            $response["message"] = "Document deleted successfully";
            $response["status"] = 'true';
            echo json_encode($response);
        } else {
            $response["message"] = "Unable to delete document";
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

