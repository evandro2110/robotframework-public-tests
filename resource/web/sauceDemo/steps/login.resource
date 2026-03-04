*** Settings ***
Documentation    Arquivo de contendo os passos que serão usados nos testes de login

Library          SeleniumLibrary

Resource         ../page_object/login.resource
Resource         ../page_object/home.resource
Resource         ../../../commons/web/commonsWeb.resource


*** Variables ***
${VALID_USER}            standard_user
${PASSWORD}              secret_sauce
${INCORRECT_PASSWORD}    test
${INVALID_USER}          invalid


*** Keywords ***
# --- DADO
Dado que estou na página de login Sauce Demo
    [Documentation]    Chama kw de acesso à página
    Acessar página sauce demo

# --- QUANDO

# --- ENTAO

Entao a página principal deverá ser apresentada
    [Documentation]    Valida a apresentação da página após login com sucesso
    Wait Until Element Is Visible    ${BTN_CART}
    Wait Until Element Is Visible    ${BTN_MENU}
    Wait Until Element Is Visible    ${TXT_FINAL_PAGE}

# --- E

E informo o usuário
    [Documentation]    Insere o valor do argumento recebido e faz o input no campo de usuário
    [Arguments]    ${USER}
    Input Text     ${INPUT_USER}    ${USER}

E informo a senha
    [Documentation]    Insere o valor do argumento recebido e faz o input no campo de senha
    [Arguments]    ${PWD}
    Input Password    ${INPUT_PASSWORD}    ${PWD}

# --- STEPS

Acessar Página Sauce Demo
    [Documentation]    Passos para acessar a página login
    Open Browser    ${LOGIN_URL}    ${BROWSER}
    Maximize Browser Window
    ${RECEIVED_TITLE}    Get Title
    Should Be Equal    ${RECEIVED_TITLE}    ${TITLE_LOGIN}
