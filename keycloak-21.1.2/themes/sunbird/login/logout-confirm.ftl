<#-- Default values for client_id and redirect_uri -->
<#assign clientId = client_id!"portal">
<#assign redirectUri = redirect_uri!"https://cossdev.sunbirded.org/">

<script type="text/javascript">
    // Function to get query parameter by name
    function getQueryParam(name) {
        const urlParams = new URLSearchParams(window.location.search);
        return urlParams.get(name);
    }

    // Get redirect_uri and client_id from query parameters
    const redirectUri = getQueryParam('redirect_uri') || "${redirectUri}";
    const clientId = getQueryParam('client_id') || "${clientId}";

    // Use JavaScript to get the host
    const host = window.location.origin;

    // Construct logout URL
    let logoutUrl = host + `/auth/realms/sunbird/protocol/openid-connect/logout`;

    if (redirectUri) {
        // Add client_id and redirect_uri as query parameters
        logoutUrl += `?client_id=${clientId}&redirect_uri=${encodeURIComponent(redirectUri)}`;
    } else {
        console.error('Redirect URI not provided');
    }

    // Redirect to the constructed logout URL
    window.location.href = logoutUrl;
</script>