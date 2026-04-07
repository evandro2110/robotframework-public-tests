*** Settings ***
Documentation    Arquivo de contendo as variáveis comumente usadas nos de API ServeRest

Library    Collections
Library    JsonValidator
Library    JSONLibrary
Library    RequestsLibrary
Library    FakerLibrary    locale=pt_br


*** Variables ***
${ALIAS_API_SERVEREST}     api_serveRest
${BASE_URL_SERVEREST}      https://serverest.dev
${URL_LOGIN}               login
${URL_USUARIOS}            usuarios
${CAMPO_NOME}              nome
${CAMPO_EMAIL}             email
${CAMPO_PWD}               password
${CAMPO_ADM}               administrador
${CAMPO_MSG}               message
${CAMPO_ID}                _id
${MSG_LOGIN_SUCESS}        Login realizado com sucesso
${MSG_EMAIL_INVALIDO}      email deve ser um email válido
${MSG_NOME_OBRIGATORIO}    nome é obrigatório
${MSG_EMAIL_OBRIGATORIO}   email é obrigatório
${MSG_SENHA_OBRIGATORIO}   password é obrigatório
${MSG_ADM_OBRIGATORIO}     administrador é obrigatório
${MSG_USUARIO_REMOVIDO}    Registro excluído com sucesso
${MSG_USER_CREATED}        Cadastro realizado com sucesso
${MSG_NENHUM_REG_REMOV}    Nenhum registro excluído


*** Keywords ***
# --- DADO
Dado que possuo uma sessão na API ServeRest
    [Documentation]   Cria uma sessão para a API ServeRest
    Iniciar sessão API ServeRest

# --- QUANDO

# --- ENTAO

Então o status code será
    [Documentation]  Valida que o status code retornado pela API é o mesmo esperado
    [Arguments]    ${STATUS_CODE}
    Should Be Equal As Integers    ${STATUS_RETORNADO}    ${STATUS_CODE}

# --- E

E a API deverá apresentar a mensagem
    [Documentation]    Chama keyword para validar mensagem de resposta da API
    [Arguments]    ${PARAMETRO}    ${MSG}
    Validar mensagem de response    ${PARAMETRO}    ${MSG}

E deverá ser retornada a mensagem no response
    [Documentation]    Chama keyword para validar mensagem de resposta da API
    [Arguments]    ${CAMPO}    ${MSG}
    Validar mensagem de response  ${CAMPO}    ${MSG}

# --- STEPS

Iniciar sessão API ServeRest
    [Documentation]  Cria uma sessão para a API ServeRest com os headers apropriados
    ${HEADERS}    Create Dictionary
    ...    Content-type=application/json
    Create Session    alias=${ALIAS_API_SERVEREST}    url=${BASE_URL_SERVEREST}    headers=${HEADERS}    verify=True

Criar dados para usuário
    [Documentation]  Gera dados aleatórios para criação de um novo usuário e armazena em variável de suíte
    ${RANDOM_FIRST_NAME}    FakerLibrary.First Name
    ${RANDOM_LAST_NAME}     FakerLibrary.Last Name
    ${RANDOM_PWD}           FakerLibrary.Password
    ${RANDOM_EMAIL}         FakerLibrary.Email
    ${DATA_USER}            Create Dictionary
    ...    name=${RANDOM_FIRST_NAME} ${RANDOM_LAST_NAME}
    ...    email=${RANDOM_EMAIL}
    ...    password=${RANDOM_PWD}

    Set Test Variable  ${DATA_USER}

Criar usuário para testes
    [Documentation]    Prepara sessão e dados para criar usuário
    [Arguments]    ${ADM_S_N}=false
    Iniciar sessão API ServeRest
    Criar dados para usuário
    ${ADM_S_N}    Set Variable If    '${ADM_S_N}' == '${EMPTY}'    false    ${ADM_S_N}
    Set Test Variable    ${ADM_S_N}
    ${BODY}    Load Json From File     ${CURDIR}/../../api/serveRest/payload/criarUsuario.json
    ${BODY}    Update Value To Json    ${BODY}    $..nome            ${DATA_USER.name}
    ${BODY}    Update Value To Json    ${BODY}    $..email           ${DATA_USER.email}
    ${BODY}    Update Value To Json    ${BODY}    $..password        ${DATA_USER.password}
    ${BODY}    Update Value To Json    ${BODY}    $..administrador   ${ADM_S_N}
    Set Test Variable    ${BODY}
    Requisitar API POST /usuarios
    Validar response usuário e id criado        ${CAMPO_MSG}    ${MSG_USER_CREATED}

Requisitar API POST /usuarios
    [Documentation]    Passos para requisição da API POST /usuarios
    ${RESPONSE}    POST On Session
    ...    alias=${ALIAS_API_SERVEREST}
    ...    url=${URL_USUARIOS}
    ...    json=${BODY}
    ...    expected_status=any
    Set Test Variable    ${RESPONSE}
    Set Test Variable    ${STATUS_RETORNADO}    ${RESPONSE.status_code}

    RETURN    ${RESPONSE.json()}

Armazenar token
    [Documentation]   Armazena o token de autenticação retornado pela API
    ${BODY}      Create Dictionary   email=${DATA_USER.email}   password=${DATA_USER.password}
    ${RESPONSE}  POST On Session     alias=${ALIAS_API_SERVEREST}    url=${URL_LOGIN}    json=${BODY}
    Log   Resposta Retornada: ${\n}${RESPONSE.text}
    Dictionary Should Contain Item    ${RESPONSE.json()}    message    ${MSG_LOGIN_SUCESS}
    ${TOKEN}     Get From Dictionary    ${RESPONSE.json()}    authorization
    Set Suite Variable    ${TOKEN}

Validar mensagem de response
    [Documentation]  Valida que a resposta da API contém a mensagem esperada
    [Arguments]    ${CAMPO}    ${MENSAGEM_ESPERADA}
    Dictionary Should Contain Item    ${RESPONSE.json()}    ${CAMPO}    ${MENSAGEM_ESPERADA}

Validar response usuário e id criado
    [Documentation]  Valida que a resposta e guarda o id do usuário gerado
    [Arguments]    ${CAMPO}    ${MENSAGEM_ESPERADA}
    ${ID_USUARIO}    Set Variable    ${RESPONSE.json()['_id']}
    Set Test Variable    ${ID_USUARIO}
    Dictionary Should Contain Item    ${RESPONSE.json()}    ${CAMPO}    ${MENSAGEM_ESPERADA}
