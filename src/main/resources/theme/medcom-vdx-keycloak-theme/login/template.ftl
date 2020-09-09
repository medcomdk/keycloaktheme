<#macro registrationLayout bodyClass="" displayInfo=false displayMessage=true displayWide=false>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"  "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" class="${properties.kcHtmlClass!}">

<head>
    <meta charset="utf-8">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" >
    <meta http-equiv="X-UA-Compatible" content="IE=11" >
    <meta http-equiv="X-UA-Compatible" content="IE=10" >
    <meta name="robots" content="noindex, nofollow">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>${msg("loginTitle",(realm.displayName!''))}</title>
    <link rel="icon" href="${url.resourcesPath}/img/favicon.ico" />
	<link href="${url.resourcesPath}/css/styles.css" rel="stylesheet" />
	<link href="${url.resourcesPath}/css/sb-admin-2.css" rel="stylesheet" />
	<link href="${url.resourcesPath}/bootstrap/css/bootstrap.min.css" rel="stylesheet" />
</head>

<body>
    <div class="container">
        <div class="row">
            <div class="col-lg-12 text-center my-4">
                <img height="100" src="${url.resourcesPath}/img/vdx_logo_wh.png" />
            </div>

            <!-- Print the clientId -->
            <#if client.clientId?contains(":")>
                <#assign vals=p.displayName?split(":")>
                <h1 class="card-title col-lg-12 text-center text-white" id="clientname">${vals[1]?trim}</h1>
            <#else>
                <h1 class="card-title col-lg-12 text-center text-white" id="clientname">${client.clientId}</h1>
            </#if>
        </div>

        <#nested "form">

        <#if displayInfo>
            <div id="kc-info" class="${properties.kcSignUpClass!}">
                <div id="kc-info-wrapper" class="${properties.kcInfoAreaWrapperClass!}">
                  <#nested "info">
                </div>
            </div>
        </#if>
    </div>



    <!-- Bootstrap core JavaScript -->
    <script src="${url.resourcesPath}/jquery/jquery.slim.min.js"></script>
    <script src="${url.resourcesPath}/bootstrap/js/bootstrap.bundle.min.js"></script>

</body>
</html>
</#macro>