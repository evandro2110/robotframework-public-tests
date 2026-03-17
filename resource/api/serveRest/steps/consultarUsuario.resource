*** Settings ***
Documentation    Arquivo de contendo os passos que serão usados de API GET /usuarios ServeRest

Resource         ../../../commons/api/commonsApiServeRest.resource
Resource         ../steps/criarUsuario.resource


*** Keywords ***
# --- DADO
# --- QUANDO
Quando requisitar a API de consulta de usuários
    [Documentation]    Chama a KW de requisição de consulta de usuários
    Requisitar API de consulta de usuários full

# --- ENTAO
# --- E

E todos os usuários deverão ser retornados
    [Documentation]    Chama a KW de validação de schema
    Validar schema da consulta de usuários

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
