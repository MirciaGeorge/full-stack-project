import keycloak, { KeycloakConfig, KeycloakInitOptions } from 'keycloak-js'
import { envVariables } from '../../env'

export const keycloakConfig: KeycloakConfig = {
    url: envVariables.KEYCLOAK_URL,
    realm: envVariables.KEYCLOAK_REALM,
    clientId: envVariables.KEYCLOAK_CLIENT_ID
}

export const keycloakInitOptions: KeycloakInitOptions = {
    onLoad: 'login-required',
    checkLoginIframe: false
}

export const Keycloak = new keycloak(keycloakConfig)
