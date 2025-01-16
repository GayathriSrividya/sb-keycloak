<#-- Default value for client_id -->
<#assign clientId = ${sunbird_portal_client_id!"portal_client"}>

<script type="text/javascript">
    // Function to get query parameters and ensure client_id is set
    function getQueryParams() {
        const urlParams = new URLSearchParams(window.location.search);
        
        // Log the initial query parameters
        console.log('Initial Query Parameters:', urlParams.toString());

        // Check if client_id exists, if not, set it
        if (!urlParams.has('client_id')) {
            urlParams.set('client_id', "${clientId}");
            console.log('client_id was not present, setting to:', "${clientId}");
        } else {
            console.log('client_id exists:', urlParams.get('client_id'));
        }

        // Log the final query parameters
        console.log('Final Query Parameters:', urlParams.toString());

        return urlParams.toString();
    }

    // Use JavaScript to get the host
    const host = window.location.origin;

    // Construct logout URL
    let logoutUrl = host + `/auth/realms/sunbird/protocol/openid-connect/logout`;
    logoutUrl += '?' + getQueryParams();
    
    // Redirect to the constructed logout URL
    window.location.href = logoutUrl;
</script>