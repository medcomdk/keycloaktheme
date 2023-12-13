<#import "template.ftl" as layout>
<@layout.registrationLayout displayInfo=social.displayInfo displayWide=(realm.password && social.providers??); section>
    <#if section = "header">
    <#elseif section = "form">
        <#list social.providers?chunk(3) as providerGroup>
            <div class="row">
                <div class="col-lg-12 text-center">
                    <div id="kc-social-providers" class="card-deck my-3">
                        <#list providerGroup as p>
                            <div class="card">
                                <div class="card-body h-75" onclick="location.href='${p.loginUrl}';" style="cursor: pointer;">
                                    <#if p.displayName?contains(":")>
                                        <#assign vals=p.displayName?split(":") >
                                        <h5 class="card-title">${vals[0]?trim}</h5>
                                        <p class="card-text">${vals[1]?trim}</p>
                                    <#else>
                                        <h5 class="card-title">${p.displayName}</h5>
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
        </#list>
    </#if>
</@layout.registrationLayout>