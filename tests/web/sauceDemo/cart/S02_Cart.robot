*** Settings ***
Documentation    Arquivo que contém os testes da tela de Carrinho de compras Sauce Demo

# Bibliotecas
Library    SeleniumLibrary

Test Teardown    Close Browser

# Hooks e Keywords Globais
Resource    ../../../../resource/commons/web/commonsWeb.resource
Resource    ../../../../resource/web/sauceDemo/steps/cart.resource


*** Test Cases ***
CT01: Validando carrinho de compras sem itens
    [Documentation]    Validação do comportamento da página ao acessar o carrinho de compras sem itens
    Dado que estou na página Sauce Demo
    Quando clicar no botão    ${BTN_CART}
    Então a tela de carrinho de compras deverá ser apresentada sem itens

CT02: Validando adição do produto aleatório ao carrinho de compras
    [Documentation]    Validação da página ao adicionar um produto aleatório no carrinho
    [Teardown]    Retornar aplicação ao estado original
    Dado que estou na página Sauce Demo
    E adiciono um produto aleatório no carrinho de compras
    Quando clicar no botão    ${BTN_CART}
    Então o produto deverá ser apresentado no carrinho de compras
