*** Settings ***
Documentation    Arquivo que contém os testes da API ServeRest do path Usuários

# Hooks e Keywords Globais
Resource    ../../../resource/api/serveRest/steps/usuarios.resource

Suite Setup    Criar dados para novo usuário


*** Test Cases ***
CT01: Tentar cadastrar usuário sem informar nome
    [Documentation]    Validação do comportamento da API sem informar campo obrigatório
    [Tags]    negative
    Dado que possuo uma sessão na API ServeRest
    Quando requisitar a API de cadastro de usuário sem informar o nome
    Então o status code será    400
    Então a API deve informar que o campo nome é obrigatório
