*** Settings ***
Documentation    Arquivo que contém os testes da tela de Carrinho de compras Sauce Demo

# Bibliotecas
Library    SeleniumLibrary

# Hooks e Keywords Globais
Resource    ../../../../resource/commons/web/commonsWeb.resource
Resource    ../../../../resource/web/sauceDemo/steps/cart.resource

Test Teardown   Finalizar Teste


*** Test Cases ***
CT01: Validando carrinho de compras sem itens
    [Documentation]    Validação do comportamento da página ao acessar o carrinho de compras sem itens
    [Tags]    positive    trivial
    Dado que estou na página Sauce Demo
    Quando clicar no botão    ${BTN_CART}
    Então a tela de carrinho de compras deverá ser apresentada sem itens

CT02: Validando adição do produto aleatório ao carrinho de compras
    [Documentation]    Validação da página ao adicionar um produto aleatório no carrinho
    [Tags]    critical
    [Teardown]    Retornar aplicação ao estado original
    Dado que estou na página Sauce Demo
    E adiciono um produto aleatório no carrinho de compras
    Quando clicar no botão    ${BTN_CART}
    Então o produto deverá ser apresentado no carrinho de compras

CT03: Retornando para a página de produtos sem finalizar a compra
    [Documentation]    Retornar a página de produtos após visualizar produtos no carrinho
    [Tags]    positive
    [Teardown]    Retornar aplicação ao estado original
    Dado que estou na página Sauce Demo
    E possuo ao menos um produto no carrinho de compras
    Quando clicar no botão    ${BTN_CONTINUE_SHOPPING}
    Então a página principal deverá ser apresentada
    E a quantidade de itens no carrinho continuará ser apresentada

CT04: Tentar finalizar compra sem preencher os campos obrigatórios
    [Documentation]    Validar campos obrigatórios antes de finalizar a compra
    [Tags]    negative
    [Teardown]    Retornar aplicação ao estado original
    Dado que estou na página Sauce Demo
    E possuo ao menos um produto no carrinho de compras
    Quando clicar no botão    ${BTN_CHECKOUT}
    E clicar no botão         ${BTN_CONTINUE}
    Então todos os campos da tela apresentarão crítica

CT05: Tentar finalizar compra preenchendo apenas o First Name
    [Documentation]    Validar campos obrigatórios antes de finalizar a compra
    [Tags]    negative
    [Setup]    Gerar First Name, Last Name e Zip Code
    [Teardown]    Retornar aplicação ao estado original
    Dado que estou na página Sauce Demo
    E tenho produto na tela na tela de checkout
    Quando preencher o campo    ${INPUT_FIRST_NAME}    ${FAKE_FIRST_NAME}
    E clicar no botão         ${BTN_CONTINUE}
    Então os campos Last Name e Zip Code apresentarão crítica

CT06: Tentar finalizar sem preencher o Zip Code
    [Documentation]    Validar campos obrigatórios antes de finalizar a compra
    [Tags]    critical
    [Setup]    Gerar First Name, Last Name e Zip Code
    [Teardown]    Retornar aplicação ao estado original
    Dado que estou na página Sauce Demo
    E tenho produto na tela na tela de checkout
    Quando preencher o campo    ${INPUT_FIRST_NAME}    ${FAKE_FIRST_NAME}
    E preencher o campo    ${INPUT_LAST_NAME}    ${FAKE_LAST_NAME}
    E clicar no botão      ${BTN_CONTINUE}
    Então o campo Zip Code apresentará crítica

CT07: Validar tela antes da finalização de compra
    [Documentation]    Validar tela de finalização de compra
    [Tags]    critical
    [Setup]    Gerar First Name, Last Name e Zip Code
    [Teardown]    Retornar aplicação ao estado original
    Dado que estou na página Sauce Demo
    E tenho produto na tela na tela de checkout
    Quando preencher os campos obrigatórios do checkout
    E clicar no botão    ${BTN_CONTINUE}
    Então deverá ser apresentada na tela os itens antes da finalização da compra

CT08: Finalizando compra - Sucesso
    [Documentation]    Validar finalização da compra
    [Tags]    critical    positive
    [Setup]    Gerar First Name, Last Name e Zip Code
    [Teardown]    Run Keyword If Test Failed    Retornar aplicação ao estado original
    Dado que estou na página Sauce Demo
    E tenho produto na tela na tela de checkout
    Quando preencher os campos obrigatórios do checkout
    E clicar no botão    ${BTN_CONTINUE}
    Então deverá ser apresentada na tela os itens antes da finalização da compra
    E ao clicar em finalizar o pedido será concluído

CT09: Removendo o produto do carrinho de compras
    [Documentation]    A partir da tela de carrinho de compras, remover o produto
    [Tags]    critical
    Dado que estou na página Sauce Demo
    E possuo ao menos um produto no carrinho de compras
    E o botão de remoção do produto está visível
    Quando clicar no botão    ${BTN_REMOVE}${ID_BTN_FORMATED}
    Então a tela de carrinho de compras deverá ser apresentada sem itens
