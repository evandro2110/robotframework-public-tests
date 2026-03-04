*** Settings ***
Documentation    Arquivo de contendo os passos que serão usados do carrinho de compras Sauce Demo

Library          SeleniumLibrary

Resource         ../page_object/login.resource
Resource         ../page_object/cart.resource
Resource         ../steps/login.resource


*** Keywords ***
# --- DADO
Dado que estou na página Sauce Demo
    [Documentation]    Chama os steps que acessam a página, faz o login e acessa página principal
    Acessar página sauce demo
    Informar dados de login e acessar

# --- QUANDO
# --- ENTAO

Então a tela de carrinho de compras deverá ser apresentada sem itens
    [Documentation]    Chama step que valida elementos da página carrinho de compras
    Validar carrinho de compras sem itens

# --- E
# --- STEPS

Informar dados de login e acessar
    [Documentation]    Passos para preencher os campos até a página principal
    Input Text        ${INPUT_USER}    ${VALID_USER}
    Input Password    ${INPUT_PASSWORD}    ${PASSWORD}
    Click Button      ${BTN_LOGIN}
    Validar itens da página após login

Validar carrinho de compras sem itens
    [Documentation]    Valida os elementos básicos do página de carrinho de compras
    Wait Until Element Is Visible    ${BTN_CHECKOUT}
    Wait Until Element Is Visible    ${BTN_CONTINUE_SHOPPING}
