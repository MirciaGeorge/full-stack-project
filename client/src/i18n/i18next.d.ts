import { DeepKey } from '../types'
import translation from './translation.json'

const resources = {
  translation
}

declare module 'i18next' {
  interface CustomTypeOptions {
    resources: typeof resources
  }
}

export type TranslationKey = DeepKey<typeof translation>
