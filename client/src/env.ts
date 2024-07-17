export interface envVariables {
  SERVER_ADDRESS: string
  APP_URL: string
  KEYCLOAK_URL: string
  KEYCLOAK_REALM: string
  KEYCLOAK_CLIENT_ID: string
  SENTRY_ENVIRONMENT?: string
  SENTRY_DSN?: string
  ENABLE_AXIOS_RETRY?: boolean
}

export const envVariables: envVariables = {
  SERVER_ADDRESS: import.meta.env.VITE_SERVER_ADDRESS,
  APP_URL: import.meta.env.VITE_APP_URL,
  KEYCLOAK_URL: import.meta.env.VITE_KEYCLOAK_URL,
  KEYCLOAK_REALM: import.meta.env.VITE_KEYCLOAK_REALM,
  KEYCLOAK_CLIENT_ID: import.meta.env.VITE_KEYCLOAK_CLIENT_ID,
  SENTRY_ENVIRONMENT: import.meta.env.VITE_SENTRY_ENVIRONMENT,
  SENTRY_DSN: import.meta.env.VITE_SENTRY_DSN,
  ENABLE_AXIOS_RETRY: import.meta.env.VITE_ENABLE_AXIOS_RETRY,
}
