import ReactDOM from 'react-dom/client'
import { Suspense } from 'react'
import { Loader } from './core/shared/loader'
import { ErrorBoundary } from './core/shared/error-boundary'
import { ThemeProvider } from './core/shared/theme/theme-wrapper'
import { envVariables } from './env'
import { browserTracingIntegration, init, replayIntegration } from '@sentry/react'
import { App } from './app'

if (envVariables.SENTRY_DSN && envVariables.SENTRY_ENVIRONMENT) {
  init({
    environment: envVariables.SENTRY_ENVIRONMENT,
    dsn: envVariables.SENTRY_DSN,
    integrations: [browserTracingIntegration(), replayIntegration()],
    tracesSampleRate: 1.0,
    replaysSessionSampleRate: 0.1,
    replaysOnErrorSampleRate: 1.0
  })
}

ReactDOM.createRoot(document.getElementById('root')!).render(
  <Suspense fallback={<Loader />}>
    <ThemeProvider>
      <ErrorBoundary>
        <App />
      </ErrorBoundary>
    </ThemeProvider>
  </Suspense>
)
