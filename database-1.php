<!DOCTYPE html>
<html>
   <head>
      <meta charset="utf-8">
      <title>Search Results</title>
      <style type="text/css">
         body { font-family: sans-serif; background-color: lightyellow; }
         table { background-color: lightblue; border-collapse: collapse; border: 1px solid gray; width: 80%; margin: 20px auto; }
         td, th { padding: 10px; border: 1px solid gray; text-align: left; }
         tr:nth-child(odd) { background-color: white; }
      </style>
   </head>
   <body>
      <?php
         // Database connection details
         $servername = "localhost";
         $username = "root";
         $password = "";
         $dbname = "real_estate_db";
         $query_type = $_POST['query_type'] ?? ''; // Default is empty
         $query = '';
         $database = new mysqli($servername, $username, $password, $dbname);

         if ($database->connect_error) {
            die("<p>Bad Connection: " . htmlspecialchars($database->connect_error) . "</p></body></html>");
         }

         // Main Query Switch Statement
         switch ($query_type) {
            case 'separate_listings':
               $house_query = "SELECT P.address AS PropertyAddress, P.ownerName, P.price, 
                                      H.bedrooms, H.bathrooms, H.size 
                               FROM House H 
                               JOIN Property P ON H.address = P.address";
               $business_query = "SELECT P.address AS PropertyAddress, P.ownerName, P.price, 
                                         B.type AS BusinessType, B.size AS BusinessSize 
                                  FROM BusinessProperty B 
                                  JOIN Property P ON B.address = P.address";
               $house_result = $database->query($house_query);
               if (!$house_result) {
                  die("<p>Could not execute house query: " . htmlspecialchars($database->error) . "</p></body></html>");
               }

               // House Listings html
               echo "<h2>House Listings</h2>";
               echo "<table border='1'>";
               echo "<tr>
                     <th>Property Address</th>
                     <th>Owner Name</th>
                     <th>Price</th>
                     <th>Bedrooms</th>
                     <th>Bathrooms</th>
                     <th>Size (sq ft)</th>
                     </tr>";
               while ($row = $house_result->fetch_assoc()) {
                  echo "<tr>";
                  echo "<td>" . htmlspecialchars($row['PropertyAddress']) . "</td>";
                  echo "<td>" . htmlspecialchars($row['ownerName']) . "</td>";
                  echo "<td>" . htmlspecialchars($row['price']) . "</td>";
                  echo "<td>" . htmlspecialchars($row['bedrooms']) . "</td>";
                  echo "<td>" . htmlspecialchars($row['bathrooms']) . "</td>";
                  echo "<td>" . htmlspecialchars($row['size']) . "</td>";
                  echo "</tr>";
               }
               echo "</table>";

               $business_result = $database->query($business_query);
               if (!$business_result) {
                  die("<p>Could not execute business query: " . htmlspecialchars($database->error) . "</p></body></html>");
               }

               // Businesses html
               echo "<h2>Business Property Listings</h2>";
               echo "<table border='1'>";
               echo "<tr>
                        <th>Property Address</th>
                        <th>Owner Name</th>
                        <th>Price</th>
                        <th>Business Type</th>
                        <th>Size (sq ft)</th>
                     </tr>";
               while ($row = $business_result->fetch_assoc()) {
                  echo "<tr>";
                  echo "<td>" . htmlspecialchars($row['PropertyAddress']) . "</td>";
                  echo "<td>" . htmlspecialchars($row['ownerName']) . "</td>";
                  echo "<td>" . htmlspecialchars($row['price']) . "</td>";
                  echo "<td>" . htmlspecialchars($row['BusinessType']) . "</td>";
                  echo "<td>" . htmlspecialchars($row['BusinessSize']) . "</td>";
                  echo "</tr>";
               }
               echo "</table>";
               break;

            case 'search_houses':
               $min_price = isset($_POST['min_price']) && is_numeric($_POST['min_price']) ? $_POST['min_price'] : 0;
               $max_price = isset($_POST['max_price']) && is_numeric($_POST['max_price']) ? $_POST['max_price'] : 9999999;
               $bedrooms = isset($_POST['bedrooms']) && is_numeric($_POST['bedrooms']) ? $_POST['bedrooms'] : null;
               $bathrooms = isset($_POST['bathrooms']) && is_numeric($_POST['bathrooms']) ? $_POST['bathrooms'] : null;

               $query = "SELECT P.address AS PropertyAddress, P.ownerName, P.price, 
                         H.bedrooms, H.bathrooms, H.size 
                         FROM House H 
                         JOIN Property P ON H.address = P.address 
                         WHERE P.price BETWEEN $min_price AND $max_price";
               if ($bedrooms !== null) {
                  $query .= " AND H.bedrooms = $bedrooms";
               }
               if ($bathrooms !== null) {
                  $query .= " AND H.bathrooms = $bathrooms";
               }
               break;

            case 'search_business':
               $min_price = isset($_POST['min_price']) && is_numeric($_POST['min_price']) ? $_POST['min_price'] : 0;
               $max_price = isset($_POST['max_price']) && is_numeric($_POST['max_price']) ? $_POST['max_price'] : 9999999;
               $min_size = isset($_POST['min_size']) && is_numeric($_POST['min_size']) ? $_POST['min_size'] : 0;
               $max_size = isset($_POST['max_size']) && is_numeric($_POST['max_size']) ? $_POST['max_size'] : 9999999;

               $query = "SELECT P.address AS PropertyAddress, P.ownerName, P.price, 
                         B.type AS BusinessType, B.size AS BusinessSize 
                         FROM BusinessProperty B 
                         JOIN Property P ON B.address = P.address 
                         WHERE P.price BETWEEN $min_price AND $max_price 
                         AND B.size BETWEEN $min_size AND $max_size";
               break;

            case 'all_agents':
               $query = "SELECT * FROM Agent";
               break;

            case 'all_buyers':
               $query = "SELECT * FROM Buyer";
               break;

            case 'manual_query':
               $manual_query = trim($_POST['manual_query'] ?? '');
               if (empty($manual_query)) {
                     die("<p>No query entered.</p></body></html>");
               }
               echo "<p>Executing Manual Query: " . htmlspecialchars($manual_query) . "</p>";
               $result = $database->query($manual_query);
               if (!$result) {
                  die("<p>Could not execute query: " . htmlspecialchars($database->error) . "</p></body></html>");
               }
               echo "<h2>Manual Query Results</h2>";
               echo "<table border='1'>";
               echo "<tr>";
               while ($field = $result->fetch_field()) {
                  echo "<th>" . htmlspecialchars($field->name) . "</th>";
               }
               echo "</tr>";
               while ($row = $result->fetch_assoc()) {
                  echo "<tr>";
                  foreach ($row as $value) {
                     echo "<td>" . htmlspecialchars($value) . "</td>";
                  }
                  echo "</tr>";
               }
               echo "</table>";
               break;

            default:
               die("<p>Invalid query type.</p></body></html>");
         }

         if ($query_type !== 'manual_query') {
            if (!empty($query)) {
               $result = $database->query($query);
         
               // Query Type
               echo "<table>";
               echo "<caption>Results of Query: " . htmlspecialchars($query) . "</caption>";
               echo "<tr>";
         
               //column
               while ($field = $result->fetch_field()) {
                  echo "<th>" . htmlspecialchars($field->name) . "</th>";
               }
               echo "</tr>";
               //row
               while ($row = $result->fetch_assoc()) {
                  echo "<tr>";
                  foreach ($row as $value) {
                     echo "<td>" . htmlspecialchars($value) . "</td>";
                  }
                  echo "</tr>";
               }
               echo "</table>";
            }

            if (isset($result) && $result) {
               $result->free();
            }
         }
         // Close the database connection
         $database->close();
      ?>
   </body>
</html>