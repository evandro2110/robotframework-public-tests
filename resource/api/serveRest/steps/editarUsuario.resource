*** Settings ***
Documentation    Arquivo de contendo os passos que serão usados de API PUT /usuarios ServeRest

Resource         ../../../commons/api/commonsApiServeRest.resource
Resource         ../steps/criarUsuario.resource


*** Variables ***
${MSG_SUCESSO_EDICAO}  Registro alterado com sucesso
${MSG_ADM_EDIT_INV}    administrador deve ser 'true' ou 'false'
${EMAIL_INVALIDO}      TST

*** Keywords ***
# --- DADO
# --- QUANDO

Quando Requisitar API PUT /usuarios
    [Documentation]    Keyword para resquisitar o json da edição
    [Arguments]    ${ADM_S_N}
    Set Test Variable    ${ADM_S_N}
    Criar dados para usuário
    ${BODY}    Load Json From File    ${CURDIR}/../payload/${TEST_TAGS[0]}.json
    Set Test Variable    ${BODY}
    Preparo o body para o payload

    Requisitar API PUT /usuarios

Quando Requisitar API PUT /usuarios e-mail inválido
    [Documentation]    Keyword para resquisitar o json da edição com e-mail inválido
    [Arguments]    ${ADM_S_N}    ${DATA_USER.EMAIL}
    Set Test Variable    ${ADM_S_N}
    Set Test Variable    ${DATA_USER.EMAIL}
    ${BODY}    Load Json From File    ${CURDIR}/../payload/${TEST_TAGS[0]}.json
    Set Test Variable    ${BODY}
    Preparo o body para o payload

    Requisitar API PUT /usuarios

# --- ENTAO
# --- E

E os dados da edição serão gravados com sucesso
    [Documentation]    Valida se os dados da edição foram gravados com sucesso
    ${DADOS_RETORNADOS}    Consultar usuário por ID
    Set Test Variable    ${DADOS_RETORNADOS}
    Validar dados após edição do usuário

# --- STEPS

Preparo o body para o payload
    [Documentation]    Preparar o body para os payloads.json
    ${BODY}    Update Value To Json   ${BODY}     $..nome            ${DATA_USER.name}
    ${BODY}    Update Value To Json   ${BODY}     $..email           ${DATA_USER.email}
    ${BODY}    Update Value To Json   ${BODY}     $..password        ${DATA_USER.password}
    ${BODY}    Update Value To Json   ${BODY}     $..administrador   ${ADM_S_N}

    Set Test Variable    ${BODY}

Criar massa de usuário para edição
    [Documentation]    Cria massa de usuário para a edição
    [Arguments]    ${ADM_S_N}
    Create Session    alias=${ALIAS_API_SERVEREST}    url=${BASE_URL_SERVEREST}
    Set Test Variable    ${ADM_S_N}
    Criar usuário para testes  ${ADM_S_N}
    Validar response usuário e id criado    ${CAMPO_MSG}    ${MSG_USER_CREATED}

Consultar usuário por ID
    [Documentation]    Consulta o usuário editado
    ${RESPONSE}    GET On Session
    ...    alias=${ALIAS_API_SERVEREST}
    ...    url=${URL_USUARIOS}/${ID_USUARIO}
    ...    expected_status=any

    Set Test Variable    ${RESPONSE}
    Set Test Variable    ${STATUS_RETORNADO}    ${RESPONSE.status_code}

    RETURN    ${RESPONSE.json()}

Validar dados após edição do usuário
    [Documentation]    Realiza as validações dos dados após a edição do usuário
    Should Be Equal    ${DADOS_RETORNADOS['nome']}           ${BODY['nome']}
    Should Be Equal    ${DADOS_RETORNADOS['email']}          ${BODY['email']}
    Should Be Equal    ${DADOS_RETORNADOS['password']}       ${BODY['password']}
    Should Be Equal    ${DADOS_RETORNADOS['administrador']}  ${BODY['administrador']}
