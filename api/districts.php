<?php

require "connect.inc.php";
require "core.inc.php";

header("Content-Type: application/json");
header("Access-Control-Allow-Origin: *");

// For now, returning a static list of districts as per the README
// In production, this would come from a districts table
$districts = array(
    array('id' => 1, 'name' => 'Mumbai'),
    array('id' => 2, 'name' => 'Pune'),
    array('id' => 3, 'name' => 'Nagpur'),
    array('id' => 4, 'name' => 'Thane'),
    array('id' => 5, 'name' => 'Nashik'),
    array('id' => 6, 'name' => 'Aurangabad'),
    array('id' => 7, 'name' => 'Solapur'),
    array('id' => 8, 'name' => 'Kolhapur'),
    array('id' => 9, 'name' => 'Amravati'),
    array('id' => 10, 'name' => 'Nanded'),
    array('id' => 11, 'name' => 'Sangli'),
    array('id' => 12, 'name' => 'Jalgaon'),
    array('id' => 13, 'name' => 'Akola'),
    array('id' => 14, 'name' => 'Latur'),
    array('id' => 15, 'name' => 'Dhule'),
    array('id' => 16, 'name' => 'Ahmednagar'),
    array('id' => 17, 'name' => 'Chandrapur'),
    array('id' => 18, 'name' => 'Jalna'),
    array('id' => 19, 'name' => 'Parbhani'),
    array('id' => 20, 'name' => 'Buldhana'),
    array('id' => 21, 'name' => 'Yavatmal'),
    array('id' => 22, 'name' => 'Osmanabad'),
    array('id' => 23, 'name' => 'Nandurbar'),
    array('id' => 24, 'name' => 'Washim'),
    array('id' => 25, 'name' => 'Hingoli'),
    array('id' => 26, 'name' => 'Gadchiroli'),
    array('id' => 27, 'name' => 'Bhandara'),
    array('id' => 28, 'name' => 'Gondia'),
    array('id' => 29, 'name' => 'Wardha'),
    array('id' => 30, 'name' => 'Ratnagiri'),
    array('id' => 31, 'name' => 'Sindhudurg'),
    array('id' => 32, 'name' => 'Raigad'),
    array('id' => 33, 'name' => 'Satara'),
    array('id' => 34, 'name' => 'Beed'),
    array('id' => 35, 'name' => 'Usmanabad'),
    array('id' => 36, 'name' => 'Bid')
);

echo json_encode($districts);

?>
