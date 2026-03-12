*** Settings ***
Documentation    Arquivo de contendo os passos que serão usados de API de usuários ServeRest

Resource         ../../../commons/api/commonsApiServeRest.resource


*** Variables ***
${MSG_NOME_OBRIG}    nome é obrigatório


*** Keywords ***
# --- DADO
# --- QUANDO
Quando requisitar a API de cadastro de usuário sem informar o nome
    [Documentation]   Requisita a API de cadastro de usuário sem informar o campo nome
    ${BODY}    Create Dictionary
    ...    email=${DATA_USER.email}
    ...    password=${DATA_USER.password}
    ...    administrador=false
    ${RESPONSE}    POST On Session
    ...    alias=${ALIAS_API_SERVEREST}
    ...    url=${URL_USUARIOS}
    ...    json=${BODY}
    ...    expected_status=any
    Set Test Variable    ${RESPONSE}
    ${STATUS_RETORNADO}    Set Variable    ${RESPONSE.status_code}
    Set Test Variable      ${STATUS_RETORNADO}

# --- ENTAO

Então a API deve informar que o campo nome é obrigatório
    [Documentation]   Valida que a resposta da API contém a mensagem de campo obrigatório para o nome
    Validar mensagem de erro no campo    ${CAMPO_NOME}    ${MSG_NOME_OBRIG}

# --- E
# --- STEPS
