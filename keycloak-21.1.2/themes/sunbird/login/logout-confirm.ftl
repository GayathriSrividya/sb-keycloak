<script type="text/javascript">
    // Function to get query parameter by name
    function getQueryParam(name) {
        const urlParams = new URLSearchParams(window.location.search);
        return urlParams.get(name);
    }

    // Get the redirect URI from query parameters
    const redirectUri = getQueryParam('redirect_uri');

    // Redirect to the dynamic URI if it exists
    if (redirectUri) {
        window.location.href = redirectUri;
    } else {
        // Optionally handle the case where redirect_uri is not provided
        console.error('Redirect URI not provided');
    }
</script>