<?php

require "connect.inc.php";
require "core.inc.php";

header("Content-Type: application/json");
header("Access-Control-Allow-Origin: *");

$data = json_decode(file_get_contents('php://input'), true);

$message = '';
$message .= isset($data['document_id']) ? "" : "document_id not received\n";

if (empty($message)) {
    $document_id = $data['document_id'];
    
    $message .= empty($document_id) ? "document_id can not be empty\n" : "";
    
    if (empty($message)) {
        $document = getDocumentDetails($connect, $document_id);
        
        if ($document) {
            // Log access if user_id is provided
            if (isset($data['user_id']) && !empty($data['user_id'])) {
                logDocumentAccess($connect, $data['user_id'], $document_id);
            }
            
            echo json_encode($document);
        } else {
            echo json_encode(array('message' => 'Document not found', 'status' => 'false'));
        }
    } else {
        echo json_encode(array('message' => $message, 'status' => 'false'));
    }
} else {
    echo json_encode(array('message' => $message, 'status' => 'false'));
}

?>
