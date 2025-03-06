<?php
include_once "./db/DB.php";

try {
    $db = DB::getInstance();

    // params validation
    if ($_SERVER["REQUEST_METHOD"] !== "GET") {
        throw new Exception("Method Not Allowed", 405);
    }
    
    if (!isset($_GET["date"]) || empty($_GET["date"])) {
        throw new Exception("Bad Request", 400);
    }

    // quering the database
    $sql = "
        SELECT a1.citta, a2.citta
        FROM voli AS v
        JOIN aeroporti AS a1 ON a1.id_aeroporto = v.id_aeroporto_partenza
        JOIN aeroporti AS a2 ON a2.id_aeroporto = v.id_aeroporto_arrivo
        WHERE v.data = ?
    ";

    $res = $db->executeQuery($sql, "s", [$_GET["date"]]);
    if (!$res) {
        throw new Exception("No airports found for specified date", 404);
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