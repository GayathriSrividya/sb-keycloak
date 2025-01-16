<!DOCTYPE html>
<script type="text/javascript">
    // Function to get query parameter by name
    function getQueryParam(name) {
        let urlParams = new URLSearchParams(window.location.search);
        return urlParams.get(name);
    }

    // Get the redirect URI from query parameters
    let redirectUri = getQueryParam('redirect_uri');

    // Redirect to the dynamic URI if it exists
    if (redirectUri) {
        const logoutUrl = `/auth/realms/sunbird/protocol/openid-connect/logout?client_id=account&post_logout_redirect_uri=redirectUri`;
        output += '<p>Logout URL: ' + logoutUrl + '</p>';
        // Redirect to the logout URL
        window.location.href = logoutUrl;
    } else {
        // Optionally handle the case where redirect_uri is not provided
        console.log('Redirect URI not provided');
    }
</script>