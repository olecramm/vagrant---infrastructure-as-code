<!DOCTYPE html>
<html>
<body>

<h1>My first PHP page</h1>

<?php
echo "Testando conexao <br /> <br />";
$servername = "192.168.15.22:3306";
$username = "phpuser";
$password = "pass";

// Create connection
$conn = new mysqli($servername, $username, $password);

// Check connection
if ($conn->connect_error) {
    die("Conexão falhou: " . $conn->connect_error);
}
echo "Conectado com sucesso";
?>
</body>
</html>