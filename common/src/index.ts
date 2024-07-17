import { v4 } from 'uuid'

export * from './to-do-list/to-do-list-types'
export * from './auth/auth-types'
export * from './to-do-list/to-do-list-schemas'
export * from './user/user-types'

export function uuid() {
  return v4()
}