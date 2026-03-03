*** Settings ***
Documentation    Arquivo de contendo os passos que serão usados nos testes de login

Library          SeleniumLibrary

Resource         ../page_object/login.resource

*** Variables ***
${USER}                  standard_user
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

# --- E

E informo o usuário
    [Documentation]
    [Arguments]    ${USER}
    Input Text     ${INPUT_USER}    ${USER}

E informo a senha
    [Documentation]
    [Arguments]    ${PWD}
    Input Password    ${INPUT_PASSWORD}    ${PWD}

# --- STEPS

Acessar Página Sauce Demo
    [Documentation]    Passos para acessar a página login
    Open Browser    ${LOGIN_URL}    chrome
    Maximize Browser Window
    ${RECEIVED_TITLE}    Get Title
    Should Be Equal    ${RECEIVED_TITLE}    ${TITLE_LOGIN}
