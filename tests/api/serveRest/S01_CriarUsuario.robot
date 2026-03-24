*** Settings ***
Documentation    Arquivo que contém os testes da API ServeRest - Post /usuarios

# Hooks e Keywords Globais
Resource    ../../../resource/api/serveRest/steps/criarUsuario.resource

Test Setup       Criar dados para novo usuário
Test Teardown    Delete All Sessions


*** Test Cases ***
CT01: Tentar cadastrar usuário sem informar nome
    [Documentation]    Validação do comportamento da API sem informar campo obrigatório
    [Tags]    negative
    Dado que possuo uma sessão na API ServeRest
    Quando requisitar a API de cadastro de usuário sem informar o nome
    Então o status code será    400
    Então a API deve informar que o campo nome é obrigatório

CT02: Tentar cadastrar usuário sem informar senha
    [Documentation]    Validação do comportamento da API sem informar campo obrigatório
    [Tags]    negative
    Dado que possuo uma sessão na API ServeRest
    Quando requisitar a API de cadastro de usuário sem informar a senha
    Então o status code será    400
    Então a API deve informar que o campo senha é obrigatório

CT03: Tentar cadastrar usuário sem informar email
    [Documentation]    Validação do comportamento da API sem informar campo obrigatório
    [Tags]    negative
    Dado que possuo uma sessão na API ServeRest
    Quando requisitar a API de cadastro de usuário sem informar o email
    Então o status code será    400
    Então a API deve informar que o campo email é obrigatório

CT04: Tentar cadastrar usuário sem informar se é administrador
    [Documentation]    Validação do comportamento da API sem informar campo obrigatório
    [Tags]    negative
    Dado que possuo uma sessão na API ServeRest
    Quando requisitar a API de cadastro de usuário sem informar se é administrador
    Então o status code será    400
    Então a API deve informar que o campo administrador é obrigatório

CT05: Tentar cadastrar usuário em que o campo administrador receba valor diferente de true ou false
    [Documentation]    Validação do comportamento da API ao informar dado diferente do esperado
    [Tags]    negative
    Dado que possuo uma sessão na API ServeRest
    Quando requisitar a API de cadastro de usuário onde o campo administrador tenha valor inválido
    Então o status code será    400
    Então a API deve informar que o campo administrador recebe true ou false

CT06: Cadastro de usuário administrador - Sucesso
    [Documentation]    Validação do comportamento da API ao informar dado diferente do esperado
    [Tags]    positive    sucess
    Dado que possuo uma sessão na API ServeRest
    Quando requisitar a API de cadastro de usuário informando os campos corretamente    true
    Então o status code será    201
    Então a API deve informar mensagem de sucesso, juntamente com id do usuário

CT07: Cadastro de usuário não administrador - Sucesso
    [Documentation]    Validação do comportamento da API ao informar dado diferente do esperado
    [Tags]    positive    sucess
    Dado que possuo uma sessão na API ServeRest
    Quando requisitar a API de cadastro de usuário informando os campos corretamente    false
    Então o status code será    201
    Então a API deve informar mensagem de sucesso, juntamente com id do usuário

CT08: Tentar cadastrar usuário com mesmos dados
    [Documentation]    Validação do comportamento da API ao informar dados de usuário existente
    [Tags]    negative    critical
    Dado que possuo uma sessão na API ServeRest
    E possuo um usuário cadastrado
    Quando requisitar a API de cadastro de usuário informando os mesmos dados
    Então o status code será    400
    E a API deverá apresentar a mensagem    ${CAMPO_MSG}    ${MSG_EMAIL_EXISTENTE}
    Force fail
