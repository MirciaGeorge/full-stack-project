import { ApiServiceClient } from "../../server/api-service-client"
import { TranslationKey } from "../../../i18n/i18next"
import { useNotifications } from "../notifications-context"
import { useTranslation } from "react-i18next"
import { useState } from "react"

export interface Options<T, N> {
    apiServiceClient: ApiServiceClient<T, N>
    notifications?: {
        save?: TranslationKey
        delete?: TranslationKey
    }
}

export function useBaseContext<T extends { id: string; name?: string }, N = any>({
    apiServiceClient,
    notifications = {},
}: Options<T, N>) {
    const { t } = useTranslation()
    const { notify, notifyError } = useNotifications()

    const [data, setData] = useState<T[]>([])

    const addRecord = async (payload: N) => {
        try {
            const added = await apiServiceClient.add(payload)
            setData(prev => [added, ...prev])
            notify({ title: t((notifications.save as any), { name: added.name }), variant: 'success' })
            return added
        } catch (error) {
            notifyError()
        }
    }

    async function getRecords() {
        try {
            setData(await apiServiceClient.get())
        } catch (error) {
            notifyError()
        }
    }

    async function patchRecord(id: string, payload: Partial<T>) {
        try {
            const patched = await apiServiceClient.patch(id, payload)
            setData(prev => prev.map(item => item.id === id ? patched : item))
            notify({ title: t((notifications.save as any), { name: patched.name }), variant: 'success' })
            return patched
        } catch (error) {
            notifyError()
        }
    }

    async function deleteRecord(id: string) {
        try {
            const item = data.find(i => i.id === id)
            await apiServiceClient.delete(id)
            setData(prev => prev.filter(item => item.id !== id))
            if (item) {
                notify({ title: t((notifications.delete as any), { name: item.name }), variant: 'success' })
            }
        } catch (error) {
            notifyError()
        }
    }

    return {
        data,
        setData,
        addRecord,
        getRecords,
        patchRecord,
        deleteRecord
    }
}