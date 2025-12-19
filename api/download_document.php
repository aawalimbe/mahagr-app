<?php

require "connect.inc.php";
require "core.inc.php";

header("Access-Control-Allow-Origin: *");

$data = json_decode(file_get_contents('php://input'), true);
$message = '';
$message .= isset($data['document_id']) ? "" : "document_id not received\n";

if (empty($message)) {
    $document_id = $data['document_id'];
    $message .= empty($document_id) ? "document_id can not be empty\n" : "";
    if (empty($message)) {
        $query = "SELECT file_url, file_type, title FROM documents WHERE document_id = :document_id AND status = 'Active'";
        $statement = $connect->prepare($query);
        $statement->execute(array(':document_id' => $document_id));
        $result = $statement->fetch(PDO::FETCH_ASSOC);
        if ($result && !empty($result['file_url']) && file_exists($result['file_url'])) {
            $file = $result['file_url'];
            $file_type = $result['file_type'] ?: mime_content_type($file);
            $file_name = basename($file);
            header('Content-Description: File Transfer');
            header('Content-Type: ' . $file_type);
            header('Content-Disposition: attachment; filename="' . $file_name . '"');
            header('Expires: 0');
            header('Cache-Control: must-revalidate');
            header('Pragma: public');
            header('Content-Length: ' . filesize($file));
            readfile($file);
            exit;
        } else {
            echo json_encode(array('message' => 'File not found', 'status' => 'false'));
        }
    } else {
        echo json_encode(array('message' => $message, 'status' => 'false'));
    }
} else {
    echo json_encode(array('message' => $message, 'status' => 'false'));
}

?>

