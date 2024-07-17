import { ThemeProvider as MuiThemeProvider, createTheme } from '@mui/material/styles'
import './font.css'
import { themeOptions } from './theme-options'


export interface ThemeProps {
  children: React.ReactNode
}

export function appTheme() {
  return createTheme(themeOptions)
}

export function ThemeProvider({ children }: ThemeProps) {
  const theme = appTheme()

  return (
    <MuiThemeProvider theme={theme}>
      {children}
    </MuiThemeProvider>
  )
}