<#import "template.ftl" as layout>
<@layout.registrationLayout displayInfo=social.displayInfo displayWide=(realm.password && social.providers??); section>
    <#if section = "header">
    <#elseif section = "form">
        <div class="row">
            <div class="col-lg-12 text-center">
                <div id="kc-social-providers" class="card-deck my-3">
                    <#list social.providers as p>
                        <div></div>
                        <div class="card">
                            <div class="card-body h-75" onclick="location.href='${p.loginUrl}';" style="cursor: pointer;">
                                <h5 class="card-title">${p.displayName}</h5>
                                <#if p.alias='medcom-video-lokale'>
                                    <p class="card-text">For dem som har en lokalbruger i VDX.</p>
                                </#if>
                                <#if p.alias='seb'>
                                    <p class="card-text">For dem som er oprettet i SEB</p>
                                </#if>
                                <#if p.alias='kombit'>
                                    <p class="card-text">For brugere som har adgang til kommunale løsninger via KOMBIT</p>
                                </#if>
                            </div>
                            <div class="card-body">
                                <a href="${p.loginUrl}" id="zocial-${p.alias}" class="btn btn-primary" ${p.providerId}"> <span>Fortsæt</span></a>
                            </div>
                            <#if realm.rememberMe && !usernameEditDisabled??>
                                <div class="checkbox">
                                    <label>
                                        <#if login.rememberMe??>
                                            <input tabindex="3" id="rememberMe" name="rememberMe" type="checkbox" checked> ${msg("rememberMe")}
                                        <#else>
                                            <input tabindex="3" id="rememberMe" name="rememberMe" type="checkbox"> ${msg("rememberMe")}
                                        </#if>
                                    </label>
                                </div>
                            </#if>
                        </div>
                    </#list>
                </div>
            </div>
        </div>
    </#if>
</@layout.registrationLayout>