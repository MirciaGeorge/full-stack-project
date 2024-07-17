import Joi, { SchemaLike } from 'joi'
import { defaultJoiOptions } from './utils'

export type EnvSpec<T = unknown> = {
  [key in keyof T]: SchemaLike | SchemaLike[]
}

function parseEnv<T>(processEnv: NodeJS.ProcessEnv, spec: EnvSpec<T>): T {
  if (process.env.NODE_ENV === 'test') {
    return process.env as T
  }

  const schema = Joi.object(spec).required()

  const { error, value } = schema.validate(processEnv, defaultJoiOptions)

  if (error) {
    const details = error.details.map(({ message }) => `- ${message}`).join('\n')
    throw new Error(`Invalid environment configuration:\n${details}`)
  }

  return value
}

export interface AppEnv {
  MONGODB: string

  KEYCLOAK_URL: string
  KEYCLOAK_REALM: string
  KEYCLOAK_CLIENT_ID: string
  KEYCLOAK_CLIENT_SECRET: string

  SENTRY_ENVIRONMENT: string
  SENTRY_API_DSN: string

  AZURE_STORAGE: string
}

export const appEnv = parseEnv<AppEnv>(process.env, {
  MONGODB: Joi.string().required(),

  KEYCLOAK_URL: Joi.string().required(),
  KEYCLOAK_REALM: Joi.string().required(),
  KEYCLOAK_CLIENT_ID: Joi.string().required(),
  KEYCLOAK_CLIENT_SECRET: Joi.string().required(),

  SENTRY_ENVIRONMENT: Joi.string().optional(),
  SENTRY_API_DSN: Joi.string().optional(),

  AZURE_STORAGE: Joi.string().required()
})
