*** Settings ***
Documentation    Arquivo que contém os testes da tela de Home Sauce Demo
Force Tags       positive

# Bibliotecas
Library          SeleniumLibrary

Test Teardown    Finalizar Teste

# Hooks e Keywords Globais
Resource    ../../../../resource/web/sauceDemo/steps/cart.resource
Resource    ../../../../resource/web/sauceDemo/steps/homePage.resource


*** Test Cases ***
CT01: Ordenação de produtos na Home Page A para Z
    [Documentation]    Validação do comportamento da página ordenar os produtos
    Dado que estou na página Sauce Demo
    Quando selecionar o filtro    ${FILTRO_A_Z}
    Então todos os produtos deverão ser ordenados conforme filtro

CT02: Ordenação de produtos na Home Page de Z para A
    [Documentation]    Validação do comportamento da página ordenar os produtos
    Dado que estou na página Sauce Demo
    Quando selecionar o filtro    ${FILTRO_Z_A}
    Então todos os produtos deverão ser ordenados conforme filtro

CT03: Ordenação de produtos na Home Page por preço menor para maior
    [Documentation]    Validação do comportamento da página ordenar os produtos
    Dado que estou na página Sauce Demo
    Quando selecionar o filtro    ${FILTRO_PRECO_BAIXO}
    Então todos os produtos serão apresentados conforme filtro de preço

CT04: Ordenação de produtos na Home Page por preço maior para menor
    [Documentation]    Validação do comportamento da página ordenar os produtos
    Dado que estou na página Sauce Demo
    Quando selecionar o filtro    ${FILTRO_PRECO_ALTO}
    Então todos os produtos serão apresentados conforme filtro de preço
