import { useTranslation } from "react-i18next"
import { BasePage } from "../../shared/pages/base-page"
import { RouteObject } from "react-router-dom"
import { useEffect, useState } from "react"
import { Button } from "@mui/material"
import { faPlus } from "@fortawesome/free-solid-svg-icons"
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome"
import { AddToDoListItemDialog } from "../components/add-to-do-list-item-dialog"
import { ToDoListBody } from "../components/to-do-list-body"
import { useToDoList } from "../to-do-list-context"

export const TO_DO_LIST_ROUTE = 'todolist'

export const toDoListRoute: RouteObject = {
    path: TO_DO_LIST_ROUTE,
    element: <Page />
}

function Page() {
    const { t } = useTranslation()
    const [addDialogOpen, setAddDialogOpen] = useState(false)
    const { getToDoListItems } = useToDoList()

    useEffect(() => {
        getToDoListItems()
    }, [])

    return (
        <BasePage
            title={t('to-do-list.title')}
            actions={
                <Button
                    onClick={() => setAddDialogOpen(true)}
                    startIcon={<FontAwesomeIcon icon={faPlus} />}
                >
                    {t('to-do-list.add-action')}
                </Button>
            }
        >
            <ToDoListBody />
            {addDialogOpen && <AddToDoListItemDialog open={addDialogOpen} setOpen={setAddDialogOpen} />}
        </BasePage>
    )
}