<?php
    if ($_REQUEST["METHOD"] !== "GET") return null;

    // params validation
    if (!isset($_GET["nation"])) return null;

    $nation = $_GET["nation"];
?>

<!DOCTYPE html>
<html lang="en">

<head>
    <!-- style link -->
    <link rel="stylesheet" href="../assets/css/globals.css">

    <!-- scripts -->
    <script src="https://unpkg.com/@tailwindcss/browser@4"></script>
    <script src="../assets/js/specific-nation.js"></script>

    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Specific Nation Page</title>
</head>

<body>
    <div id="nations-container"></div>
</body>

</html>