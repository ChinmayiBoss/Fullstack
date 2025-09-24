<?php
require 'vendor/autoload.php'; // Composer autoload for MongoDB

// Connect to MongoDB
$client = new MongoDB\Client("mongodb://localhost:27017");
$collection = $client->mydatabase->users; // database: mydatabase, collection: users

// Get form data
$name = $_POST['name'] ?? '';
$email = $_POST['email'] ?? '';

if($name && $email){
    $insertResult = $collection->insertOne([
        'name' => $name,
        'email' => $email
    ]);

    echo "Data inserted with ID: " . $insertResult->getInsertedId();
} else {
    echo "Please fill all fields!";
}
?>
