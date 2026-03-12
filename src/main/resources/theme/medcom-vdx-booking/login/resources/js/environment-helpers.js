/**
 * Sætter password reset-link til stage URL hvis Keycloak kører på login.vconf-stage.dk.
 * Prod (login.vconf.dk) bruger default href fra HTML.
 */
(function () {
    var link = document.getElementById("password-reset-link");
    if (link && window.location.hostname === "login.vconf-stage.dk") {
        link.href = "https://vconf-stage.dk/passwordreset";
    }
})();
