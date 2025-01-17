<script type="text/javascript">
    // Function to get query parameter by name
    function getQueryParams() {
        let urlParams = new URLSearchParams(window.location.search);
        console.log({urlParams}, urlParams.toString());
        if (!urlParams.has('client_id')) {
            urlParams.set('client_id', 'portal');
        }           
        console.log({urlParams}, urlParams.toString());
        return urlParams.toString();
    }

    const host = window.location.origin;

    // Construct logout URL
    let logoutUrl = host + `/auth/realms/sunbird/protocol/openid-connect/logout`;
    logoutUrl += '?' + getQueryParams();
    console.log({logoutUrl});
    // Redirect to the constructed logout URL
    window.location.href = logoutUrl;
 
</script>