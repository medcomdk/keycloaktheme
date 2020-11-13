<#import "template.ftl" as layout>
<@layout.registrationLayout displayMessage=false; section>
    <#if section = "form">
        <div id="kc-error-message">
            <div class="row">
                <div class="col-lg-12 text-center">
                    <div class="card">
                        <div class="card-body h-75">
                            <h5 class="card-title">Ugyldig URL <br/> Du videresendes til log ind om 5 sekunder</h5>
                            <p>${message.summary?no_esc}</p>
                        </div>
                        <div class="card-body" id="btn-redirect">
                            <a href="#" id="redirect" class="btn btn-primary"> <span>Forsæt</span></a>
                        </div>
                    </div>
                </div>
            </div>

            <script type="text/javascript">
                var url_string = window.location.href
                var url = new URL(url_string);
                var replayState = url.searchParams.get("RelayState");
                console.log("Fejl: ${message.summary?no_esc}");

                document.getElementById("btn-redirect").onclick = function() {
                    window.location.replace(replayState);
                };
                setTimeout(function () {
                   window.location.replace(replayState);
                }, 5000);

            </script>
        </div>
    </#if>
</@layout.registrationLayout>