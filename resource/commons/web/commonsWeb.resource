*** Settings ***
Documentation    Arquivo de contendo as variáveis comumente usadas nos testes web

Library          SeleniumLibrary

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
    [Documentation]
    [Arguments]    ${ELEMENT}    ${MSG}
    Set Test Variable         ${MSG}
    Set Test Variable         ${ELEMENT}
    Element Text Should Be    ${ELEMENT}    ${MSG}
    

# --- E

# --- STEPS
