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
    [Documentation]    Keyword para resquisitar o json da edição
    Criar dados para usuário
    Requisitar API PUT /usuarios

Quando requisitar a API de edição para um usuário com e-mail inválido
    [Documentation]    Keyword para requisitar o json de edição com e-mail inválido
    Criar dados para usuário
    Requisitar API PUT /usuarios com e-mail inválido

Quando requisitar a API de edição para um usuário sem parâmetro de nome
    [Documentation]    Keyword para requisitar o json de edição sem parâmetro de nome
    Criar dados para usuário
    Requisitar API PUT /usuarios sem o parâmetro nome

Quando requisitar a API de edição para um usuário sem parâmetro de e-mail
    [Documentation]    Keyword para requisitar o json de edição sem parâmetro de e-mail
    Criar dados para usuário
    Requisitar API PUT /usuarios sem o parâmetro e-mail

Quando requisitar a API de edição para um usuário sem parâmetro de password
    [Documentation]    Keyword para requisitar o json de edição sem parâmetro de password
    Criar dados para usuário
    Requisitar API PUT /usuarios sem o parâmetro password

Quando requisitar a API de edição para um usuário sem parâmetro de administrador
    [Documentation]    Keyword para requisitar o json de edição sem parâmetro de administrador
    Criar dados para usuário
    Requisitar API PUT /usuarios sem o parâmetro administrador

# --- ENTAO
# --- E

E deverá ser retornado a mensagem de e-mail inválido
    [Documentation]    Valida a mensagem de erro de e-mail inválido
    Validar mensagem de erro no campo    ${CAMPO_EMAIL}    ${MSG_EMAIL_INVALIDO}

E deverá ser retornado a mensagem de sucesso da edição
    [Documentation]    Valida mensagem de resposta da API para edição de usuário
    Validar mensagem de response    ${CAMPO_MSG}    ${MSG_SUCESSO_EDICAO}

E deverá ser retornado a mensagem de nome obrigatório
    [Documentation]    Valida mensagem de resposta da API para edição de usuário sem parâmetro de nome
    Validar mensagem de erro no campo    ${CAMPO_NOME}    ${MSG_NOME_OBRIGATORIO}

E deverá ser retornado a mensagem de e-mail obrigatório
    [Documentation]    Valida mensagem de resposta da API para edição de usuário sem parâmetro de e-mail
    Validar mensagem de erro no campo    ${CAMPO_EMAIL}    ${MSG_EMAIL_OBRIGATORIO}

E deverá ser retornado a mensagem de password obrigatório
    [Documentation]    Valida mensagem de resposta da API para edição de usuário sem parâmetro de password
    Validar mensagem de erro no campo    ${CAMPO_PWD}    ${MSG_SENHA_OBRIGATORIO}

E deverá ser retornado a mensagem de administrador obrigatório
    [Documentation]    Valida mensagem de resposta da API para edição de usuário sem parâmetro adm
    Validar mensagem de erro no campo    ${CAMPO_ADM}    ${MSG_ADM_OBRIGATORIO}

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

Requisitar API PUT /usuarios com e-mail inválido
    [Documentation]    Requisição da API de edição de usuários com e-mail inválido
    ${EMAIL_INVALIDO}    FakerLibrary.First Name
    Set test variable    ${DATA_USER.EMAIL}   ${EMAIL_INVALIDO}
    Preparar body para edição
    ${RESPONSE}    PUT On Session
    ...    alias=${ALIAS_API_SERVEREST}
    ...    url=${URL_USUARIOS}/${ID_USUARIO}
    ...    json=${BODY}
    ...    expected_status=any

    Set Test Variable    ${RESPONSE}
    Set Test Variable    ${STATUS_RETORNADO}    ${RESPONSE.status_code}

    RETURN    ${RESPONSE.json()}

Requisitar API PUT /usuarios sem o parâmetro nome
    [Documentation]    Requisição da API de edição de usuários sem o parâmetro nome
    Preparar body para edição sem o parâmetro nome
    ${RESPONSE}    PUT On Session
    ...    alias=${ALIAS_API_SERVEREST}
    ...    url=${URL_USUARIOS}/${ID_USUARIO}
    ...    json=${BODY}
    ...    expected_status=any

    Set Test Variable    ${RESPONSE}
    Set Test Variable    ${STATUS_RETORNADO}    ${RESPONSE.status_code}

    RETURN    ${RESPONSE.json()}

Requisitar API PUT /usuarios sem o parâmetro e-mail
    [Documentation]    Requisição da API de edição de usuários sem o parâmetro e-mail
    Preparar body para edição sem o parâmetro e-mail
    ${RESPONSE}    PUT On Session
    ...    alias=${ALIAS_API_SERVEREST}
    ...    url=${URL_USUARIOS}/${ID_USUARIO}
    ...    json=${BODY}
    ...    expected_status=any

    Set Test Variable    ${RESPONSE}
    Set Test Variable    ${STATUS_RETORNADO}    ${RESPONSE.status_code}

    RETURN    ${RESPONSE.json()}

Requisitar API PUT /usuarios sem o parâmetro password
    [Documentation]    Requisição da API de edição de usuários sem o parâmetro password
    Preparar body para edição sem o parâmetro password
    ${RESPONSE}    PUT On Session
    ...    alias=${ALIAS_API_SERVEREST}
    ...    url=${URL_USUARIOS}/${ID_USUARIO}
    ...    json=${BODY}
    ...    expected_status=any

    Set Test Variable    ${RESPONSE}
    Set Test Variable    ${STATUS_RETORNADO}    ${RESPONSE.status_code}

    RETURN    ${RESPONSE.json()}

Requisitar API PUT /usuarios sem o parâmetro administrador
    [Documentation]    Requisição da API de edição de usuários sem o parâmetro administrador
    Preparar body para edição sem o parâmetro administrador
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

Preparar body para edição sem o parâmetro nome
    [Documentation]    Preparando body para edição de usuário sem o parâmetro nome
    ${BODY}    Create Dictionary
    ...    email=${DATA_USER.email}
    ...    password=${DATA_USER.password}
    ...    administrador=${ADM_S_N}

    Set Test Variable    ${BODY}

Preparar body para edição sem o parâmetro e-mail
    [Documentation]    Preparando body para edição de usuário sem o parâmetro e-mail
    ${BODY}    Create Dictionary
    ...    nome=${DATA_USER.name}
    ...    password=${DATA_USER.password}
    ...    administrador=${ADM_S_N}

    Set Test Variable    ${BODY}

Preparar body para edição sem o parâmetro password
    [Documentation]    Preparando body para edição de usuário sem o parâmetro password
    ${BODY}    Create Dictionary
    ...    nome=${DATA_USER.name}
    ...    email=${DATA_USER.email}
    ...    administrador=${ADM_S_N}

    Set Test Variable    ${BODY}

Preparar body para edição sem o parâmetro administrador
    [Documentation]    Preparando body para edição de usuário sem o parâmetro administrador
    ${BODY}    Create Dictionary
    ...    nome=${DATA_USER.name}
    ...    email=${DATA_USER.email}
    ...    password=${DATA_USER.password}

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
