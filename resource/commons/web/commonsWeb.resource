*** Settings ***
Documentation    Arquivo de contendo as variáveis comumente usadas nos testes web

Library    OperatingSystem
Library    SeleniumLibrary


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
