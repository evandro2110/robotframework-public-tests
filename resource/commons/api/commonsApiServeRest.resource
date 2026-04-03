*** Settings ***
Documentation    Arquivo de contendo as variáveis comumente usadas nos de API ServeRest

Library    Collections
Library    JsonValidator
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
    Validar mensagem de erro no campo    ${PARAMETRO}    ${MSG}

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

Armazenar token
    [Documentation]   Armazena o token de autenticação retornado pela API
    ${BODY}      Create Dictionary   email=${DATA_USER.email}   password=${DATA_USER.password}
    ${RESPONSE}  POST On Session     alias=${ALIAS_API_SERVEREST}    url=${URL_LOGIN}    json=${BODY}
    Log   Resposta Retornada: ${\n}${RESPONSE.text}
    Dictionary Should Contain Item    ${RESPONSE.json()}    message    ${MSG_LOGIN_SUCESS}
    ${TOKEN}     Get From Dictionary    ${RESPONSE.json()}    authorization
    Set Suite Variable    ${TOKEN}

Validar mensagem de erro no campo
    [Documentation]  Valida que a resposta da API contém a mensagem de erro esperada
    [Arguments]    ${CAMPO}    ${MENSAGEM_ESPERADA}
    Dictionary Should Contain Item    ${RESPONSE.json()}    ${CAMPO}    ${MENSAGEM_ESPERADA}

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
