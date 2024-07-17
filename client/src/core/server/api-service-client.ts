import axios, { AxiosInstance, AxiosRequestConfig } from 'axios'

export interface ApiServiceClientOptions {
  http?: () => AxiosInstance
}

export abstract class ApiServiceClient<T = any, N = T> {
  protected http: AxiosInstance
  route?: string

  protected constructor(basePath: string, options: ApiServiceClientOptions = {}, route?: string) {
    this.http = options.http ? options.http() : axios.create()
    this.http.defaults.baseURL = basePath
    this.route = route
  }

  async add(payload: N, config?: AxiosRequestConfig<N>): Promise<T> {
    const response = await this.http.post(`${this.route}`, payload, config)
    return response.data
  }

  async getById(id: string, config?: AxiosRequestConfig<T>): Promise<T> {
    const response = await this.http.get(`${this.route}/${id}`, config)
    return response.data
  }

  async get(config?: AxiosRequestConfig<T>): Promise<T[]> {
    const response = await this.http.get(`${this.route}`, config)
    return response.data
  }

  async patch(id: string, payload: Partial<T>, config?: AxiosRequestConfig<T>): Promise<T> {
    const response = await this.http.patch(`${this.route}/${id}`, payload, config)
    return response.data
  }

  async delete(id: string, config?: AxiosRequestConfig<T>) {
    await this.http.delete(`${this.route}/${id}`, config)
  }
}