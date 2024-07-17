import { RouteObject } from "react-router-dom"
import { ReactRouterErrorBoundary } from "./error-boundary"
import { NotFoundPage } from "./pages/error-page"
import { Wrapper } from "./pages/wrapper"
import { toDoListRoute } from "../to-do-list/pages/to-do-list-page"
import { userProfileRoute } from "../user-profile/pages/user-profile-page"

export const routes: RouteObject[] = [
    {
        element: <ReactRouterErrorBoundary />,
        children: [
            {
                path: '/',
                element: <Wrapper />,
                children: [
                    toDoListRoute,
                    userProfileRoute
                ]
            },
            {
                path: '*',
                element: <NotFoundPage />
            }
        ]
    }
]
