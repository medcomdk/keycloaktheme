# MedCom VDX Keycloak Theme

Custom Keycloak-temaer til VDX-platformens login-sider. Pakken indeholder to separate temaer målrettet forskellige login-flows i VDX.

## Temaer

### medcom-vdx-broker

Identity Broker-tema til valg af ekstern identitetsudbyder (IdP). Bruges når brugere skal vælge login via KOMBIT, regionale ADFS-forbindelser eller andre SAML-baserede IdP'er.

**Indeholder tema-typer:** Login, Account, Email

**Tilpasninger:**
- Eget Bootstrap-baseret layout med VDX-logo og branding
- IdP'er vises som Bootstrap-kort (cards) i et responsivt grid (3 pr. række)
- Klient-/IdP-navne udtrækkes via `:` i `displayName` og `clientId` (fx `Organisation: Navn`)
- Organisationsvalg via dropdown (`attribute.ftl`) når bruger tilhører flere organisationer
- Tilpasset fejlside med automatisk redirect efter 5 sekunder (via RelayState-parameter)
- Danske oversættelser for alle login-, fejl- og valideringsmeddelelser

### medcom-vdx-booking

Login-tema til VDX Booking. Bruges til standard brugernavn/adgangskode-login med understøttelse af TOTP (Time-based One-Time Password).

**Indeholder tema-typer:** Login, Account, Email

**Tilpasninger:**
- W3.CSS-baseret layout med Raleway-font og Font Awesome-ikoner
- VDX-branding med baggrundsbillede og grøn "VDX Video"-header
- **Miljøafhængigt password reset-link:** JavaScript vælger automatisk den korrekte URL baseret på login-hostname (`login.vconf-stage.dk` → `https://vconf-stage.dk/passwordreset`, ellers prod `https://vconf.dk/passwordreset`)
- TOTP-login (`login-totp.ftl`) og TOTP-opsætning med QR-kode (`login-config-totp.ftl`)
- IdP `displayName` med `:` til visning af organisationsnavne
- Danske oversættelser

## Mappestruktur

```
keycloaktheme/
├── Dockerfile
├── pom.xml
└── src/main/resources/theme/
    ├── medcom-vdx-broker/
    │   ├── login/
    │   │   ├── theme.properties          # Parent: base, import: common/keycloak
    │   │   ├── template.ftl              # Eget HTML-layout med Bootstrap
    │   │   ├── login.ftl                 # IdP-kort (social providers)
    │   │   ├── attribute.ftl             # Dropdown til organisationsvalg
    │   │   ├── error.ftl                 # Fejlside med auto-redirect
    │   │   ├── info.ftl
    │   │   ├── saml-post-form.ftl
    │   │   ├── messages/
    │   │   │   └── messages_da.properties
    │   │   └── resources/
    │   │       ├── css/
    │   │       │   ├── styles.css        # Baggrundsbillede-styling
    │   │       │   └── sb-admin-2.css    # SB Admin 2 layout
    │   │       ├── bootstrap/            # Bootstrap 4.3.1 (CSS + JS)
    │   │       └── jquery/               # jQuery 3.4.1
    │   ├── account/
    │   │   ├── theme.properties
    │   │   └── messages/messages_da.properties
    │   └── email/
    │       ├── theme.properties
    │       └── messages/messages_da.properties
    │
    └── medcom-vdx-booking/
        ├── login/
        │   ├── theme.properties          # Parent: base
        │   ├── template.ftl              # Eget HTML-layout med W3.CSS
        │   ├── login.ftl                 # Brugernavn/adgangskode + IdP
        │   ├── login-totp.ftl            # TOTP engangskode-login
        │   ├── login-config-totp.ftl     # TOTP opsætning med QR-kode
        │   ├── info.ftl
        │   ├── error.ftl
        │   ├── saml-post-form.ftl
        │   ├── messages/
        │   │   └── messages_da.properties
        │   └── resources/
        │       ├── css/
        │       │   ├── styles.css        # Custom styling, Raleway, Font Awesome
        │       │   └── w3.css            # W3.CSS framework
        │       └── js/
        │           └── environment-helpers.js    # Miljøafhængig password reset-link
        ├── account/
        │   ├── theme.properties
        │   └── messages/messages_da.properties
        └── email/
            ├── theme.properties
            └── messages/messages_da.properties
```

## Build og deployment

### Forudsætninger

- Java (JDK)
- Maven
- Docker

### Build

Projektet bygges med Maven og pakkes som en JAR-fil:

```bash
mvn clean install
```

Dette:
1. Kompilerer tema-ressourcerne til `medcom-vdx-keycloak-theme-1.0.0.jar`
2. Genererer `git.properties` med commit-info (via `git-commit-id-plugin` 4.0.0)
3. Bygger et Docker-image via Fabric8 `docker-maven-plugin`

### Docker-image

Docker-imaget er baseret på `busybox` og kopierer JAR-filen til `/module/`. Imaget tagges som:
- `kvalitetsit/medcom-vdx-keycloak-theme:latest`
- `kvalitetsit/medcom-vdx-keycloak-theme:dev`
- `kvalitetsit/medcom-vdx-keycloak-theme:<git-commit-id>`

JAR-filen deployes til Keycloak som tema-provider (typisk monteret i Keycloaks `providers/`-mappe).

## Afhængigheder (inkluderet i resources)

| Bibliotek    | Version | Bruges i        |
|-------------|---------|-----------------|
| Bootstrap   | 4.3.1   | Broker (login)  |
| jQuery      | 3.4.1   | Broker (login)  |
| SB Admin 2  | 4.0.3   | Broker (login)  |
| W3.CSS      | —       | Booking (login) |

Booking-temaet henter desuden eksterne ressourcer:
- Google Fonts: Raleway
- Font Awesome 4.7.0 (via cdnjs)

## Konfiguration i Keycloak

Temaerne vælges i Keycloak Admin Console under den relevante realm:

1. **Realm Settings** → **Themes** → **Login Theme**
2. Vælg `medcom-vdx-broker` eller `medcom-vdx-booking`

### Konventioner for IdP/klient-navngivning

Begge temaer forventer en specifik navngivningskonvention med `:` som separator:

- **IdP displayName:** `Organisationstype: Organisationsnavn` (fx `Region: Region Hovedstaden`)  
  Broker-temaet viser dette som titel og undertekst på IdP-kort. Booking-temaet viser kun delen før `:`.
- **Client ID (broker):** `Prefix: Klientnavn` — vises som overskrift på broker-login-siden.

## Kendte begrænsninger

- **Manglende billeder:** Temaerne refererer til `img/bkgrnd.jpg`, `img/vdx_logo_wh.png` og `img/favicon.ico`, men disse filer er ikke inkluderet i repositoriet. De skal tilføjes manuelt til `resources/img/` i hvert tema eller deployes separat.
- **Password reset-URL:** Booking-temaet bruger miljøafhængig JavaScript til at pege på den korrekte VDXPasswordResetWeb-URL (stage vs. prod). Standard Keycloak reset-flow bruges ikke.
- **Keycloak-kompatibilitet:** Temaerne er bygget til Keycloak 15–17 (FreeMarker-baserede temaer). Nyere Keycloak-versioner kan kræve tilpasning.
