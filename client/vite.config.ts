import { sentryVitePlugin } from '@sentry/vite-plugin'
import react from '@vitejs/plugin-react'
import { resolve } from 'path'
import { defineConfig, loadEnv } from 'vite'

export default defineConfig(({ mode }) => {
  const env = loadEnv(mode, process.cwd(), '')

  return {
    plugins: [
      react(),
      sentryVitePlugin({
        silent: !env.SENTRY_AUTH_TOKEN,
        org: env.SENTRY_ORG,
        project: env.SENTRY_PROJECT,
        authToken: env.SENTRY_AUTH_TOKEN,
      }),
    ],
    build: {
      outDir: 'build',
      sourcemap: true,
    },
    server: {
      port: 4000,
      host: true,
    },
    resolve: {
      alias: {
        'common': resolve(__dirname, '../common/src'),
      },
    },
    clearScreen: false,
  }
})
