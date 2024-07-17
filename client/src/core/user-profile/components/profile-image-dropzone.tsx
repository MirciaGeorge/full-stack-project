import { Box, Typography } from "@mui/material";
import { createSx } from '../../../types'
import { colorPalette } from "../../shared/theme/color-palette";
import { useDropzone } from 'react-dropzone'
import { useTranslation } from "react-i18next";
import { useUser } from "../user-context";

const imageExtensions = ['.jpeg', '.jpg', '.png']

const styles = createSx({
    root: {
        height: '100px',
        padding: '16px',
        display: 'flex',
        alignItems: 'center',
        justifyContent: 'center',
        border: `2px dashed ${colorPalette.grey2[300]}`,
        width: '100%',
        textAlign: 'center',
        cursor: 'grab'
    }
})

export function ProfileImageDropzone() {
    const { uploadProfileImage } = useUser()
    const { t } = useTranslation()

    const { getRootProps, getInputProps } = useDropzone({
        onDrop: async (acceptedFiles: File[]) => {
            await uploadProfileImage(acceptedFiles[0])
        },
        accept: { 'image/*': imageExtensions }
    })

    return (
        <Box sx={styles.root} {...getRootProps()}>
            <input {...getInputProps()} />
            <Typography>{t('user-profile.upload-profile-image-message')}</Typography>
        </Box>
    )
}

