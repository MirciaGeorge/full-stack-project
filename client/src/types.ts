import { Theme } from '@mui/material/styles'
import { SxProps, SystemStyleObject } from '@mui/system'

export type StylesRecord = Record<string, SystemStyleObject<Theme> | ((...args: any) => SxProps<Theme>)>

export const createSx = <T extends StylesRecord>(t: T) => t

export type DeepKey<T, K extends keyof T = keyof T> = K extends string | number
    ? T[K] extends infer R
    ? `${K}` | (R extends Record<string, unknown> ? `${K}.${DeepKey<R>}` : never)
    : never 
    : never 