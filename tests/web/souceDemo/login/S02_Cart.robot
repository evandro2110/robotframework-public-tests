*** Settings ***
Documentation    Arquivo que contém os testes da tela de Carrinho de compras Sauce Demo

# Bibliotecas
Library    SeleniumLibrary

Test Teardown    Close All Browsers

# Hooks e Keywords Globais
Resource    ../../../../resource/commons/web/commonsWeb.resource
Resource    ../../../../resource/web/sauceDemo/steps/cart.resource


*** Test Cases ***
CT01: Validando carrinho de compras sem itens
    [Documentation]    Validação do comportamento da página ao acessar o carrinho de compras sem itens
    Dado que estou na página Sauce Demo
    Quando clicar no botão    ${BTN_CART}
    Então a tela de carrinho de compras deverá ser apresentada sem itens
