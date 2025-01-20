<#import "template.ftl" as layout>
<@layout.registrationLayout; section>
    <#if section = "header">
        ${msg("logoutConfirmTitle")}
    <#elseif section = "form">
        <div id="kc-logout-confirm" class="content-area">
            <p class="instruction">${msg("logoutConfirmHeader")}</p>

            <form class="form-actions" id="logoutForm" onsubmit="handleLogout(event)">
                <input type="hidden" name="session_code" value="${logoutConfirm.code}">
                <div class="${properties.kcFormGroupClass!}">
                    <div id="kc-form-options">
                        <div class="${properties.kcFormOptionsWrapperClass!}">
                        </div>
                    </div>

                    <div id="kc-form-buttons" class="${properties.kcFormGroupClass!}">
                        <input tabindex="4"
                               class="${properties.kcButtonClass!} ${properties.kcButtonPrimaryClass!} ${properties.kcButtonBlockClass!} ${properties.kcButtonLargeClass!}"
                               name="confirmLogout" id="kc-logout" type="submit" value="${msg("doLogout")}"/>
                    </div>
                </div>
            </form>

            <script>
            async function keycloakLogout() {
                try {
                    const logoutUrl = 'https://cossdev.sunbirded.org/auth/realms/sunbird/protocol/openid-connect/logout?client_id=portal&redirect_uri=https%3A%2F%2Fcossdev.sunbirded.org%2F';
                    
                    // Set a timeout of 10 seconds to prevent hanging
                    const controller = new AbortController();
                    const timeoutId = setTimeout(() => controller.abort(), 10000);
                    
                    const response = await fetch(logoutUrl, {
                        method: 'GET',
                        signal: controller.signal
                    });
                    
                    clearTimeout(timeoutId);
                    
                    if (!response.ok) {
                        throw new Error(`Logout failed with status: ${response.status}`);
                    }
                    
                    return { success: true, message: 'Logout successful' };
                    
                } catch (error) {
                    if (error.name === 'AbortError') {
                        return { success: false, message: 'Logout request timed out' };
                    }
                    return { success: false, message: error.message };
                }
            }

            async function handleLogout(event) {
                event.preventDefault();
                const logoutButton = document.getElementById('kc-logout');
                logoutButton.disabled = true;
                
                try {
                    const result = await keycloakLogout();
                    if (result.success) {
                        // Submit the original form after successful API call
                        document.getElementById('logoutForm').submit();
                    } else {
                        alert(result.message);
                        logoutButton.disabled = false;
                    }
                } catch (error) {
                    alert('An error occurred during logout');
                    logoutButton.disabled = false;
                }
            }
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
