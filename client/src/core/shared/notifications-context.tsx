import { faTimes } from '@fortawesome/free-solid-svg-icons'
import { Alert, AlertColor, IconButton, Typography } from '@mui/material'
import { SnackbarProvider, closeSnackbar, enqueueSnackbar, } from 'notistack'
import React, { ReactNode, createContext, forwardRef, useContext } from 'react'
import { useTranslation } from 'react-i18next'
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome'
import { colorPalette } from './theme/color-palette'
import { createSx } from '../../types'

const styles = createSx({
  closeButton: {
    position: 'absolute',
    top: '5px',
    right: '5px',
    boxShadow: 'none',
    background: 'none',
    '&:hover': {
      background: 'none'
    }
  },
  closeIcon: {
    cursor: 'pointer',
    color: colorPalette.grey2[400],
    '&:hover': {
      color: colorPalette.red[600]
    }
  }
})

export const Context = createContext({} as any as ReturnType<typeof NotificationsProvider>['context'])

export function useNotifications() {
  return useContext(Context)
}

export function NotificationsProvider({ children }: { children: React.ReactElement | React.ReactElement[] }) {
  const { t } = useTranslation()

  const notifyError = () => {
    notify({
      title: t('error-page.default-error.title'),
      message: (t('error-page.default-error.message')),
      variant: 'error'
    })
  }

  const notifyValidationError = () => {
    notify({
      title: t('notifications.validation.error.title'),
      message: t('notifications.validation.error.message'),
      variant: 'error'
    })
  }

  const notify = ({ title, message, variant = 'info' }: { title: string; message?: string | ReactNode; variant?: AlertColor }) => {
    const component =
      <>
        <Typography sx={{ mb: '4px' }} variant='subtitle2' fontWeight={600} color='inherit'>
          {title}
        </Typography>
        {message &&
          <Typography sx={{ mb: '4px' }} variant='subtitle2' fontWeight={400} color='inherit'>
            {message}
          </Typography>
        }
      </>

    enqueueSnackbar(component, { variant, autoHideDuration: 3000 }
    )
  }

  const context = {
    notify,
    notifyError,
    notifyValidationError
  }

  return (
    <Context.Provider value={context}>
      {children}
      <SnackbarProvider
        maxSnack={3}
        anchorOrigin={{
          vertical: 'top',
          horizontal: 'right'
        }}
        Components={{
          error: forwardRef(Notification),
          info: forwardRef(Notification),
          success: forwardRef(Notification),
          warning: forwardRef(Notification)
        }}
      />
    </Context.Provider>
  ) as JSX.Element & { context: typeof context }
}

function Notification(props: { message: ReactNode; variant: AlertColor; id: number }, ref?: any) {
  return (
    <Alert sx={{ maxWidth: '420px' }} ref={ref} severity={props.variant}>
      {props.message}
      <CloseNotificationButton id={props.id} />
    </Alert>
  )
}

function CloseNotificationButton({ id }: { id: number }) {
  return (
    <IconButton sx={styles.closeButton} onClick={() => { closeSnackbar(id) }}>
      <FontAwesomeIcon style={styles.closeIcon} icon={faTimes} />
    </IconButton>
  )
}
