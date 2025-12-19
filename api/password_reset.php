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

if (empty($message)) {
    $email = trim($data['email']);

    $message .= empty($email) ? "email can not be empty\n" : "";

    // Validate email format
    if (!empty($email) && !validateEmail($email)) {
        $message .= "Invalid email format\n";
    }

    if (empty($message)) {
        // Check if user exists
        $query = "SELECT `user_id`, `email` FROM `users` WHERE `email` = :email AND `status` = 'Active'";
        $statement = $connect->prepare($query);
        $statement->execute(array(':email' => $email));
        $result = $statement->fetchAll(PDO::FETCH_ASSOC);

        if ($result && count($result) == 1) {
            $user_id = $result[0]['user_id'];
            $otp = generateOTP();
            
            // Store OTP in database (you might want to create a separate table for this)
            // For now, we'll just return success message
            
            $response["message"] = "Password reset OTP sent to your email";
            $response["status"] = 'true';
            $response["otp"] = $otp; // In production, send this via email
            echo json_encode($response);
        } else {
            $response["message"] = "User with this email not found";
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
