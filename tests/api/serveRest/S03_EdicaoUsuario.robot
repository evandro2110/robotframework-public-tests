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
    Quando requisitar a API de edição de usuários
    Então o status code será    200
    E deverá ser retornado a mensagem de sucesso da edição
    E os dados da edição serão gravados com sucesso

CT02: Atualiza um usuário e-mail inválido
    [Documentation]    Validação do comportamento ao requisitar API de edição de usuário para atualizar o nome
    [Tags]    negative
    Dado que possuo uma sessão na API ServeRest
    Quando requisitar a API de edição para um usuário com e-mail inválido
    Então o status code será    400
    E deverá ser retornado a mensagem de e-mail inválido

# CT03: Atualiza um usuário sem o parametro de nome
#     [Documentation]    Validação do comportamento ao requisitar API de edição de usuário para atualizar o nome
#     [Tags]    negative
#     Dado que possuo uma sessão na API ServeRest
#     Quando requisitar a API de edição para um usuário com e-mail inválido
#     Então o status code será    400
#     E deverá ser retornado a mensagem de e-mail inválido
