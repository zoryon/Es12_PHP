<?php
include_once "./db/DB.php";

try {
    $db = DB::getInstance();

    // params validation
    if ($_SERVER["REQUEST_METHOD"] !== "GET") {
        throw new Exception("Method Not Allowed", 405);
    }
    
    if (!isset($_GET["nation"]) || empty($_GET["nation"])) {
        throw new Exception("Bad Request", 400);
    }

    // quering the database
    $sql = "
        SELECT * 
        FROM aeroporti AS n 
        WHERE n.nazione = ?
    ";

    $res = $db->executeQuery($sql, "s", [$_GET["nation"]]);
    if (!$res) {
        throw new Exception("No airports found for specified nation", 404);
    }

    $db->setResponse($res);
} catch (Exception $e) {
    $db->setStatus($e->getCode())
        ->setResponse(["error" => $e->getMessage()]);
} finally {
    $db->send();
    exit();
}
?>