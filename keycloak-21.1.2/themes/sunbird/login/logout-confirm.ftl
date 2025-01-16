<#-- Check if client_id and redirect_uri are provided -->
<#assign clientId = client_id!"portal">
<#assign redirectUri = redirect_uri!"http://cossdev.sunbirded.org/">

<script type="text/javascript">
    // Function to add query parameters to a URL
    function addQueryParam(url, key, value) {
        const urlObj = new URL(url, window.location.origin);
        if (!urlObj.searchParams.has(key)) {
            urlObj.searchParams.set(key, value);
        }
        return urlObj.toString();
    }

    // Get redirect_uri and client_id from FreeMarker
    const redirectUri = "${redirectUri}";
    const clientId = "${clientId}";

    // Dynamically construct the host
    const host = window.location.origin;

    // Construct logout URL
    let logoutUrl = host + `/auth/realms/sunbird/protocol/openid-connect/logout`;

    if (redirectUri) {
        // Add client_id and redirect_uri as query parameters
        logoutUrl = addQueryParam(logoutUrl, 'client_id', clientId);
        logoutUrl = addQueryParam(logoutUrl, 'redirect_uri', redirectUri);
    } else {
        console.error('Redirect URI not provided');
    }

    // Redirect to the constructed logout URL
    window.location.href = logoutUrl;
</script>
