<#import "template.ftl" as layout>
<@layout.registrationLayout; section>
    <#if section = "header">
        ${msg("logoutConfirmTitle")}
    <#elseif section = "form">
        <div id="kc-logout-confirm" class="content-area">
            <style>
                .logout-message {
                    text-align: center;
                    font-size: 1.5em;
                    margin: 20px 0;
                    padding: 15px;
                    color: #333;
                    font-weight: bold;
                }
                .logout-spinner {
                    display: inline-block;
                    width: 20px;
                    height: 20px;
                    border: 3px solid #f3f3f3;
                    border-top: 3px solid #3498db;
                    border-radius: 50%;
                    animation: spin 1s linear infinite;
                    margin-left: 10px;
                }
                @keyframes spin {
                    0% { transform: rotate(0deg); }
                    100% { transform: rotate(360deg); }
                }
            </style>
            <div class="logout-message">
                Logging you out securely<span class="logout-spinner"></span>
            </div>

            <script>
            console.log('Script started');

            // Check if we're already in the process of logging out
            if (sessionStorage.getItem('logout_attempted')) {
                console.log('Logout already attempted, redirecting to home');
                window.location.replace('https://cossdev.sunbirded.org/');
                throw new Error('Preventing infinite logout loop');
            }

            // Set the flag immediately
            sessionStorage.setItem('logout_attempted', 'true');

            function clearAllCookies() {
                const cookies = document.cookie.split(';');
                for (let i = 0; i < cookies.length; i++) {
                    const cookie = cookies[i];
                    const eqPos = cookie.indexOf('=');
                    const name = eqPos > -1 ? cookie.substr(0, eqPos) : cookie;
                    document.cookie = name + '=;expires=Thu, 01 Jan 1970 00:00:00 GMT;path=/';
                    document.cookie = name + '=;expires=Thu, 01 Jan 1970 00:00:00 GMT;path=/auth/realms/sunbird';
                }
            }

            function clearStorage() {
                // Keep the logout_attempted flag
                const logoutAttempted = sessionStorage.getItem('logout_attempted');
                localStorage.clear();
                sessionStorage.clear();
                if (logoutAttempted) {
                    sessionStorage.setItem('logout_attempted', logoutAttempted);
                }
            }

            async function keycloakLogout() {
                console.log('Logout function called');
                try {
                    const logoutUrl = 'https://cossdev.sunbirded.org/auth/realms/sunbird/protocol/openid-connect/logout';
                    const sessionCode = '${logoutConfirm.code}';
                    console.log('Session code:', sessionCode);
                    
                    const params = new URLSearchParams({
                        'post_logout_redirect_uri': 'https://cossdev.sunbirded.org/',
                        'client_id': 'portal',
                        'session_code': sessionCode
                    });

                    console.log('Making logout request to:', logoutUrl);
                    const response = await fetch(logoutUrl, {
                        method: 'POST',
                        headers: {
                            'Content-Type': 'application/x-www-form-urlencoded'
                        },
                        body: params,
                        credentials: 'include'
                    });
                    
                    console.log('Logout response status:', response.status);
                    
                    if (!response.ok) {
                        throw new Error('Logout failed with status: ' + response.status);
                    }

                    clearAllCookies();
                    clearStorage();
                    
                    console.log('Redirecting to homepage');
                    window.location.replace('https://cossdev.sunbirded.org/');
                    
                } catch (error) {
                    console.error('Logout error:', error);
                    clearAllCookies();
                    clearStorage();
                    window.location.replace('https://cossdev.sunbirded.org/');
                }
            }

            // Start logout process immediately
            keycloakLogout();
            </script>

            <div id="kc-info-message">
                <#if logoutConfirm.skipLink>
                <#else>
                    <#if (client.baseUrl)?has_content>
                        <p><a href="${client.baseUrl}">${kcSanitize(msg("backToApplication"))?no_esc}</a></p>
                    </#if>
                </#if>
            </div>

            <div class="clearfix"></div>
        </div>
    </#if>
</@layout.registrationLayout>
