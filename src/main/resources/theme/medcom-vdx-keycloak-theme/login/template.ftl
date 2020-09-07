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
	<!-- Page Content -->
	<div class="container">
		<div class="row">
			<div class="col-lg-12 text-center my-4">
				<img height="100" src="${url.resourcesPath}/img/vdx_logo_wh.png" />
			</div>
			<h1 class="card-title col-lg-12 text-center text-white" id="clientname"></h5>
		</div>

		<div class="row">
			<div class="col-lg-12 text-center">
				<div class="card-deck my-3">
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
								<a href="${p.loginUrl}" class="btn btn-primary">Fortsæt</a>
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

		<!-- <div class="row">
			<div class="col-lg-12 text-center">
				<div class="card text-center">
				    <div class="card-body">
						<h5 class="card-title">OBS: Log-ind siden er ændret</h5>
						<p class="card-text">For at imødekomme log-ind integrationer til fra andre systemer har vi d. 18 maj 2020 ændret loginsiden en smule.<br />Hvis du tidligere har brugt bookingportalen eller administrationsportalen så skal du vælge "VDX Lokal bruger" ovenfor. Herefter indtaster du dine log-ind oplysninger som normalt.</p>
				    </div>
				    <div class="card-footer text-muted">
						<small class="form-text text-muted">18 maj 2020</small>
				    </div>
				</div>
			</div>
		</div> -->
  </div>

  <script>
		var clientname = ''
		const queryString = window.location.search;
		const urlParams = new URLSearchParams(queryString);
		const client_id = urlParams.get('client_id')
		if(client_id=='medcom:management'){
			clientname = 'Management'
		} else if(client_id=='medcom:booking') {
			clientname = 'Booking'
		}
		console.log(clientname);
		document.getElementById("clientname").innerHTML = clientname;
	</script>

  <!-- Bootstrap core JavaScript -->
  <script src="${url.resourcesPath}/jquery/jquery.slim.min.js"></script>
  <script src="${url.resourcesPath}/bootstrap/js/bootstrap.bundle.min.js"></script>

</body>
</html>
</#macro>
