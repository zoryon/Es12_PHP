<?php
    if ($_SERVER["REQUEST_METHOD"] !== "GET") {
        header("HTTP/1.1 405 Method Not Allowed");
        exit();
    };

    // params validation
    if (!isset($_GET["nation"]) || empty($_GET["nation"])) {
        header("HTTP/1.1 400 Bad Request");
        exit();
    };
?>

<!DOCTYPE html>
<html lang="en">

<head>
    <!-- style link -->
    <link rel="stylesheet" href="../assets/css/globals.css">

    <!-- scripts -->
    <script src="https://unpkg.com/@tailwindcss/browser@4"></script>
    <script src="../assets/js/nations.js"></script>

    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Specific Nation Page</title>
</head>

<body>
    <div id="nations-container"></div>
</body>

</html>