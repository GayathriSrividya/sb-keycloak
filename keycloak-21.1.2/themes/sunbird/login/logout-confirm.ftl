<#import "template.ftl" as layout>
<@layout.registrationLayout; section>
    <#if section = "header">
        ${msg("logoutConfirmTitle")}
    <#elseif section = "form">
        <div id="kc-logout-confirm" class="content-area">
            <p class="instruction">${msg("logoutConfirmHeader")}</p>

            <script>
            async function keycloakLogout() {
                try {
                    const logoutUrl = 'https://cossdev.sunbirded.org/auth/realms/sunbird/protocol/openid-connect/logout?client_id=portal&redirect_uri=https%3A%2F%2Fcossdev.sunbirded.org%2F';
                    
                    const controller = new AbortController();
                    const timeoutId = setTimeout(() => controller.abort(), 10000);
                    
                    const response = await fetch(logoutUrl, {
                        method: 'GET',
                        signal: controller.signal,
                        credentials: 'include'
                    });
                    
                    clearTimeout(timeoutId);
                    
                    if (!response.ok) {
                        throw new Error('Logout failed with status: ' + response.status);
                    }
                    
                    // Redirect to the main page after successful logout
                    window.location.href = 'https://cossdev.sunbirded.org/';
                    
                } catch (error) {
                    console.error('Logout error:', error.toString());
                    // Still redirect even if there's an error
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
