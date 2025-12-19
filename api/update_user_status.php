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

$message .= isset($data['user_id']) ? "" : "user_id not received\n";
$message .= isset($data['status']) ? "" : "status not received\n";

if (empty($message)) {
    $user_id = $data['user_id'];
    $status = $data['status'];

    $message .= empty($user_id) ? "user_id can not be empty\n" : "";
    $message .= empty($status) ? "status can not be empty\n" : "";

    // Validate status
    if (!empty($status) && !in_array($status, ['Active', 'Inactive'])) {
        $message .= "Invalid status. Must be 'Active' or 'Inactive'\n";
    }

    if (empty($message)) {
        $query = "UPDATE `users` SET `status` = :status WHERE `user_id` = :user_id";
        $statement = $connect->prepare($query);
        $statement->execute(array(
            ':status' => $status,
            ':user_id' => $user_id
        ));

        if ($statement->rowCount() > 0) {
            $response["message"] = "User status updated successfully";
            $response["status"] = 'true';
            echo json_encode($response);
        } else {
            $response["message"] = "Unable to update user status";
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
