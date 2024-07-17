import { ReactElement, ReactNode } from 'react'
import { ErrorPage } from './pages/error-page'
import { ErrorBoundary as SentryErrorBoundary } from '@sentry/react'
import { Outlet } from 'react-router-dom'

interface Props {
  fallback?: ReactElement
  children: ReactNode
}

export function ErrorBoundary({ children, fallback = <ErrorPage /> }: Props) {
  return (
    <SentryErrorBoundary fallback={fallback}>
      {children}
    </SentryErrorBoundary>
  )
}

export function ReactRouterErrorBoundary({ fallback = <ErrorPage /> }: Omit<Props, 'children'>) {
  return (
    <SentryErrorBoundary fallback={fallback}>
      <Outlet />
    </SentryErrorBoundary>
  )
}
