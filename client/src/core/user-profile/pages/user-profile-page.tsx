import { useTranslation } from "react-i18next"
import { RouteObject } from "react-router-dom"
import { BasePage } from "../../shared/pages/base-page"
import { UserProfileBody } from "../components/user-profile-body"

export const USER_PROFILE_ROUTE = 'userprofile'

export const userProfileRoute: RouteObject = {
    path: USER_PROFILE_ROUTE,
    element: <Page />
}

function Page() {
    const { t } = useTranslation()

    return (
        <BasePage title={t('user-profile.title')}>
            <UserProfileBody />
        </BasePage>
    )
}