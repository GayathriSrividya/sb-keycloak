<script type="text/javascript">
    // Function to construct query parameters
    function getQueryParams() {
        let urlParams = new URLSearchParams(window.location.search);

        // Check if the script has already redirected
        if (urlParams.has('redirected')) {
            console.log("Redirection already handled. Exiting script.");
            return null; // Prevent further redirection
        }

        // Ensure `client_id` is present
        if (!urlParams.has('client_id')) {
            urlParams.set('client_id', 'portal');
        }

        // Mark the URL as redirected to avoid loops
        urlParams.set('redirected', 'true');

        return urlParams.toString(); // Return the updated query string
    }

    // Get the current host
    const host = window.location.origin;

    // Get updated query parameters
    const queryParams = getQueryParams();

    // Redirect to the logout URL if redirection is required
    if (queryParams) {
        const logoutUrl = host + `/auth/realms/sunbird/protocol/openid-connect/logout?${queryParams}`;
        console.log("Redirecting to logout URL:", logoutUrl);

        // Trigger the redirection
        window.location.href = logoutUrl;
    }
</script>