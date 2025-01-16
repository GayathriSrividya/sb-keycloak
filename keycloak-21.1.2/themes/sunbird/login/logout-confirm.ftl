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
    if (redirectUri) {
        const logoutUrl = `/auth/realms/sunbird/protocol/openid-connect/logout?client_id=${clientId}&post_logout_redirect_uri=${encodeURIComponent(redirectUri)}`;
        // Redirect to the logout URL
        window.location.href = logoutUrl;
    } else {
        console.error('Redirect URI not provided');
    }
</script>