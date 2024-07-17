require('esbuild').build({
  entryPoints: ['src/functions/**/*.route.ts'],
  outdir: 'build/functions',
  bundle: true,
  minify: true,
  sourcemap: true,
  treeShaking: true,
  platform: 'node',
  external: [
    '@azure/functions',
    '@azure/storage-blob',
    '@sentry/integrations',
    '@sentry/node',
    '@sentry/profiling-node',
    'axios',
    'joi',
    'lodash',
    'mongoose'
  ]
})