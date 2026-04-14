*** Settings ***
Documentation    Arquivo que contém os testes da API ServeRest - Post /usuarios

# Hooks e Keywords Globais
Resource    ../../../resource/commons/api/commonsApiServeRest.resource
Resource    ../../../resource/api/serveRest/steps/criarUsuario.resource

Test Setup       Criar dados para usuário
Test Teardown    Delete All Sessions


*** Test Cases ***
CT01: Tentar cadastrar usuário sem informar nome
    [Documentation]    Validação do comportamento da API sem informar campo obrigatório
    [Tags]    API_S01CT01    negative
    Dado que possuo uma sessão na API ServeRest
    Quando requisitar a API POST /usuario    false
    Então o status code será    400
    Então a API deve informar que o campo nome é obrigatório

CT02: Tentar cadastrar usuário sem informar senha
    [Documentation]    Validação do comportamento da API sem informar campo obrigatório
    [Tags]    API_S01CT02    negative
    Dado que possuo uma sessão na API ServeRest
    Quando requisitar a API POST /usuario    true
    Então o status code será    400
    Então a API deve informar que o campo senha é obrigatório

CT03: Tentar cadastrar usuário sem informar email
    [Documentation]    Validação do comportamento da API sem informar campo obrigatório
    [Tags]    API_S01CT03    negative
    Dado que possuo uma sessão na API ServeRest
    Quando requisitar a API POST /usuario    false
    Então o status code será    400
    Então a API deve informar que o campo email é obrigatório

CT04: Tentar cadastrar usuário sem informar se é administrador
    [Documentation]    Validação do comportamento da API sem informar campo obrigatório
    [Tags]    API_S01CT04    negative
    Dado que possuo uma sessão na API ServeRest
    Quando requisitar a API POST /usuario    ${EMPTY}
    Então o status code será    400
    Então a API deve informar que o campo administrador é obrigatório

CT05: Tentar cadastrar usuário em que o campo administrador receba valor diferente de true ou false
    [Documentation]    Validação do comportamento da API ao informar dado diferente do esperado
    [Tags]    API_S01CT05    negative
    Dado que possuo uma sessão na API ServeRest
    Quando requisitar a API POST /usuario    ${VLR_INVALIDO}
    Então o status code será    400
    Então a API deve informar que o campo administrador recebe true ou false

CT06: Cadastro de usuário administrador - Sucesso
    [Documentation]    Validação do comportamento da API ao cadastrar usuário adm
    [Tags]    API_S01CT06    positive    sucess
    Dado que possuo uma sessão na API ServeRest
    Quando requisitar a API POST /usuario    true
    Então o status code será    201
    Então a API deve informar mensagem de sucesso, juntamente com id do usuário

CT07: Cadastro de usuário não administrador - Sucesso
    [Documentation]    Validação do comportamento da API ao cadastrar usuário não adm
    [Tags]    API_S01CT07    positive    sucess
    Dado que possuo uma sessão na API ServeRest
    Quando requisitar a API POST /usuario    false
    Então o status code será    201
    Então a API deve informar mensagem de sucesso, juntamente com id do usuário

CT08: Tentar cadastrar usuário com mesmos dados
    [Documentation]    Validação do comportamento da API ao informar dados de usuário existente
    [Tags]    API_S01CT08    negative    critical
    Dado que possuo uma sessão na API ServeRest
    E possuo um usuário cadastrado
    Quando requisitar a API POST /usuario    true
    Então o status code será    400
    E a API deverá apresentar a mensagem    ${CAMPO_MSG}    ${MSG_EMAIL_EXISTENTE}
