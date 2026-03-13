/**
 * Sets the password reset link to the stage URL when Keycloak is running on login.vconf-stage.dk.
 * Prod (login.vconf.dk) uses the default href from the HTML.
 */
(function () {
    document.addEventListener("DOMContentLoaded", function () {
        var link = document.getElementById("password-reset-link");
        if (link && window.location.hostname === "login.vconf-stage.dk") {
            link.href = "https://vconf-stage.dk/passwordreset";
        }
    });
})();
