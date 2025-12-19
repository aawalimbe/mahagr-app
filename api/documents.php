<?php

require "connect.inc.php";
require "core.inc.php";

header("Content-Type: application/json");
header("Access-Control-Allow-Origin: *");

$data = json_decode(file_get_contents('php://input'), true);

$department = isset($data['department']) ? $data['department'] : null;
$date = isset($data['date']) ? $data['date'] : null;
$search = isset($data['search']) ? $data['search'] : null;
$category_id = isset($data['category_id']) ? $data['category_id'] : null;

$where_conditions = array();
$params = array();

$where_conditions[] = "d.status = 'Active'";

if ($department) {
    $where_conditions[] = "dept.department_name LIKE :department";
    $params[':department'] = '%' . $department . '%';
}

if ($date) {
    $where_conditions[] = "d.gr_date = :date";
    $params[':date'] = $date;
}

if ($search) {
    $where_conditions[] = "(d.title LIKE :search OR d.description LIKE :search)";
    $params[':search'] = '%' . $search . '%';
}

if ($category_id) {
    $where_conditions[] = "d.category_id = :category_id";
    $params[':category_id'] = $category_id;
}

$where_clause = implode(' AND ', $where_conditions);

$query = "SELECT d.document_id, d.title, d.description, d.file_type, d.file_url, d.gr_date, 
                 d.upload_date, c.category_name, dept.department_name, a.name as uploaded_by_name
          FROM documents d 
          LEFT JOIN categories c ON d.category_id = c.category_id 
          LEFT JOIN department dept ON c.department_id = dept.department_id 
          LEFT JOIN admin_users a ON d.uploaded_by = a.admin_id 
          WHERE $where_clause 
          ORDER BY d.upload_date DESC";

$statement = $connect->prepare($query);
$statement->execute($params);

if ($statement->rowCount() > 0) {
    $output = $statement->fetchAll(PDO::FETCH_ASSOC);
    echo json_encode($output);
} else {
    echo json_encode(array('message' => 'No documents found', 'status' => 'false'));
}

?>
