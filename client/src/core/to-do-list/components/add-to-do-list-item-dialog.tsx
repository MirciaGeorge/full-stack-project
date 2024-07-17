import { ToDoListItem, ToDoListItemStatus, toDoListItemSchema, uuid } from "common"
import { useToDoList } from "../to-do-list-context"
import { Controller, FormProvider, useForm } from "react-hook-form"
import { joiResolver } from '@hookform/resolvers/joi'
import { get } from 'lodash'
import { useNotifications } from "../../../core/shared/notifications-context"
import { Button, Dialog, DialogActions, DialogContent, DialogTitle, FormGroup, FormLabel } from "@mui/material"
import { useTranslation } from "react-i18next"
import { CustomTextField } from "../../../core/shared/components/inputs/custom-text-field"
import { useState } from "react"
import LoadingButton from "@mui/lab/LoadingButton"

interface Props {
    open: boolean,
    setOpen: (open: boolean) => void
}

export function AddToDoListItemDialog({ open, setOpen }: Props) {
    const { addToDoListItem } = useToDoList()
    const { notifyValidationError } = useNotifications()
    const { t } = useTranslation()
    const [loading, setLoading] = useState(false)

    async function handleAdd(payload: ToDoListItem) {
        setLoading(true)

        await addToDoListItem(payload)
        handleClose()

        setLoading(false)
    }

    const form = useForm<ToDoListItem>({
        mode: 'onSubmit',
        reValidateMode: 'onChange',
        resolver: joiResolver(toDoListItemSchema, {
            presence: 'required',
            allowUnknown: true,
            abortEarly: false,
            convert: true
        }),
        shouldUnregister: false,
        defaultValues: { id: uuid(), name: '', status: ToDoListItemStatus.UNFINISHED }
    })

    const {
        handleSubmit,
        control,
        reset,
        formState: { errors, isDirty }
    } = form

    function hasErrors(fieldName: string) {
        return Boolean(get(errors, fieldName))
    }

    function handleClose() {
        setOpen(false)
        reset()
    }

    return (
        <FormProvider {...form}>
            <form>
                <Dialog open={open} onClose={handleClose}>
                    <DialogTitle>{t('add-to-do-list-item-dialog.title')}</DialogTitle>
                    <DialogContent sx={{ minWidth: '525px' }}>
                        <Controller
                            control={control}
                            name='name'
                            render={({ field: { ref, ...field } }) => (
                                <FormGroup>
                                    <FormLabel>{t('add-to-do-list-item-dialog.fields.name')}</FormLabel>
                                    <CustomTextField {...field} error={hasErrors(field.name)} />
                                </FormGroup>
                            )}
                        />
                    </DialogContent>
                    <DialogActions>
                        <Button onClick={handleClose}>{t('close')}</Button>
                        <LoadingButton loading={loading} disabled={!isDirty} onClick={handleSubmit(handleAdd, notifyValidationError)}>{t('save')}</LoadingButton>
                    </DialogActions>
                </Dialog>
            </form>
        </FormProvider>
    )
}