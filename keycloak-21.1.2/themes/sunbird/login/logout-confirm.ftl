<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Confirm Logout</title>
    <style>
        body { font-family: Arial, sans-serif; text-align: center; padding: 50px; }
        button { padding: 10px 20px; margin: 5px; }
    </style>
</head>
<body>
    <h1>Are you sure you want to log out?</h1>
    <form method="post" action="${url.logoutConfirmAction}">
        <input type="hidden" name="session_code" value="${session_code}" />
        <button type="submit" name="confirmLogout">Confirm</button>
        <button type="button" onclick="window.history.back();">Cancel</button>
    </form>
</body>
</html>
