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
    console.log('Query Parameters:', queryParams);
    
    // Determine client_id from query parameters, default to 'account' if not present
    const clientId = queryParams['client_id'] || 'account';
    console.log('Client ID:', clientId);

    // Get the redirect URI from query parameters
    const redirectUri = queryParams['redirect_uri'];
    console.log('Redirect URI:', redirectUri);

    // Construct the logout URL
    if (redirectUri) {
        const logoutUrl = `/auth/realms/sunbird/protocol/openid-connect/logout?client_id=${clientId}&post_logout_redirect_uri=${encodeURIComponent(redirectUri)}`;
        console.log('Logout URL:', logoutUrl);
        // Redirect to the logout URL
        window.location.href = logoutUrl;
    } else {
        console.error('Redirect URI not provided');
    }
</script>