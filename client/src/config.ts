import axios from "axios"
import axiosRetry from 'axios-retry'
import { envVariables } from "./env"
import { Keycloak } from './core/auth/keycloak'
import { MainApiServiceClient } from "./core/server/main-api-service-client"

export const Axios = axios.create()

Axios.interceptors.request.use(
    async config => {
        config.headers.authorization = `Bearer ${Keycloak.token}`
        return config
    },
    error => Promise.reject(error)
)

if (envVariables.ENABLE_AXIOS_RETRY) {
    axiosRetry(Axios, {
        retries: 10,
        retryDelay: () => 2500,
        retryCondition: error => error.code === 'ERR_NETWORK'
    })
}

const mainApiService = new MainApiServiceClient(envVariables.SERVER_ADDRESS, { http: () => Axios })

export const toDoListApiService = mainApiService.toDoList
export const userApiService = mainApiService.user
