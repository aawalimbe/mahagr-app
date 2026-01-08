<?php

require "connect.inc.php"; // must define $conn (PDO)
require "core.inc.php";

header("Content-Type: application/json");
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type, Authorization, X-Requested-With");

error_reporting(E_ALL);
ini_set('display_errors', 1);

$response = [];
$errors = '';

$data = json_decode(file_get_contents('php://input'), true);

/* ---------------- VALIDATION ---------------- */

if (!isset($data['message'])) {
    $errors .= "message not received\n";
}

if (empty($errors)) {
    $message = trim($data['message']);
    $contact = isset($data['contact']) ? trim($data['contact']) : null;
    $user_id = isset($data['user_id']) ? $data['user_id'] : null;

    if ($message === '') {
        $errors .= "message can not be empty\n";
    }

    if (empty($errors)) {

        try {
            /* ---------------- INSERT ---------------- */

            $stmt = $conn->prepare(
                "INSERT INTO suggestions (message, contact, user_id)
                 VALUES (:message, :contact, :user_id)"
            );

            $stmt->execute([
                ':message' => $message,
                ':contact' => $contact,
                ':user_id' => $user_id
            ]);

            if ($stmt->rowCount() > 0) {
                $response['status'] = 'true';
                $response['message'] = 'Suggestion submitted successfully';
            } else {
                $response['status'] = 'false';
                $response['message'] = 'Insert failed';
            }

        } catch (PDOException $e) {
            $response['status'] = 'false';
            $response['message'] = 'DB Error: ' . $e->getMessage();
        }

    } else {
        $response['status'] = 'false';
        $response['message'] = $errors;
    }
} else {
    $response['status'] = 'false';
    $response['message'] = $errors;
}

echo json_encode($response);
