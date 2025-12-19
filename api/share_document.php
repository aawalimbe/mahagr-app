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
        $token = generateUniqueToken();
        $query = "INSERT INTO shared_links (document_id, unique_link_token, status) VALUES (:document_id, :token, 'Active')";
        $statement = $connect->prepare($query);
        $statement->execute(array(':document_id' => $document_id, ':token' => $token));
        if ($statement->rowCount() > 0) {
            $response["message"] = "Shareable link generated successfully";
            $response["status"] = 'true';
            $response["share_url"] = "https://yourdomain.com/api/shared_document.php?token=$token";
            $response["token"] = $token;
            echo json_encode($response);
        } else {
            $response["message"] = "Unable to generate shareable link";
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

