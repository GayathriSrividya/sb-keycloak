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
                localStorage.clear();
                sessionStorage.clear();
            }

            let logoutAttempted = false;

            async function keycloakLogout() {
                if (logoutAttempted) {
                    console.log('Logout already in progress');
                    return;
                }

                logoutAttempted = true;
                console.log('Starting logout process');

                try {
                    const idToken = localStorage.getItem('id_token'); // Assuming id_token is stored in localStorage
                    console.log('Session code:', sessionCode);
                    
                    const logoutUrl = `https://cossdev.sunbirded.org/auth/realms/sunbird/protocol/openid-connect/logout?post_logout_redirect_uri=https://cossdev.sunbirded.org/&client_id=portal`;
                    console.log('Making logout GET request to:', logoutUrl);
                    window.location.replace(logoutUrl);
                    
                } catch (error) {
                    // console.error('Logout error:', error);
                    // clearAllCookies();
                    //clearStorage();
                    // window.location.replace('https://cossdev.sunbirded.org/');
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
