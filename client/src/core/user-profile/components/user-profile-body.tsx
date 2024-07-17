import { Box } from "@mui/material"
import { useTranslation } from "react-i18next"
import { useAuth } from "../../../core/auth/auth-context"
import { CustomField } from "../../../core/shared/components/inputs/custom-field"
import { createSx } from "../../../types"
import { useUser } from "../user-context"
import { ProfileImageDropzone } from "./profile-image-dropzone"
import { UserProfileImage } from "./user-profile-image"

const styles = createSx({
    root: {
        overflow: 'auto',
        display: 'flex',
        flexDirection: 'column',
        height: '100%',
        width: '100%',
        padding: '0px 28px'
    }
})

export function UserProfileBody() {
    const { t } = useTranslation()
    const { user } = useAuth()
    const { userData: { profileImageUrl } } = useUser()

    return (
        <Box sx={styles.root}>
            <CustomField text={t('user-profile.firstName')} input={user.given_name} />
            <CustomField text={t('user-profile.lastName')} input={user.family_name} />
            <CustomField text={t('user-profile.username')} input={user.preferred_username} />
            <CustomField text={t('user-profile.email')} input={user.email} />
            <CustomField text={t('user-profile.profile-image')} input={
                profileImageUrl ? <UserProfileImage /> : <ProfileImageDropzone />
            } />
        </Box>
    )
}
