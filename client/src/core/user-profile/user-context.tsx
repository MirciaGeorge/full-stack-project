import { createContext, useContext, useEffect, useState } from "react"
import { userApiService } from "../../config"
import { useNotifications } from "../shared/notifications-context"
import { useAuth } from "../auth/auth-context"
import { UserData } from "common"

export const Context = createContext({} as any as ReturnType<typeof UserProvider>['context'])

export function useUser() {
    return useContext(Context)
}

interface Props {
    children: React.ReactElement | React.ReactElement[]
}

const defaultUserData: UserData = { id: '', profileImageUrl: '' }

export function UserProvider({ children }: Props) {
    const { user: { sub } } = useAuth()
    const [data, setData] = useState<UserData>(defaultUserData)
    const { notifyError } = useNotifications()

    async function uploadProfileImage(file: File) {
        try {
            const profileImageUrl = await userApiService.uploadProfileImage(file)
            setData(prev => ({ ...prev, profileImageUrl }))
        } catch (error) {
            notifyError()
        }
    }

    async function deleteProfileImage() {
        try {
            await userApiService.deleteProfileImage()
            setData(prev => ({ ...prev, profileImageUrl: '' }))
        } catch (error) {
            notifyError()
        }
    }

    async function getUserData(id: string) {
        try {
            const userData = await userApiService.getById(id)
            setData(userData)
        } catch (error) {
            notifyError()
        }
    }

    useEffect(() => {
        if (sub) {
            getUserData(sub)
        }
    }, [sub])

    const context = {
        userData: data,
        getUserData,
        uploadProfileImage,
        deleteProfileImage
    }

    return <Context.Provider value={context}>{children}</Context.Provider> as JSX.Element & { context: typeof context }
}