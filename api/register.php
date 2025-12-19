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

$message .= isset($data['name']) ? "" : "name not received\n";
$message .= isset($data['email']) ? "" : "email not received\n";
$message .= isset($data['password']) ? "" : "password not received\n";
$message .= isset($data['mobile']) ? "" : "mobile not received\n";
$message .= isset($data['userType']) ? "" : "userType not received\n";
$message .= isset($data['district']) ? "" : "district not received\n";

if (empty($message)) {
    $name = trim($data['name']);
    $email = trim($data['email']);
    $password = $data['password'];
    $mobile = trim($data['mobile']);
    $userType = trim($data['userType']);
    $department = isset($data['department']) ? trim($data['department']) : '';
    $district = trim($data['district']);

    $message .= empty($name) ? "name can not be empty\n" : "";
    $message .= empty($email) ? "email can not be empty\n" : "";
    $message .= empty($password) ? "password can not be empty\n" : "";
    $message .= empty($mobile) ? "mobile can not be empty\n" : "";
    $message .= empty($userType) ? "userType can not be empty\n" : "";
    $message .= empty($district) ? "district can not be empty\n" : "";

    // Validate email format
    if (!empty($email) && !validateEmail($email)) {
        $message .= "Invalid email format\n";
    }

    // Validate mobile format
    if (!empty($mobile) && !validateMobile($mobile)) {
        $message .= "Invalid mobile number format\n";
    }

    // Check if user already exists
    if (!empty($email) && userExists($connect, $email, $mobile)) {
        $message .= "User with this email or mobile already exists\n";
    }

    if (empty($message)) {
        $password_hash = md5($password); // Using MD5 as per MISA project pattern

        $query = "INSERT INTO `users` (`email`, `mobile`, `password`, `status`) VALUES (:email, :mobile, :password, :status)";
        $statement = $connect->prepare($query);
        $statement->execute(array(
            ':email' => $email,
            ':mobile' => $mobile,
            ':password' => $password_hash,
            ':status' => 'Active'
        ));

        if ($statement->rowCount() > 0) {
            $user_id = $connect->lastInsertId();
            $response["message"] = "Registration successful";
            $response["status"] = 'true';
            $response["user_id"] = $user_id;
            echo json_encode($response);
        } else {
            $response["message"] = "Unable to register user";
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
