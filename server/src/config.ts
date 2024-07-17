import axios from "axios"
import { ToDoListService } from "./services/to-do-list.service"
import { appEnv } from './env'
import { KeycloakService } from "./services/keycloak.service"
import { init } from "@sentry/node"
import { nodeProfilingIntegration } from "@sentry/profiling-node"
import { AzureStorageService } from "./services/azure-storage.service"
import { UserService } from "./services/user.service"

axios.defaults.timeout = 10000

export const ToDoList = new ToDoListService(appEnv.MONGODB)
export const User = new UserService(appEnv.MONGODB)
export const AzureStorage = new AzureStorageService(appEnv.AZURE_STORAGE)
export const Keycloak = new KeycloakService(
  appEnv.KEYCLOAK_URL,
  appEnv.KEYCLOAK_REALM,
  appEnv.KEYCLOAK_CLIENT_ID,
  appEnv.KEYCLOAK_CLIENT_SECRET
)

if (appEnv.SENTRY_API_DSN && appEnv.SENTRY_ENVIRONMENT) {
  init({
    environment: appEnv.SENTRY_ENVIRONMENT,
    dsn: appEnv.SENTRY_API_DSN,
    integrations: [nodeProfilingIntegration()],
    tracesSampleRate: 1.0,
    profilesSampleRate: 1.0
  })
}