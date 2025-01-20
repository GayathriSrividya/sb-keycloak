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

            async function keycloakLogout() {
                try {
                    const logoutUrl = 'https://cossdev.sunbirded.org/auth/realms/sunbird/protocol/openid-connect/logout';
                    const sessionCode = '${logoutConfirm.code}';
                    const idToken = localStorage.getItem('kc_idToken') || '';
                    
                    const controller = new AbortController();
                    const timeoutId = setTimeout(() => controller.abort(), 10000);
                    
                    const params = new URLSearchParams({
                        'post_logout_redirect_uri': 'https://cossdev.sunbirded.org/',
                        'client_id': 'portal',
                        'session_code': sessionCode
                    });

                    // Add id_token_hint if available
                    if (idToken) {
                        params.append('id_token_hint', idToken);
                    }
                    
                    const response = await fetch(logoutUrl, {
                        method: 'POST',
                        headers: {
                            'Content-Type': 'application/x-www-form-urlencoded'
                        },
                        body: params,
                        credentials: 'include',
                        signal: controller.signal
                    });
                    
                    clearTimeout(timeoutId);
                    
                    if (!response.ok) {
                        throw new Error('Logout failed with status: ' + response.status);
                    }

                    // Clear all tokens and storage
                    clearAllCookies();
                    clearStorage();
                    
                    // Use the response URL for redirect if available, otherwise fallback to default
                    const redirectUrl = response.url || 'https://cossdev.sunbirded.org/';
                    window.location.href = redirectUrl;
                    
                } catch (error) {
                    console.error('Logout error:', error.toString());
                    // Still try to clear everything and redirect
                    clearAllCookies();
                    clearStorage();
                    window.location.href = 'https://cossdev.sunbirded.org/';
                }
            }

            // Call logout immediately when the page loads
            document.addEventListener('DOMContentLoaded', function() {
                keycloakLogout();
            });
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
