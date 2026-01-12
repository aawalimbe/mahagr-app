<?php

require "connect.inc.php";
require "core.inc.php";
require "api_logger.php";

header("Content-Type: application/json");
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type, Authorization, X-Requested-With");

$startTime = microtime(true);
$endpoint = 'suggestions.php';

$response = array();
$message = '';

$data = json_decode(file_get_contents('php://input'), true);

// Log the request
ApiLogger::logRequest($endpoint, $data, 'POST');

$message .= isset($data['message']) ? "" : "message not received\n";

if (empty($message)) {
    $message_text = trim($data['message']);
    $contact = isset($data['contact']) ? trim($data['contact']) : '';
    $user_id = isset($data['user_id']) && $data['user_id'] !== '' ? (int)$data['user_id'] : null;

    $message .= empty($message_text) ? "message can not be empty\n" : "";

    if (empty($message)) {
        try {
            $query = "INSERT INTO suggestions (user_id, message, contact, status) 
                      VALUES (:user_id, :message, :contact, 'pending')";
            $statement = $connect->prepare($query);
            $statement->bindValue(':user_id', $user_id, $user_id === null ? PDO::PARAM_NULL : PDO::PARAM_INT);
            $statement->bindValue(':message', $message_text, PDO::PARAM_STR);
            $statement->bindValue(':contact', $contact !== '' ? $contact : null, $contact !== '' ? PDO::PARAM_STR : PDO::PARAM_NULL);

            if ($statement->execute()) {
                $suggestion_id = $connect->lastInsertId();
                $response["message"] = "Suggestion submitted successfully";
                $response["status"] = 'true';
                $response["suggestion_id"] = $suggestion_id;
                
                // Log successful response
                $executionTime = microtime(true) - $startTime;
                ApiLogger::logResponse($endpoint, $response, 200, $executionTime);
            } else {
                $response["message"] = "Failed to save suggestion";
                $response["status"] = 'false';
                
                // Log error
                ApiLogger::logError($endpoint, "Failed to execute INSERT query", 500);
            }
            echo json_encode($response);
        } catch (Exception $e) {
            $response["message"] = "Error saving suggestion: " . $e->getMessage();
            $response["status"] = 'false';
            
            // Log error
            ApiLogger::logError($endpoint, "Exception: " . $e->getMessage(), 500);
            
            echo json_encode($response);
        }
    } else {
        $response["message"] = "$message";
        $response["status"] = 'false';
        
        // Log validation error
        $executionTime = microtime(true) - $startTime;
        ApiLogger::logResponse($endpoint, $response, 400, $executionTime);
        
        echo json_encode($response);
    }
} else {
    $response["message"] = "$message";
    $response["status"] = 'false';
    
    // Log validation error
    $executionTime = microtime(true) - $startTime;
    ApiLogger::logResponse($endpoint, $response, 400, $executionTime);
    
    echo json_encode($response);
}
