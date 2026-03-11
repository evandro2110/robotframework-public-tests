*** Settings ***
Documentation    Arquivo de contendo os passos que serão usados nos testes da Home Page

Library          String
Library          Collections
Library          SeleniumLibrary

Resource         ../page_object/login.resource
Resource         ../page_object/home.resource
Resource         ../page_object/cart.resource
Resource         ../../../commons/web/commonsWeb.resource


*** Variables ***
${FILTRO}               ${EMPTY}
${FILTRO_A_Z}           az
${FILTRO_Z_A}           za
${FILTRO_PRECO_BAIXO}   lohi
${FILTRO_PRECO_ALTO}    hilo


*** Keywords ***
# --- DADO
# --- QUANDO
Quando selecionar o filtro
    [Documentation]    Seleciona o filtro de ordenação dos produtos, conforme o valor passado
    [Arguments]    ${FILTRO}
    Set Test Variable                 ${FILTRO}
    Wait Until Element Is Visible     ${LIST_FILTER}
    Select From List By Value         ${LIST_FILTER}    ${FILTRO}

# --- ENTAO

Então todos os produtos deverão ser ordenados conforme filtro
    [Documentation]    Chama a keyword que valida a ordenação alfabética, passando o filtro escolhido
    Validar ordenacao alfabética    ${FILTRO}

Então todos os produtos serão apresentados conforme filtro de preço
    [Documentation]    Chama a keyword que valida a ordenação por preço, passando o filtro escolhido
    Validar ordenação por preço    ${FILTRO}

# --- E
# --- STEPS

Validar ordenacao alfabética
    [Documentation]    Captura os nomes dos produtos, armazena em uma lista e compara com a lista ordenada
    [Arguments]    ${DIRECTION}
    ${ELEMENTS_NAME}      Get WebElements    ${INVENTORY_ITEM_NAME}
    ${LISTA_ATUAL}        Create List

    FOR    ${ELEMENT}    IN    @{ELEMENTS_NAME}
        ${NAME}    Get Text    ${ELEMENT}
        Append To List    ${LISTA_ATUAL}    ${NAME}
    END

    ${LISTA_ESPERADA}    Copy List    ${LISTA_ATUAL}
    Sort List    ${LISTA_ESPERADA}

    # Se a direção for DE Z para A, preciso inverter a lista
    IF    '${DIRECTION}' == '${FILTRO_Z_A}'    Reverse List    ${LISTA_ESPERADA}

    Lists Should Be Equal    ${LISTA_ATUAL}    ${LISTA_ESPERADA}

Validar ordenação por preço
    [Documentation]    Captura os preços, converte para número e valida a ordem escolhida
    [Arguments]    ${DIRECTION}

    ${ELEMENTS_PRICES}    Get WebElements    ${INVENTORY_ITEM_PRICE}
    ${LISTA_ATUAL}        Create List

    FOR    ${ELEMENT}    IN    @{ELEMENTS_PRICES}
        ${TEXTO}          Get Text    ${ELEMENT}
        # Remove o "$" e converte para número real
        ${NUMERO_LIMPO}   Remove String       ${TEXTO}    $
        ${VALOR_FLOAT}    Convert To Number   ${NUMERO_LIMPO}
        Append To List    ${LISTA_ATUAL}      ${VALOR_FLOAT}
    END

    # Prepara a lista esperada para comparação
    ${LISTA_ESPERADA}    Copy List    ${LISTA_ATUAL}
    Sort List            ${LISTA_ESPERADA}

    # Se o filtro for 'hilo', preciso inverter para o valor maior vir primeiro
    IF    '${DIRECTION}' == '${FILTRO_PRECO_ALTO}'    Reverse List    ${LISTA_ESPERADA}

    Lists Should Be Equal    ${LISTA_ATUAL}    ${LISTA_ESPERADA}
