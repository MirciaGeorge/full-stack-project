# Full Stack Project

This project is a to do list application, and the main idea was to build a solid architecture

## Project structure

- `/server` is the folder that contains the backend code

- `/client` is the folder that contains the frontend code

- `/common` is the folder that contains the code shared between backend and frontend

- `/db` is the folder that contains scripts for initializind databases

- `docker` is the folder that contains files for docker compose

## Docker compose

This project uses `docker compose` to start all the services:

- `Client`: the frontend

- `Keycloak`: used for authentication

- `PostgreSQL`: the database used by Keycloak

- `Server`: the backend

- `MongoDB`: the database used by the server

- `Azurite`: used by the server for Azure Functions and Azure Storage

- `Nginx`: used as a reverse proxy

## Frontend - `/client`
The frontend is build with Vite React

The environment variables are in `.env` and are already set

## Backend - `/server`
The backend is build using Azure Functions and Azure Storage 

It uses Esbuild for the build process

The environment variables are in `local.settings.json` and are already set

## Common - `/common`
This is the code used by both the frontend and the backend and it is included in the bundled files for both

## Database - `/db`
The `db/scripts` folder contains a script for initializing the PostgreSQL database used by Keycloak

## Installation Guide

```shell
npm run init
npm run start
npm run restart-server 
```
`npm run restart-server` should be executed only the first time the project is initialized because Azurite has an unresolved issue that can be easily solved this way

## After Installation
You can access the application at http://localhost:3000 and log in using: 

- username: `username`

- password: `password`

## Testing
The tests are located in the `/server` folder and can be executed using the following command:
```shel
npm run test
```