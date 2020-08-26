<#import "template.ftl" as layout>
<@layout.registrationLayout displayInfo=true; section>
    <#if section = "title">
        ${msg("loginTotpTitle")}
    <#elseif section = "header">
        ${msg("loginTotpTitle")}
    <#elseif section = "form">
	
	<ol id="kc-totp-settings">
		<li>
			<p>Installer Google Authenticator eller <a href="https://freeotp.github.io/" target="_blank">FreeOTP</a> på din mobile enhed.<br />Begge programmer er tilgængelige i <a href="https://play.google.com">Google Play</a> og Apple App Store.</p>
		</li>
		<li>
			<p>Åbn programmet og scan QR-koden nedenfor</p>
			<div style="padding-left: 30px"><img id="kc-totp-secret-qr-code" src="data:image/png;base64, ${totp.totpSecretQrCode}" alt="Figure: QR-code"></div>
		</li>
		<li>
			<p>Indtast den engangskode, der leveres af appen, og klik på "Fortsæt" for at afslutte opsætningen</p>
		</li>
    </ol>
	
    <form action="${url.loginAction}" class="${properties.kcFormClass!}" id="kc-totp-settings-form" method="post">
        <div class="${properties.kcFormGroupClass!}">
            <div class="${properties.kcInputWrapperClass!}">
                <input type="text" id="totp" name="totp" autocomplete="off" class="${properties.kcInputClass!}" placeholder="Indtast engangskode" autofocus />
            </div>
            <input type="hidden" id="totpSecret" name="totpSecret" value="${totp.totpSecret}" />
        </div>

        <input class="${properties.kcButtonClass!} ${properties.kcButtonPrimaryClass!} ${properties.kcButtonLargeClass!}" id="kc-continue" type="submit" value="${msg("doSubmit")}"/>
    </form>
    </#if>
</@layout.registrationLayout>
