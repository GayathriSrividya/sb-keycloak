<#-- Default value for client_id -->
<#assign clientId = sunbird_portal_client_id!"portal_client">

<script type="text/javascript">
    // Use JavaScript to get the host
    const host = window.location.origin;

    // Construct logout URL
    let logoutUrl = host + `/auth/realms/sunbird/protocol/openid-connect/logout`;

    // Get query parameters
    const urlParams = new URLSearchParams(window.location.search);

    // Check if client_id exists, if not, set it
    if (!urlParams.has('client_id')) {
        urlParams.set('client_id', "${clientId}");
    }

    // Append all query parameters to the logout URL
    logoutUrl += `?${urlParams.toString()}`;

    // Redirect to the constructed logout URL
    window.location.href = logoutUrl;
</script>