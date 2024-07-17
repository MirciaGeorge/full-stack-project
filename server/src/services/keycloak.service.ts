import { KeycloakTokenPayload } from "common"
import axios from "axios"

export class KeycloakService {
    private http = axios.create()
    private expiresAt = 0
    private KEYCLOAK_URL = ''
    private KEYCLOAK_REALM = ''
    private KEYCLOAK_CLIENT_ID = ''
    private KEYCLOAK_CLIENT_SECRET = ''

    constructor(
        KEYCLOAK_URL: string,
        KEYCLOAK_REALM: string,
        KEYCLOAK_CLIENT_ID: string,
        KEYCLOAK_CLIENT_SECRET: string
    ) {
        this.KEYCLOAK_URL = KEYCLOAK_URL
        this.KEYCLOAK_REALM = KEYCLOAK_REALM
        this.KEYCLOAK_CLIENT_ID = KEYCLOAK_CLIENT_ID
        this.KEYCLOAK_CLIENT_SECRET = KEYCLOAK_CLIENT_SECRET
    }

    async connect() {
        if (Date.now() < this.expiresAt) return

        const { data } = await axios.post<{ access_token: string, expires_in: number }>(
            `${this.KEYCLOAK_URL}/realms/${this.KEYCLOAK_REALM}/protocol/openid-connect/token`,
            {
                client_id: this.KEYCLOAK_CLIENT_ID,
                client_secret: this.KEYCLOAK_CLIENT_SECRET,
                grant_type: 'client_credentials'
            },
            { headers: { 'Content-Type': 'application/x-www-form-urlencoded' } }
        )

        this.http.defaults.headers.common['Authorization'] = `Bearer ${data.access_token}`
        this.expiresAt = Date.now() + data.expires_in * 1000 - 60000
    }

    async introspect(token: string): Promise<KeycloakTokenPayload> {
        await this.connect()

        const { data } = await axios.post(
            `${this.KEYCLOAK_URL}/realms/${this.KEYCLOAK_REALM}/protocol/openid-connect/token/introspect`,
            {
                token,
                client_id: this.KEYCLOAK_CLIENT_ID,
                client_secret: this.KEYCLOAK_CLIENT_SECRET
            },
            { headers: { 'Content-Type': 'application/x-www-form-urlencoded' } }
        )

        return data
    }
}