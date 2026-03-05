*** Settings ***
Documentation    Arquivo de contendo as variáveis comumente usadas nos testes web

Library    OperatingSystem
Library    SeleniumLibrary

Resource    ../../web/sauceDemo/page_object/home.resource


*** Variables ***
${BROWSER}      chrome


*** Keywords ***
# --- DADO

# --- QUANDO

Quando clicar no botão
    [Documentation]    Aqui pode posso usar o click element ou click button
    [Arguments]    ${BUTTON}
    Set Test Variable    ${BUTTON}
    Click Element        ${BUTTON}

# --- ENTAO

Então deverá apresentar a mensagem de erro
    [Documentation]    Valida a mensagem em comparação a variável recebida como argumento
    [Arguments]    ${ELEMENT}    ${MSG}
    Set Test Variable         ${MSG}
    Set Test Variable         ${ELEMENT}
    Element Text Should Be    ${ELEMENT}    ${MSG}

# --- E
# --- STEPS

Retornar aplicação ao estado original
    [Documentation]    Clica no menu e depois na opção de restaurar estado original da aplicação
    Wait Until Element Is Visible    ${BTN_MENU}
    Click Element                    ${BTN_MENU}
    Wait Until Element Is Visible    ${RESTORE_APP_STATE}
    Click Element                    ${RESTORE_APP_STATE}
    Capture Page Screenshot
    Close Browser

Finalizar Teste
    [Documentation]    Finaliza o teste, caso haja falha, captura a tela
    Run Keyword If Test Failed    Capture Page Screenshot    failure-${TEST_NAME}.png
    Close Browser
