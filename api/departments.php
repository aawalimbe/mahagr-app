<?php

require "connect.inc.php";
require "core.inc.php";

header("Content-Type: application/json");
header("Access-Control-Allow-Origin: *");

$query = "SELECT department_id, department_name, status, timestamp FROM department WHERE status = 'Active' ORDER BY department_name ASC";
$statement = $connect->prepare($query);
$statement->execute();

if ($statement->rowCount() > 0) {
    $output = $statement->fetchAll(PDO::FETCH_ASSOC);
    echo json_encode($output);
} else {
    echo json_encode(array('message' => 'No departments found', 'status' => 'false'));
}

?>
