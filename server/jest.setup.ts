import { KeycloakTokenPayload } from '../common/build/auth/auth-types'
import { Keycloak } from './src/config'

const ignoredJestWarnings = [
  'Switching "@azure/functions" package to test mode',
  '"@azure/functions" package is in test mode'
]

const warn = console.warn.bind(console.warn)

global.console.warn = message => {
  if (!ignoredJestWarnings.some(s => message.includes(s))) {
    warn(message)
  }
}

Keycloak.introspect = async token => JSON.parse(decodeURIComponent(token)) as KeycloakTokenPayload
