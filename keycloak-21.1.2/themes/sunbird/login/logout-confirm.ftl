// Function to get query parameter by name
function getQueryParam(name) {
    const urlParams = new URLSearchParams(window.location.search);
    return urlParams.get(name);
}

// Get the redirect URI and client ID from query parameters
const redirectUri = getQueryParam('redirect_uri');
let clientId = getQueryParam('client_id');

// Default to 'account' if client_id is not provided or is empty
if (!clientId) {
    clientId = 'account';
}

// Construct the logout URL
if (redirectUri) {
    const logoutUrl = `/auth/realms/sunbird/protocol/openid-connect/logout?client_id=${clientId}&post_logout_redirect_uri=${encodeURIComponent(redirectUri)}`;
    // Redirect to the logout URL
    window.location.href = logoutUrl;
} else {
    console.error('Redirect URI not provided');
}