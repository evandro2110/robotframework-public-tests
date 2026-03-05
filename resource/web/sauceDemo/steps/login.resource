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
    Validar itens da página após login

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
    ${OPTIONS}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys

    IF    "headless" in "${BROWSER}"
        Call Method    ${OPTIONS}    add_argument    --headless
        Call Method    ${OPTIONS}    add_argument    --no-sandbox
        Call Method    ${OPTIONS}    add_argument    --disable-dev-shm-usage
    END
    Call Method    ${OPTIONS}    add_argument    --disable-save-password-bubble
    Call Method    ${OPTIONS}    add_argument    --disable-infobars
    Call Method    ${OPTIONS}    add_argument    --disable-notifications
    Call Method    ${OPTIONS}    add_argument    --incognito

    ${PREFERENCIAS_CHROME}=    Create Dictionary
    ...    credentials_enable_service=${False}
    ...    password_manager_enabled=${False}
    ...    autofill.profile_enabled=${False}
    ...    autofill.address_enabled=${False}

    Call Method    ${OPTIONS}    add_experimental_option    prefs    ${PREFERENCIAS_CHROME}
    Call Method    ${OPTIONS}    add_experimental_option    excludeSwitches    ${{['enable-automation']}}

    Open Browser   ${LOGIN_URL}    ${BROWSER}    options=${OPTIONS}
    Maximize Browser Window
    ${RECEIVED_TITLE}=    Get Title
    Should Be Equal    ${RECEIVED_TITLE}    ${TITLE_LOGIN}

Validar itens da página após login
    [Documentation]    Valida os itens da página após login com sucesso
    Wait Until Element Is Visible    ${BTN_CART}
    Wait Until Element Is Visible    ${BTN_MENU}
    Wait Until Element Is Visible    ${TXT_FINAL_PAGE}
