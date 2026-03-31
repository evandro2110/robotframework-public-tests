*** Settings ***
Documentation    Arquivo de contendo os passos que serão usados de API PUT /usuarios ServeRest

Resource         ../../../commons/api/commonsApiServeRest.resource
Resource         ../steps/criarUsuario.resource


*** Variables ***
${MSG_SUCESSO_EDICAO}  Registro alterado com sucesso


*** Keywords ***
# --- DADO
# --- QUANDO

Quando requisitar a API de edição de usuários
    [Documentation]    Keyword para resquitar o json da edição
    Criar dados para usuário
    Requisitar API PUT /usuarios

# --- ENTAO
# --- E

E deverá ser retornado a mensagem de sucesso da edição
    [Documentation]    Valida mensagem de resposta da API para edição de usuário
    Validar mensagem de response    ${CAMPO_MSG}    ${MSG_SUCESSO_EDICAO}

E os dados da edição serão gravados com sucesso
    [Documentation]    Valida se os dados da edição foram gravados com sucesso
    ${DADOS_RETORNADOS}    Consultar usuário por ID
    Set Test Variable    ${DADOS_RETORNADOS}
    Validar dados após edição do usuário

# --- STEPS

Requisitar API PUT /usuarios
    [Documentation]    Requisição da API de edição de usuários com parâmetros
    Preparar body para edição
    ${RESPONSE}    PUT On Session
    ...    alias=${ALIAS_API_SERVEREST}
    ...    url=${URL_USUARIOS}/${ID_USUARIO}
    ...    json=${BODY}
    ...    expected_status=any

    Set Test Variable    ${RESPONSE}
    Set Test Variable    ${STATUS_RETORNADO}    ${RESPONSE.status_code}

    RETURN    ${RESPONSE.json()}

Criar massa de usuário para edição
    [Documentation]    Cria massa de usuário para a edição
    [Arguments]    ${ADM_S_N}
    Create Session    alias=${ALIAS_API_SERVEREST}    url=${BASE_URL_SERVEREST}
    Criar dados para usuário
    Set Test Variable    ${ADM_S_N}
    Criar body e requisitar API de criação de usuário
    Validar response usuário e id criado    ${CAMPO_MSG}    ${MSG_USER_CREATED}

Preparar body para edição
    [Documentation]    Preparando body para edição de usuário
    ${BODY}    Create Dictionary
    ...    nome=${DATA_USER.name}
    ...    email=${DATA_USER.email}
    ...    password=${DATA_USER.password}
    ...    administrador=${ADM_S_N}

    Set Test Variable    ${BODY}

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
