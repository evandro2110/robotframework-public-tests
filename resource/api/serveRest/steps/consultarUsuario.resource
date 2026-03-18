*** Settings ***
Documentation    Arquivo de contendo os passos que serão usados de API GET /usuarios ServeRest

Resource         ../../../commons/api/commonsApiServeRest.resource
Resource         ../steps/criarUsuario.resource


*** Variables ***
${NAME_NOT_FOUND}      NOT-FOUND
${MSG_ADM_INVALIDO}    administrador deve ser 'true' ou 'false'


*** Keywords ***
# --- DADO
# --- QUANDO
Quando requisitar a API de consulta de usuários
    [Documentation]    Chama a KW de requisição de consulta de usuários
    Requisitar API de consulta de usuários full

Quando requisitar a API de consulta de usuários com filtro de nome
    [Documentation]    Requisição da API de consulta de usuários para o campo nome
    ${PARAMETROS}    Create Dictionary    ${CAMPO_NOME}=${NAME_NOT_FOUND}
    Set Test Variable    ${PARAMETROS}
    Requisitar API GET /usuario com parâmetros
    Should Be Equal As Integers    ${QTD_USUARIOS}    0

Quando requisitar a API de consulta de usuários com filtro de ID
    [Documentation]    Requisição da API de consulta de usuários para o campo ID
    ${ID_NOT_FOUND}    FakerLibrary.Random Number    9    True
    ${PARAMETROS}    Create Dictionary    ${CAMPO_ID}=${ID_NOT_FOUND}
    Set Test Variable    ${PARAMETROS}
    Requisitar API GET /usuario com parâmetros
    Should Be Equal As Integers    ${QTD_USUARIOS}    0

Quando requisitar a API de consulta de usuários com filtro de email
    [Documentation]    Requisição da API de consulta de usuários para o campo email
    ${EMAIL_NOT_FOUND}    FakerLibrary.Email    ${False}
    ${PARAMETROS}    Create Dictionary    ${CAMPO_EMAIL}=${EMAIL_NOT_FOUND}
    Set Test Variable    ${PARAMETROS}
    Requisitar API GET /usuario com parâmetros
    Should Be Equal As Integers    ${QTD_USUARIOS}    0

Quando requisitar a API de consulta de usuários com filtro de senha
    [Documentation]    Requisição da API de consulta de usuários para o campo senha
    ${PDW_NOT_FOUND}    FakerLibrary.Password
    ${PARAMETROS}    Create Dictionary    ${CAMPO_PWD}=${PDW_NOT_FOUND}
    Set Test Variable    ${PARAMETROS}
    Requisitar API GET /usuario com parâmetros
    Should Be Equal As Integers    ${QTD_USUARIOS}    0

Quando requisitar a API de consulta de usuários com filtro administrador inválido
    [Documentation]    Requisição da API de consulta de usuários para o campo administrador
    ${ADM_INVALIDO}    FakerLibrary.Random Number    1    ${True}
    ${PARAMETROS}    Create Dictionary    ${CAMPO_ADM}=${ADM_INVALIDO}
    Set Test Variable    ${PARAMETROS}
    Requisitar API GET /usuario com parâmetros

# --- ENTAO

E a API informará que o campo ${CAMPO_ADM} deve ser true ou false
    [Documentation]    Valida mensagem de erro informada pela API para o campo administrador
    Validar mensagem de erro no campo    ${CAMPO_ADM}    ${MSG_ADM_INVALIDO}

# --- E

E todos os usuários deverão ser retornados
    [Documentation]    Chama a KW de validação de schema
    Validar schema da consulta de usuários

E não retornará usuários
    [Documentation]    Valida que a API retornou uma lista de usuários vazia
    Validar que não existem usuários na lista

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
    Should Be Empty    ${LISTA_USUARIOS}
