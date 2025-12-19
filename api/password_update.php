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

$message .= isset($data['email']) ? "" : "email not received\n";
$message .= isset($data['otp']) ? "" : "otp not received\n";
$message .= isset($data['newPassword']) ? "" : "newPassword not received\n";

if (empty($message)) {
    $email = trim($data['email']);
    $otp = trim($data['otp']);
    $newPassword = $data['newPassword'];

    $message .= empty($email) ? "email can not be empty\n" : "";
    $message .= empty($otp) ? "otp can not be empty\n" : "";
    $message .= empty($newPassword) ? "newPassword can not be empty\n" : "";

    if (empty($message)) {
        // In production, verify OTP from database
        // For now, we'll just update the password
        
        $password_hash = md5($newPassword);
        
        $query = "UPDATE `users` SET `password` = :password WHERE `email` = :email AND `status` = 'Active'";
        $statement = $connect->prepare($query);
        $statement->execute(array(
            ':password' => $password_hash,
            ':email' => $email
        ));

        if ($statement->rowCount() > 0) {
            $response["message"] = "Password updated successfully";
            $response["status"] = 'true';
            echo json_encode($response);
        } else {
            $response["message"] = "Unable to update password";
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
