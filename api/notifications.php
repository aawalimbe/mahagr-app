<?php

require "connect.inc.php";
require "core.inc.php";

header("Content-Type: application/json");
header("Access-Control-Allow-Origin: *");

$data = json_decode(file_get_contents('php://input'), true);
$user_id = isset($data['user_id']) ? $data['user_id'] : null;

$query = "SELECT notification_id, title, message, related_document_id, scheduled_at, sent_at, status, timestamp 
          FROM notifications 
          WHERE status = 'sent' 
          ORDER BY timestamp DESC 
          LIMIT 50";

$statement = $connect->prepare($query);
$statement->execute();

if ($statement->rowCount() > 0) {
    $output = $statement->fetchAll(PDO::FETCH_ASSOC);
    echo json_encode($output);
} else {
    echo json_encode(array('message' => 'No notifications found', 'status' => 'false'));
}

?>
