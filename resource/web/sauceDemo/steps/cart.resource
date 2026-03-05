*** Settings ***
Documentation    Arquivo de contendo os passos que serão usados do carrinho de compras Sauce Demo

Library          Collections
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

Então o produto deverá ser apresentado no carrinho de compras
    [Documentation]    Valida se o produto adicionado ao carrinho é o mesmo apresentado na página de carrinho de compras
    Wait Until Page Contains  ${PRODUCT_NAME_SORT}

# --- E

E adiciono um produto aleatório no carrinho de compras
    [Documentation]    Chama o step que adiciona um produto aleatório ao carrinho de compras
    Adicionar um produto aleatório ao carrinho

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

Adicionar um produto aleatório ao carrinho
    [Documentation]    Captura a lista de produtos e botões, sorteia um índice e clica no botão do produto sorteado
    # Capturo a lista de todos os elementos de nome e todos os botões
    ${LIST_NAMES_ITEM}=      Get WebElements    ${INVENTORY_ITEM_NAME}
    ${LIST_BUTTONS}=         Get WebElements    ${INVENTORY_BTN_NAME}

    # Vou pegar a quantidade total de elementos
    ${QTD}=       Get Element Count    ${INVENTORY_ITEM_NAME}
    # Sorteia um índice, como o índice inicia e 0, faço -1
    ${INDEX_SORT}=  Evaluate    random.randint(0, ${QTD}-1)    modules=random

    ${ELEMENT_NAME}=    Get From List    ${LIST_NAMES_ITEM}    ${INDEX_SORT}
    ${PRODUCT_NAME}=    Get Text         ${ELEMENT_NAME}

    Set Test Variable    ${PRODUCT_NAME_SORT}    ${PRODUCT_NAME}
    ${ELEMENT_BUTTON}=   Get From List    ${LIST_BUTTONS}   ${INDEX_SORT}
    Click Button         ${ELEMENT_BUTTON}
