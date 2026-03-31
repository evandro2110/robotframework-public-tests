*** Settings ***
Documentation    Arquivo que contém os testes da API ServeRest - Put /usuarios

# Hooks e Keywords Globais
Resource         ../../../resource/api/serveRest/steps/editarUsuario.resource
Resource         ../../../resource/api/serveRest/steps/consultarUsuario.resource

Test Setup       Criar massa de usuário para edição    true
Test Teardown    Delete All Sessions


*** Test Cases ***
CT01: Atualiza o nome de um usuário cadastrado
    [Documentation]    Validação do comportamento ao requisitar API de edição de usuário para atualizar o nome
    [Tags]    positive
    Dado que possuo uma sessão na API ServeRest
    E possuo um usuário previamente criado    true
    Quando requisitar a API de edição de usuários
    Então o status code será    200
    E deverá ser retornado a mensagem de sucesso da edição
    E os dados da edição serão gravados com sucesso
