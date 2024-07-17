import { createContext, useContext, useEffect, useState } from 'react'
import { Keycloak, keycloakInitOptions } from './keycloak'
import { Loader } from '../shared/loader'
import { setUser as setSentryUser } from '@sentry/browser'
import { useNotifications } from '../shared/notifications-context'

function refreshToken() {
    setInterval(() => {
        Keycloak.updateToken(100)
    }, 100000)
}

export interface User {
    sub: string
    name: string
    given_name: string
    family_name: string
    email: string
    preferred_username: string
}

const defaultUser: User = { sub: '', name: '', given_name: '', family_name: '', email: '', preferred_username: '' }

export const Context = createContext({} as any as ReturnType<typeof AuthProvider>['context'])

export function useAuth() {
    return useContext(Context)
}

export function AuthProvider({ children }: { children: React.ReactElement | React.ReactElement[] }) {
    const [authenticated, setAuthenticated] = useState(false)
    const [user, setUser] = useState(defaultUser)
    const {notifyError} = useNotifications()

    const login = async () => {
        try {
            const authenticated = await Keycloak.init(keycloakInitOptions)

            setAuthenticated(authenticated)
            refreshToken()
            await loadUser()
        } catch (error) {
            notifyError()
        }
    }

    const loadUser = async () => {
        await Keycloak.loadUserInfo()

        const userInfo = {
            ...defaultUser,
            ...(Keycloak.userInfo || {})
        }

        setUser(userInfo)
        setSentryUser({ id: userInfo.sub, email: userInfo.email })
    }

    const logout = async () => {
        setSentryUser(null)
        await Keycloak.logout()
    }

    useEffect(() => {
        login()
    }, [])

    const context = {
        user,
        loadUser,
        logout
    }

    return <Context.Provider value={context}>{authenticated ? children : <Loader />}</Context.Provider> as JSX.Element & { context: typeof context }
}