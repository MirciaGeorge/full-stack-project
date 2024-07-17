import { createContext, useContext } from "react"
import { useBaseContext } from "../shared/hooks/use-base-context"
import { ToDoListItem } from "common"
import { toDoListApiService } from "../../config"

export const Context = createContext({} as any as ReturnType<typeof ToDoListProvider>['context'])

export function useToDoList() {
    return useContext(Context)
}

interface Props {
    children: React.ReactElement | React.ReactElement[]
}

export function ToDoListProvider({ children }: Props) {
    const baseContext = useBaseContext<ToDoListItem>({
        apiServiceClient: toDoListApiService,
        notifications: {
            save: 'notifications.save-item',
            delete: 'notifications.delete-item'
        }
    })

    const context = {
        toDoListItems: baseContext.data,
        addToDoListItem: baseContext.addRecord,
        getToDoListItems: baseContext.getRecords,
        patchToDoListItem: baseContext.patchRecord,
        deleteToDoListItem: baseContext.deleteRecord
    }

    return <Context.Provider value={context}>{children}</Context.Provider> as JSX.Element & { context: typeof context }
}