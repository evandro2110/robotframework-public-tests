*** Settings ***
Documentation    Arquivo que contém os testes da tela de login Sauce Demo

# Bibliotecas
Library    Collections
Library    OperatingSystem
Library    SeleniumLibrary

Test Teardown    Close All Browsers

# Hooks e Keywords Globais
Resource    ../../../../resource/commons/web/commonsWeb.resource
Resource    ../../../../resource/web/sauceDemo/steps/login.resource


*** Test Cases ***
CT01: Login inválido
    [Documentation]    Validação do comportamento da página ao informar um usuário inexistente
    [Tags]    critical
    Dado que estou na página de login Sauce Demo
    E informo o usuário    ${INVALID_USER}
    E informo a senha      ${PASSWORD}
    Quando clicar no botão    ${BTN_LOGIN}
    Então deverá apresentar a mensagem de erro    ${ERROR_CONTAINER}    ${MSG_ERRO_LOGIN}

CT02: Login válido - Sucesso
    [Documentation]    Validação do comportamento da página ao informar usuário e senha corretos
    [Tags]    critical
    Dado que estou na página de login Sauce Demo
    E informo o usuário    ${VALID_USER}
    E informo a senha      ${PASSWORD}
    Quando clicar no botão    ${BTN_LOGIN}
    Entao a página principal deverá ser apresentada
