<?php

require "connect.inc.php";
require "core.inc.php";

header("Content-Type: application/json");
header("Access-Control-Allow-Origin: *");

$token = isset($_GET['token']) ? $_GET['token'] : null;

if ($token) {
    $query = "SELECT s.share_id, s.document_id, d.title, d.description, d.file_type, d.file_url, d.gr_date, d.upload_date, d.status
              FROM shared_links s
              LEFT JOIN documents d ON s.document_id = d.document_id
              WHERE s.unique_link_token = :token AND s.status = 'Active' AND d.status = 'Active'";
    $statement = $connect->prepare($query);
    $statement->execute(array(':token' => $token));
    $result = $statement->fetch(PDO::FETCH_ASSOC);
    if ($result) {
        echo json_encode($result);
    } else {
        echo json_encode(array('message' => 'Invalid or expired share link', 'status' => 'false'));
    }
} else {
    echo json_encode(array('message' => 'token not received', 'status' => 'false'));
}

?>

