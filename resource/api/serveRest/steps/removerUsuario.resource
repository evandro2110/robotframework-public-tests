*** Settings ***
Documentation    Arquivo de contendo os passos que serão usados de API DELETE /usuarios ServeRest

Resource         ../../../commons/api/commonsApiServeRest.resource


*** Keywords ***
# --- DADO
# --- QUANDO
Quando requisitar a API de remoção de usuário
    [Documentation]    Requisita a API de remoção de usuário
    Requisitar API DELETE /usuario

# --- ENTAO
# --- E

E possuo um ID de usuário inexistente
    [Documentation]    Gera um ID aleatório para usuário, garantindo que seja um ID inexistente
    Criar ID inexistente
# --- STEPS

Requisitar API DELETE /usuario
    [Documentation]    Requisita a API de remoção de usuário
    ${RESPONSE}    DELETE On Session
    ...    alias=${ALIAS_API_SERVEREST}
    ...    url=${URL_USUARIOS}/${ID_USUARIO}
    ...    expected_status=any

    Set Test Variable    ${RESPONSE}
    Set Test Variable    ${STATUS_RETORNADO}    ${RESPONSE.status_code}

    RETURN    ${RESPONSE.json()}

Criar ID inexistente
    [Documentation]    Gera um ID aleatório para usuário, garantindo que seja um ID inexistente
    ${ID_USUARIO}    FakerLibrary.Random Number    10
    Set Test Variable    ${ID_USUARIO}
