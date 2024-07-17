import { Box, Button } from "@mui/material"
import { createSx } from "../../../types"
import { useUser } from "../user-context"
import { useTranslation } from "react-i18next"

const styles = createSx({
    root: {
        width: '100%',
        display: 'flex',
        alignItems: 'center',
        justifyContent: 'space-between'
    },
    image: {
        borderRadius: '10px',
        objectFit: 'cover',
        width: 144,
        height: 144
    }
})

export function UserProfileImage() {
    const { userData: { profileImageUrl }, deleteProfileImage } = useUser()
    const { t } = useTranslation()

    return (
        <Box sx={styles.root}>
            <img alt="Profile Image" src={profileImageUrl} style={styles.image} />

            <Button variant="contained" color="red" onClick={deleteProfileImage}>
                {t('delete')}
            </Button>
        </Box>
    )
}