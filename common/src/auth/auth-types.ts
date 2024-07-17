export interface TokenPayload {
  sub: string
  name: string
  email: string
  username: string
  roles: RealmRole[]
}

export type KeycloakTokenPayload = Omit<TokenPayload, 'roles'> & { realm_access: { roles: RealmRole[] } }

export enum RealmRole {
  admin = 'admin',
  user = 'user',
}