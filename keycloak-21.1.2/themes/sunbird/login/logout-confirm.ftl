<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Logout Confirmation</title>
</head>
<body>
    <h1>Logout Confirmation</h1>
    <div id="log-output"></div>

    <script type="text/javascript">
        // Function to get query parameter by name
        function getQueryParam(name) {
            let urlParams = new URLSearchParams(window.location.search);
            return urlParams.get(name);
        }

        // Get the redirect URI from query parameters
        let redirectUri = getQueryParam('redirect_uri');

        // Define the host for logout
        const host = window.location.origin; 

        // Redirect to the dynamic URI if it exists
        if (redirectUri) {
            const logoutUrl = `${host}/auth/realms/sunbird/protocol/openid-connect/logout?client_id=account&redirect_uri=${redirectUri}`;
            document.getElementById('log-output').innerHTML = '<p>Logout URL: ' + logoutUrl + '</p>';
            // Redirect to the logout URL
            window.location.href = logoutUrl;
        } else {
            // Optionally handle the case where redirect_uri is not provided
            document.getElementById('log-output').innerHTML = '<p style="color:red;">Redirect URI not provided</p>';
        }
    </script>
</body>
</html>