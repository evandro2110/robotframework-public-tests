*** Settings ***
Documentation    Arquivo de contendo os passos que serão usados de API GET /usuarios ServeRest

Resource         ../../../commons/api/commonsApiServeRest.resource
Resource         ../steps/criarUsuario.resource


*** Variables ***
${NAME_NOT_FOUND}      Name Robot
${MSG_ADM_INVALIDO}    administrador deve ser 'true' ou 'false'
${ID_NOT_FOUND}        88776611
${EMAIL_NOT_FOUND}     test@roboteste.com.br
${PWD_NOT_FOUND}       test_pwd


*** Keywords ***
# --- DADO
# --- QUANDO
Quando requisitar a API de consulta de usuários
    [Documentation]    Chama a KW de requisição de consulta de usuários
    Requisitar API de consulta de usuários full

Quando requisitar a API de consulta de usuários com filtro de nome
    [Documentation]    Requisição da API de consulta de usuários para o campo nome
    [Arguments]    ${NOME}
    ${PARAMETROS}    Create Dictionary    ${CAMPO_NOME}=${NOME}
    Set Test Variable    ${PARAMETROS}
    Requisitar API GET /usuario com parâmetros

Quando requisitar a API de consulta de usuários com filtro de ID
    [Documentation]    Requisição da API de consulta de usuários para o campo ID
    [Arguments]    ${USER_ID}
    ${PARAMETROS}    Create Dictionary    ${CAMPO_ID}=${USER_ID}
    Set Test Variable    ${PARAMETROS}
    Requisitar API GET /usuario com parâmetros

Quando requisitar a API de consulta de usuários com filtro de email
    [Documentation]    Requisição da API de consulta de usuários para o campo email
    [Arguments]    ${EMAIL}
    ${PARAMETROS}    Create Dictionary    ${CAMPO_EMAIL}=${EMAIL}
    Set Test Variable    ${PARAMETROS}
    Requisitar API GET /usuario com parâmetros

Quando requisitar a API de consulta de usuários com filtro de senha
    [Documentation]    Requisição da API de consulta de usuários para o campo senha
    [Arguments]    ${PASSWORD}
    ${PARAMETROS}    Create Dictionary    ${CAMPO_PWD}=${PASSWORD}
    Set Test Variable    ${PARAMETROS}
    Requisitar API GET /usuario com parâmetros

Quando requisitar a API de consulta de usuários com filtro administrador inválido
    [Documentation]    Requisição da API de consulta de usuários para o campo administrador
    ${ADM_INVALIDO}    FakerLibrary.Random Number    1    ${True}
    ${PARAMETROS}    Create Dictionary    ${CAMPO_ADM}=${ADM_INVALIDO}
    Set Test Variable    ${PARAMETROS}
    Requisitar API GET /usuario com parâmetros

Quando requisitar a API de consulta de usuários com filtro administrador
    [Documentation]    Requisição da API de consulta de usuários para o campo administrador
    [Arguments]    ${TRUE_OR_FALSE}
    Set Test Variable    ${TRUE_OR_FALSE}
    ${PARAMETROS}    Create Dictionary  ${CAMPO_ADM}=${TRUE_OR_FALSE}
    Set Test Variable    ${PARAMETROS}
    Requisitar API GET /usuario com parâmetros

# --- ENTAO

# --- E

E todos os usuários deverão ser retornados
    [Documentation]    Chama a KW de validação de schema
    Validar schema da consulta de usuários

E não retornará usuários
    [Documentation]    Valida que a API retornou uma lista de usuários vazia
    Validar que não existem usuários na lista

E a API informará que o campo ${CAMPO_ADM} deve ser true ou false
    [Documentation]    Valida mensagem de erro informada pela API para o campo administrador
    Validar mensagem de erro no campo    ${CAMPO_ADM}    ${MSG_ADM_INVALIDO}

E todos os usuários apresentados possuirão o registro de administrador correto
    [Documentation]    Chamada da KW para validar os usuários retornados estão com o campo administrador correto
    Validar response com administradores

E possuo um usuário previamente criado
    [Documentation]    Chama a KW para criar um usuário antes de realizar a consulta
    [Arguments]    ${ADM_S_N}
    Set Test Variable    ${ADM_S_N}
    Criar usuário        ${ADM_S_N}

E os dados do usuário serão apresentados corretamente
    [Documentation]    Valida se os dados do usuário criado estão corretos na resposta da API
    Should Be True    ${QTD_USUARIOS} > 0
    Validate Jsonschema From File    ${RESPONSE.json()}    ${CURDIR}/../schemas/usuario_lista.json

# --- STEPS

Requisitar API de consulta de usuários full
    [Documentation]    Requisição da API de consulta sem parâmetros
    ${RESPONSE}    GET On Session
    ...    alias=${ALIAS_API_SERVEREST}
    ...    url=${URL_USUARIOS}
    ...    expected_status=any
    Set Test Variable    ${RESPONSE}
    Set Test Variable    ${STATUS_RETORNADO}    ${RESPONSE.status_code}
    Set Test Variable    ${QTD_USUARIOS}    ${RESPONSE.json()['quantidade']}

    RETURN    ${RESPONSE.json()}

Validar schema da consulta de usuários
    [Documentation]    Valida schema da API de consulta de usuários
    Should Be True    ${QTD_USUARIOS} > 0
    Validate Jsonschema From File    ${RESPONSE.json()}    ${CURDIR}/../schemas/usuario_lista.json

Requisitar API GET /usuario com parâmetros
    [Documentation]    Requisição da API de consulta de usuários com parâmetros
    ${RESPONSE}    GET On Session
    ...    alias=${ALIAS_API_SERVEREST}
    ...    url=${URL_USUARIOS}
    ...    params=${PARAMETROS}
    ...    expected_status=any

    Set Test Variable    ${RESPONSE}
    Set Test Variable    ${STATUS_RETORNADO}    ${RESPONSE.status_code}
    IF    '${STATUS_RETORNADO}' == '200'
        Set Test Variable    ${QTD_USUARIOS}    ${RESPONSE.json()['quantidade']}
    END

    RETURN    ${RESPONSE.json()}

Validar que não existem usuários na lista
    [Documentation]    Valida se o array de usuários está de fato vazio
    ${LISTA_USUARIOS}    Set Variable    ${RESPONSE.json()['usuarios']}
    Should Be Equal As Integers    ${QTD_USUARIOS}    0
    Should Be Empty    ${LISTA_USUARIOS}

Validar response com administradores
    [Documentation]    Valida se os usuários retornados possuem o campo administrador conforme o filtro utilizado
    ${LISTA_USUARIOS}    Set Variable    ${RESPONSE.json()['usuarios']}

    FOR    ${USUARIO}    IN    @{LISTA_USUARIOS}
        Should Be Equal    ${USUARIO['administrador']}    ${TRUE_OR_FALSE}
        ...    msg=Erro: ${USUARIO['nome']} deveria estar como administrador = ${TRUE_OR_FALSE}.
    END

Criar usuário
    [Documentation]    Passo para criar um usuário utilizando a API de criação
    [Arguments]    ${ADM_S_N}
    Set Test Variable   ${ADM_S_N}
    Criar dados para novo usuário
    ${BODY}    Create Dictionary
    ...    nome=${DATA_USER.name}
    ...    email=${DATA_USER.email}
    ...    password=${DATA_USER.password}
    ...    administrador=${ADM_S_N}

    Set Test Variable    ${BODY}
    Requisição API /usuarios
    Validar response usuário e id criado    ${CAMPO_MSG}    ${MSG_USER_CREATED}
