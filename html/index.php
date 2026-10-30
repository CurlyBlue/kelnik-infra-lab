<?php
echo "<h1>Привет, Кельник!</h1>";
echo "<p>Стек Nginx + PHP-FPM успешно запущен.</p>";

// Проверка подключения к MariaDB
$host = 'db'; // Имя сервиса в docker-compose
$user = 'kelnik_user';
$pass = 'kelnik_pass';
$db = 'kelnik_db';

$conn = new mysqli($host, $user, $pass, $db);
if ($conn->connect_error) {
    die("<p style='color:red'>Ошибка подключения к БД: " . $conn->connect_error . "</p>");
}
echo "<p style='color:green'>Успешное подключение к базе данных MariaDB!</p>";
?>
