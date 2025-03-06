<?php
class DB {
    // attributes
    private $conn;
    private $status = 200;
    private $headers = [];
    private $response = [];
    private static $instance = null;

    private $DB_CONFIG = [
        "host" => "localhost",
        "user" => "root",
        "password" => "",
        "database" => "es12",
    ];

    // constructor
    private function __construct() {
        $this->connect();
        $this->setDefaultHeaders();
    }

    // Singleton -> ensures only one instance of the class is created
    // this way, only on DB connection is enstablished
    public static function getInstance(): self {
        if (!self::$instance) {
            self::$instance = new self();
        }
        return self::$instance;
    }

    // connect to the database
    private function connect(): void {
        $this->conn = new mysqli(
            $this->DB_CONFIG["host"],
            $this->DB_CONFIG["user"],
            $this->DB_CONFIG["password"],
            $this->DB_CONFIG["database"]
        );

        if ($this->conn->connect_error) {
            $this->handleError("Database connection failed: " . $this->conn->connect_error, 500);
        }
    }

    // by default, set Content-Type header to application/json
    private function setDefaultHeaders(): void {
        $this->headers = [
            "Content-Type" => "application/json",
        ];
    }

    public function setStatus(int $status): self {
        $this->status = $status;
        return $this;
    }

    public function addHeader(string $name, string $value): self {
        $this->headers[$name] = $value;
        return $this;
    }

    public function setResponse(array $data): self {
        $this->response = $data;
        return $this;
    }

    /* 
        SELECT function
        @return an array of rows -> in case of selecting a single item, 
        only the first element of the array should be returned
        (with res[0])
    */
    public function executeQuery(string $sql, string $types, array $params = []): array {
        $stmt = $this->conn->prepare($sql);
        if (!$stmt) {
            $this->handleError("Query preparation failed: " . $this->conn->error, 500);
        }

        if (!empty($params) && !empty($types)) {
            // ... is the spread operator, it deconstrcts the array (similar to js)
            $stmt->bind_param($types, ...$params);
        }

        if (!$stmt->execute()) {
            $this->handleError("Query execution failed: " . $stmt->error, 500);
        }

        $result = $stmt->get_result();
        $data = [];
        while ($row = $result->fetch_assoc()) {
            $data[] = $row;
        }

        $stmt->close();
        return $data;
    }

    // POST function
    public function insert(string $sql, string $types = "", array $params = []): int {
        $stmt = $this->conn->prepare($sql);
        if (!$stmt) {
            $this->handleError("Insert preparation failed: " . $this->conn->error, 500);
        }

        if (!empty($params)) {
            $stmt->bind_param($types, ...$params);
        }

        if (!$stmt->execute()) {
            $this->handleError("Insert failed: " . $stmt->error, 500);
        }

        $insertId = $stmt->insert_id;
        $stmt->close();
        return $insertId;
    }

    // PUT function
    public function update(string $sql, string $types = "", array $params = []): int {
        $stmt = $this->conn->prepare($sql);
        if (!$stmt) {
            $this->handleError("Update preparation failed: " . $this->conn->error, 500);
        }

        if (!empty($params)) {
            $stmt->bind_param($types, ...$params);
        }

        if (!$stmt->execute()) {
            $this->handleError("Update failed: " . $stmt->error, 500);
        }

        $affectedRows = $stmt->affected_rows;
        $stmt->close();
        return $affectedRows;
    }

    // DELETE function
    public function delete(string $sql, string $types = "", array $params = []): int {
        return $this->update($sql, $types, $params);
    }

    // send the final response
    public function send(): void {
        if (!headers_sent()) {
            http_response_code($this->status);
            foreach ($this->headers as $name => $value) {
                header("$name: $value");
            }
        }

        echo json_encode($this->response);
        exit();
    }

    private function handleError(string $message, int $status = 500): void {
        $this->setStatus($status)
            ->setResponse(["error" => $message])
            ->send();
    }

    public function __destruct() {
        if ($this->conn) {
            $this->conn->close();
        }
    }
}