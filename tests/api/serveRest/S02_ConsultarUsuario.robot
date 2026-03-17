*** Settings ***
Documentation    Arquivo que contém os testes da API ServeRest - Get /usuarios

# Hooks e Keywords Globais
Resource    ../../../resource/api/serveRest/steps/consultarUsuario.resource

Test Teardown    Delete All Sessions


*** Test Cases ***
CT01: Listar todos os usuários cadastrados
    [Documentation]    Validação do comportamento ao requisitar API sem informar filtros
    [Tags]    positive
    Dado que possuo uma sessão na API ServeRest
    Quando requisitar a API de consulta de usuários
    Então o status code será    200
    E todos os usuários deverão ser retornados
