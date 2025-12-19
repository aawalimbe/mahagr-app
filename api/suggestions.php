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

$message .= isset($data['message']) ? "" : "message not received\n";

if (empty($message)) {
    $message_text = trim($data['message']);
    $contact = isset($data['contact']) ? trim($data['contact']) : '';
    $user_id = isset($data['user_id']) ? $data['user_id'] : null;

    $message .= empty($message_text) ? "message can not be empty\n" : "";

    if (empty($message)) {
        // For now, we'll just return success message
        // In production, you would save this to a suggestions table
        
        $response["message"] = "Suggestion submitted successfully";
        $response["status"] = 'true';
        echo json_encode($response);
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
