*** Settings ***
Documentation    Arquivo de contendo as variáveis comumente usadas na tela de login

Library          SeleniumLibrary


*** Variables ***
# --- LINKS
${LOGIN_URL}          https://www.saucedemo.com/

# --- INPUTS
${INPUT_USER}         id:user-name
${INPUT_PASSWORD}     id:password

# --- BOTOES
${BTN_LOGIN}          id:login-button

# --- WARN/ERRORS
${ERROR_CONTAINER}    css:h3[data-test="error"]

# --- TITLES
${TITLE_LOGIN}        Swag Labs

# --- TEXT
${MSG_ERRO_LOGIN}     Epic sadface: Username and password do not match any user in this service
