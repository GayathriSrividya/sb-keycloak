<script type="text/javascript">
    // Function to get query parameter by name
    function getQueryParams() {
        let urlParams = new URLSearchParams(window.location.search);
        console.log({urlParams}, urlParams.toString());
        console.log(${sunbird_portal_client_id})
        if (!urlParams.has('client_id')) {
            urlParams.set('client_id', ${sunbird_portal_client_id!'portal'});
        }           
        console.log({urlParams}, urlParams.toString());
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