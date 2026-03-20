*** Settings ***
Documentation    Arquivo que contém os testes da API ServeRest - Get /usuarios

# Hooks e Keywords Globais
Resource         ../../../resource/api/serveRest/steps/consultarUsuario.resource

Test Teardown    Delete All Sessions


*** Test Cases ***
CT01: Listar todos os usuários cadastrados
    [Documentation]    Validação do comportamento ao requisitar API sem informar filtros
    [Tags]    positive
    Dado que possuo uma sessão na API ServeRest
    Quando requisitar a API de consulta de usuários
    Então o status code será    200
    E todos os usuários deverão ser retornados

CT02: Consultar usuário informando nome inexistente
    [Documentation]    Validação do comportamento ao requisitar API com nome inexistente
    [Tags]    trivial
    Dado que possuo uma sessão na API ServeRest
    Quando requisitar a API de consulta de usuários com filtro de nome
    Então o status code será    200
    E não retornará usuários

CT03: Consultar usuário informando ID inexistente
    [Documentation]    Validação do comportamento ao requisitar API com ID inexistente
    [Tags]    trivial
    Dado que possuo uma sessão na API ServeRest
    Quando requisitar a API de consulta de usuários com filtro de ID
    Então o status code será    200
    E não retornará usuários

CT04: Consultar usuário informando email inexistente
    [Documentation]    Validação do comportamento ao requisitar API com email inexistente
    [Tags]    trivial
    Dado que possuo uma sessão na API ServeRest
    Quando requisitar a API de consulta de usuários com filtro de email
    Então o status code será    200
    E não retornará usuários

CT05: Consultar usuário informando senha inexistente
    [Documentation]    Validação do comportamento ao requisitar API com senha inexistente
    [Tags]    trivial
    Dado que possuo uma sessão na API ServeRest
    Quando requisitar a API de consulta de usuários com filtro de senha
    Então o status code será    200
    E não retornará usuários

CT06: Consultar usuário informando valor do campo administrador diferente de true ou false
    [Documentation]    Validação do comportamento ao requisitar API com dado diferente do esperado
    [Tags]    negative
    Dado que possuo uma sessão na API ServeRest
    Quando requisitar a API de consulta de usuários com filtro administrador inválido
    Então o status code será    400
    E a API informará que o campo ${CAMPO_ADM} deve ser true ou false

CT07: Consultar usuários administradores
    [Documentation]    Validação do comportamento ao requisitar API filtrando por adm true
    [Tags]    positive
    Dado que possuo uma sessão na API ServeRest
    Quando requisitar a API de consulta de usuários com filtro administrador    true
    Então o status code será    200
    E todos os usuários apresentados possuirão o registro de administrador correto

CT08: Consultar usuários não administradores
    [Documentation]    Validação do comportamento ao requisitar API filtrando por adm false
    [Tags]    positive
    Dado que possuo uma sessão na API ServeRest
    Quando requisitar a API de consulta de usuários com filtro administrador    false
    Então o status code será    200
    E todos os usuários apresentados possuirão o registro de administrador correto
