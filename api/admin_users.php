<?php

require "connect.inc.php";
require "core.inc.php";

header("Content-Type: application/json");
header("Access-Control-Allow-Origin: *");

$query = "SELECT admin_id, name, email, mobile_number, role, status, timestamp FROM admin_users WHERE status = 'Active' ORDER BY name ASC";
$statement = $connect->prepare($query);
$statement->execute();

if ($statement->rowCount() > 0) {
    $output = $statement->fetchAll(PDO::FETCH_ASSOC);
    echo json_encode($output);
} else {
    echo json_encode(array('message' => 'No admin users found', 'status' => 'false'));
}

?>
