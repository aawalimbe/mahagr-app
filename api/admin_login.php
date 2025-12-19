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
$message .= isset($data['password']) ? "" : "password not received\n";

if (empty($message)) {
    $email = trim($data['email']);
    $password = $data['password'];

    $message .= empty($email) ? "email can not be empty\n" : "";
    $message .= empty($password) ? "password can not be empty\n" : "";

    if (empty($message)) {
        $password_md5 = md5($password);

        $query = "SELECT `admin_id`, `name`, `email`, `mobile_number`, `role`, `status` FROM `admin_users` WHERE `email` = :email AND `status` = 'Active'";
        $statement = $connect->prepare($query);
        $statement->execute(array(':email' => $email));
        $result = $statement->fetchAll(PDO::FETCH_ASSOC);

        if ($result && count($result) == 1) {
            if ($result[0]['status'] == 'Active') {
                $response["admin_id"] = $result[0]["admin_id"];
                $response["name"] = $result[0]["name"];
                $response["email"] = $result[0]["email"];
                $response["mobile"] = $result[0]["mobile_number"];
                $response["role"] = $result[0]["role"];
                $response["message"] = "Admin login successful";
                $response["status"] = 'true';
                echo json_encode($response);
            } else {
                $response["message"] = "Admin account is inactive";
                $response["status"] = 'false';
                echo json_encode($response);
            }
        } else {
            $response["message"] = "Invalid email or admin not found";
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
