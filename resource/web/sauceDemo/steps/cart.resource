*** Settings ***
Documentation    Arquivo de contendo os passos que serão usados do carrinho de compras Sauce Demo

Library          Collections
Library          SeleniumLibrary
Library          FakerLibrary

Resource         ../page_object/login.resource
Resource         ../page_object/cart.resource
Resource         ../steps/login.resource


*** Variables ***
@{CAMPOS_CHECKOUT}    first-name    last-name    postal-code
${FAKE_FIRST_NAME}    ${EMPTY}
${FAKE_LAST_NAME}     ${EMPTY}
${FAKE_ZIP_CODE}      ${EMPTY}


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

Então todos os campos da tela apresentarão crítica
    [Documentation]    Valida se os campos obrigatórios apresentam crítica de preenchimento
    Validar todos os icones de erro
    Validar crítica de checkout    ${ERROR_CONTAINER}   ${TXT_FIST_NAME_REQUIRED}

Então os campos Last Name e Zip Code apresentarão crítica
    [Documentation]    Valida a crítica apresentada para os campos Last Name e Zip Code
    Validar crítica de checkout    ${ERROR_CONTAINER}   ${TXT_LAST_NAME_REQUIRED}

# --- E

E adiciono um produto aleatório no carrinho de compras
    [Documentation]    Chama o step que adiciona um produto aleatório ao carrinho de compras
    Adicionar um produto aleatório ao carrinho

E possuo ao menos um produto no carrinho de compras
    [Documentation]    Valida se já existe um produto no carrinho
    Adicionar um produto aleatório ao carrinho
    Click Element             ${BTN_CART}
    Wait Until Page Contains  ${PRODUCT_NAME_SORT}

E a quantidade de itens no carrinho continuará ser apresentada
    [Documentation]    Valida se a quantidade de itens no carrinho continua sendo apresentada
    Wait Until Element Is Visible    ${BTN_CART_BADGE}
    ${QTD_PRODUCTS}=    Get Text        ${BTN_CART_BADGE}
    Should Not Be Empty    ${QTD_PRODUCTS}
    Capture Page Screenshot

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

Validar crítica de checkout
    [Documentation]    Valida a mensagem de crítica apresentada na tela de checkout
    [Arguments]    ${ELEMENT}    ${MSG}
    Set Test Variable        ${ELEMENT}
    Set Test Variable        ${MSG}
    Element Text Should Be   ${ELEMENT}    ${MSG}

Validar todos os icones de erro
    [Documentation]    Percorre a lista de campos e valida o ícone de erro em cada um
    FOR    ${CAMPO_ID}    IN    @{CAMPOS_CHECKOUT}
        Element Should Be Visible    css:input#${CAMPO_ID} + svg.error_icon
    END
