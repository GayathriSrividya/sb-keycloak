<script type="text/javascript">
    // Function to get query parameter by name
    function getQueryParam(name) {
        const urlParams = new URLSearchParams(window.location.search);
        return urlParams.get(name);
    }

    // Function to add query parameters to a URL
    function addQueryParam(url, key, value) {
        const urlObj = new URL(url, window.location.origin);
        if (!urlObj.searchParams.has(key)) {
            urlObj.searchParams.set(key, value);
        }
        return urlObj.toString();
    }

    // Get redirect_uri and client_id from query parameters
    const redirectUri = getQueryParam('redirect_uri');
    let clientId = getQueryParam('client_id') || 'defaultClientId'; // Fallback to default if client_id is missing

    // Construct logout URL
    let logoutUrl = `${window.location.origin}/auth/realms/sunbird/protocol/openid-connect/logout`;

    if (redirectUri) {
        logoutUrl = addQueryParam(logoutUrl, 'client_id', clientId);
        logoutUrl = addQueryParam(logoutUrl, 'redirect_uri', redirectUri);
        window.location.href = logoutUrl; // Redirect to the constructed logout URL
    } else {
        console.error('Redirect URI not provided');
    }
</script>
