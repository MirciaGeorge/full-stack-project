import { ThemeOptions } from '@mui/material'
import { palette } from './color-palette'
import * as AlertStyle from './components/alert-style'
import * as ButtonStyle from './components/button-style'
import * as InputStyle from './components/input-style'
import * as TooltipStyle from './components/tooltip-style'
import * as DialogStyle from './components/dialog-style'
import { typography } from './typography'

export const themeOptions = {
  spacing: 8,
  palette,
  typography,
  components: {
    ...AlertStyle,
    ...ButtonStyle,
    ...InputStyle,
    ...TooltipStyle,
    ...DialogStyle,
  },
} as ThemeOptions
