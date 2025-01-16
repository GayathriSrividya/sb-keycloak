<#-- Default values for client_id and redirect_uri -->
<#assign clientId = sunbird_portal_client_id!"portal_client">

<script type="text/javascript">
    // Function to get query parameter by name
    function getQueryParams() {
        const urlParams = new URLSearchParams(window.location.search);
        if (!urlParams.has('client_id')) {
            urlParams.set('client_id', ${clientId});
        }           
        return urlParams.toString();
    }

 
    // Use JavaScript to get the host
    const host = window.location.origin;

    // Construct logout URL
    let logoutUrl = host + `/auth/realms/sunbird/protocol/openid-connect/logout`;

    if (redirectUri) {
        // Add client_id and redirect_uri as query parameters
        logoutUrl += '?' + getQueryParams();
    } else {
        console.error('Redirect URI not provided');
    }

    // Redirect to the constructed logout URL
    window.location.href = logoutUrl;
</script>