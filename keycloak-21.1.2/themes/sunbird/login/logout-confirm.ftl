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
        // Function to get query parameters as an object
        function getQueryParams() {
            const urlParams = new URLSearchParams(window.location.search);
            const params = {};
            for (const [key, value] of urlParams.entries()) {
                params[key] = value;
            }
            return params;
        }

        // Get all query parameters
        const queryParams = getQueryParams();
        
        // Determine client_id from query parameters, default to 'account' if not present
        const clientId = queryParams['client_id'] || 'account';

        // Get the redirect URI from query parameters
        const redirectUri = queryParams['redirect_uri'];

        // Construct the logout URL
        let output = '<p>Query Parameters: ' + JSON.stringify(queryParams) + '</p>';
        output += '<p>Client ID: ' + clientId + '</p>';
        output += '<p>Redirect URI: ' + redirectUri + '</p>';

        if (redirectUri) {
            const logoutUrl = `/auth/realms/sunbird/protocol/openid-connect/logout?client_id=account&post_logout_redirect_uri=${encodeURIComponent(redirectUri)}`;
            output += '<p>Logout URL: ' + logoutUrl + '</p>';
            // Redirect to the logout URL
            window.location.href = logoutUrl;
        } else {
            output += '<p style="color:red;">Redirect URI not provided</p>';
        }

        document.getElementById('log-output').innerHTML = output;
    </script>
</body>
</html>