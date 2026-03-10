*** Settings ***
Documentation    Arquivo de contendo os passos que serão usados do carrinho de compras Sauce Demo

Library          String
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

Quando preencher os campos obrigatórios do checkout
    [Documentation]    Preenche os campos obrigatórios do checkout com dados gerados aleatoriamente
    Preencher campo e valor    ${INPUT_FIRST_NAME}    ${FAKE_FIRST_NAME}
    Preencher campo e valor    ${INPUT_LAST_NAME}     ${FAKE_LAST_NAME}
    Preencher campo e valor    ${INPUT_POSTAL_CODE}   ${FAKE_ZIP_CODE}
    Page Should Contain        ${TXT_YOUR_INFORMATION}

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

Então o campo Zip Code apresentará crítica
    [Documentation]    Valida a crítica apresentada para o campo Zip Code
    Validar todos os icones de erro
    Validar crítica de checkout    ${ERROR_CONTAINER}    ${TXT_ZIP_CODE_REQUIRED}

Então deverá ser apresentada na tela os itens antes da finalização da compra
    [Documentation]    Chama o step que valida os elementos da tela de finalização de compra
    Validar elementos da tela de finalização de compra

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
    ${QTD_PRODUCTS}=    Get Text     ${BTN_CART_BADGE}
    Should Not Be Empty              ${QTD_PRODUCTS}
    Capture Page Screenshot

E tenho produto na tela na tela de checkout
    [Documentation]    Realiza o fluxo para ter um produto na tela de checkout
    Adicionar um produto aleatório ao carrinho
    Click Element             ${BTN_CART}
    Wait Until Page Contains  ${PRODUCT_NAME_SORT}
    Page Should Contain       ${TXT_YOUR_CART}
    Click Element             ${BTN_CHECKOUT}

E ao clicar em finalizar o pedido será concluído
    [Documentation]    Chama o passo para validação da finalização do pedido
    Validar finalização do pedido

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

Validar elementos da tela de finalização de compra
    [Documentation]    Valida os elementos apresentados na tela de finalização de compra
    Wait Until Element Is Visible    ${BTN_CANCEL}
    Wait Until Element Is Visible    ${BTN_FINISH}
    Wait Until Element Is Visible    ${TITLE_PAGE}
    Element Text Should Be           ${TITLE_PAGE}    ${TXT_OVERVIEW_CHECKOUT}
    Page Should Contain              ${TXT_PAYMENT_INFORMATION}
    Page Should Contain              ${TXT_PRICE_TOTAL}
    Page Should Contain              ${TXT_PRICE_TOTAL}
    Calcular preço final

Calcular preço final
    [Documentation]    Realiza o cálculo do preço final e compara com o valor total apresentado na página
    ${ITEM_TOTAL_STR}=    Get Text    ${SUBTOTAL}
    ${TAX_STR}=           Get Text    ${TAX}
    ${TOTAL_STR}=         Get Text    ${TOTAL}

    # Remove o $ do valor obtido para conseguir manipular somente números
    ${ITEM_TOTAL}=    Fetch From Right    ${ITEM_TOTAL_STR}   $
    ${TAX}=           Fetch From Right    ${TAX_STR}          $
    ${TOTAL_REAL}=    Fetch From Right    ${TOTAL_STR}        $

    # Somo os valores obtidos
    ${SOMA_CALCULADA}=    Evaluate    float(${ITEM_TOTAL}) + float(${TAX})

    # Converto para duas casas decimais
    ${SOMA_FORMATADA}=    Evaluate    "{:.2f}".format(${SOMA_CALCULADA})

    # Faço a comparação entre o cálculoe e o valor obtido da página
    Should Be Equal As Strings    ${SOMA_FORMATADA}    ${TOTAL_REAL}

Validar finalização do pedido
    [Documentation]    Passos para finalizar a compra e valida as informações apresentadas na tela de finalização
    Click Element                    ${BTN_FINISH}
    Wait Until Element Is Visible    ${TITLE_HEADER}
    Element Text Should Be           ${TITLE_HEADER}    ${TXT_TKS_ORDER}
    Element Should Be Visible        ${IMG_FINISH_SHOPPING}
    Wait Until Element Is Visible    ${BTN_BACK_TO_PRODUCTS}
    Element Should Contain           ${ELEMENT_TEXT}    ${TXT_FINISH_ORDER}
    Page Should Contain              ${TXT_CHECKOUT_COMPLETE}
    Close Browser
