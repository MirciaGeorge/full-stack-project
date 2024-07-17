import './app.css'
import './i18n/i18n-config'
import { StrictMode } from 'react'
import { RouterProvider, createBrowserRouter } from 'react-router-dom'
import { NotificationsProvider } from './core/shared/notifications-context'
import { routes } from './core/shared/routes'
import { AuthProvider } from './core/auth/auth-context'
import { ToDoListProvider } from './core/to-do-list/to-do-list-context'
import { UserProvider } from './core/user-profile/user-context'

const router = createBrowserRouter(routes)

export function App() {
  return (
    <NotificationsProvider>
      <AuthProvider>
        <StrictMode>
          <UserProvider>
            <ToDoListProvider>
              <RouterProvider router={router} />
            </ToDoListProvider>
          </UserProvider>
        </StrictMode>
      </AuthProvider>
    </NotificationsProvider>
  )
}