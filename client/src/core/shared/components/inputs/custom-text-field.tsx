import { TextField, TextFieldProps } from "@mui/material"
import { colorPalette } from "../../theme/color-palette"
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome'
import { faSync } from "@fortawesome/free-solid-svg-icons"

export type CustomTextFieldProps = TextFieldProps & {
  loading?: boolean
}

export function CustomTextField({ loading, sx, value, ...props }: CustomTextFieldProps) {
  const inputProps = props.InputProps || {}

  return (
    <TextField
      fullWidth
      {...props}
      inputProps={{
        maxLength: 15
      }}
      value={value !== undefined && value !== null ? value : ''}
      sx={
        props.error
          ? {
            fieldset: {
              borderColor: `${colorPalette.red[400]} !important`,
            },
            '&:hover': {
              fieldset: {
                borderColor: `${colorPalette.red[500]} !important`,
              },
            },
            ...sx,
          }
          : sx
      }
      InputProps={{ ...inputProps, endAdornment: loading ? <FontAwesomeIcon icon={faSync} color={colorPalette.grey2[400]}/> : inputProps.endAdornment }}
    />
  )
}