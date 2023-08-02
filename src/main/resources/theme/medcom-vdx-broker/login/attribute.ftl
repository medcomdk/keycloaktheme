<#import "template.ftl" as layout>
<@layout.registrationLayout; section>
    <#if section = "header">
    <#elseif section = "form">
        <div class="card text-center">
            <form id="kc-totp-login-form" action="${url.loginAction}" method="post">
                <div class="card-body h-75">
                    <h5 class="card-title">
                        Vælg hvilken organisation du vil logge ind under
                    </h5>
                    <p class="card-text">
                        <select id="totp" name="attribute" class="select">
                            <#list attribute_list! as attribute>
                                <option value="${attribute}"> ${attribute} </option>
                            </#list>
                        </select>
                    </p>
                </div>

                <div id="kc-form-buttons" class="card-body">
                    <input class="btn btn-primary" name="login" id="kc-login" type="submit" value="Fortsæt"/>
                </div>
            </form>
        </div>
    </#if>
</@layout.registrationLayout>