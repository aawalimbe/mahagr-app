<?php

require "connect.inc.php";
require "core.inc.php";

header("Content-Type: application/json");
header("Access-Control-Allow-Origin: *");

$data = json_decode(file_get_contents('php://input'), true);
$document_id = isset($data['document_id']) ? $data['document_id'] : null;
$user_id = isset($data['user_id']) ? $data['user_id'] : null;

$where = [];
$params = [];
if ($document_id) {
    $where[] = 'l.document_id = :document_id';
    $params[':document_id'] = $document_id;
}
if ($user_id) {
    $where[] = 'l.user_id = :user_id';
    $params[':user_id'] = $user_id;
}
$where[] = "l.status = 'Active'";
$where_clause = count($where) ? 'WHERE ' . implode(' AND ', $where) : '';

$query = "SELECT l.log_id, l.user_id, u.email, l.document_id, d.title, l.access_time, l.timestamp
          FROM document_access_logs l
          LEFT JOIN users u ON l.user_id = u.user_id
          LEFT JOIN documents d ON l.document_id = d.document_id
          $where_clause
          ORDER BY l.access_time DESC
          LIMIT 100";
$statement = $connect->prepare($query);
$statement->execute($params);

if ($statement->rowCount() > 0) {
    $output = $statement->fetchAll(PDO::FETCH_ASSOC);
    echo json_encode($output);
} else {
    echo json_encode(array('message' => 'No access logs found', 'status' => 'false'));
}

?>

