*** Settings ***
Documentation    Arquivo de contendo os passos que serão usados de API de usuários ServeRest

Resource         ../../../commons/api/commonsApiServeRest.resource
Resource         ../steps/consultarUsuario.resource


*** Variables ***
${MSG_NOME_OBRIG}         nome é obrigatório
${MSG_PWD_OBRIG}          password é obrigatório
${MSG_EMAIL_OBRIG}        email é obrigatório
${MSG_ADM_OBRIG}          administrador é obrigatório
${MSG_ADM_VLR_INV}        administrador deve ser 'true' ou 'false'
${MSG_USER_CREATED}       Cadastro realizado com sucesso
${MSG_EMAIL_EXISTENTE}    Este email já está sendo usado
${VLR_INVALIDO}           será


*** Keywords ***
# --- DADO
# --- QUANDO
# To do: após evoluir o projeto posso isolar as requisições criando uma tag para cada teste
Quando requisitar a API de cadastro de usuário sem informar o nome
    [Documentation]   Requisita a API de cadastro de usuário sem informar o campo nome
    ${BODY}    Create Dictionary
    ...    email=${DATA_USER.email}
    ...    password=${DATA_USER.password}
    ...    administrador=false

    Set Test Variable    ${BODY}
    Requisição API /usuarios

Quando requisitar a API de cadastro de usuário sem informar a senha
    [Documentation]    Requisição da API sem informar campo senha
    ${BODY}    Create Dictionary
    ...    nome=${DATA_USER.name}
    ...    email=${DATA_USER.email}
    ...    administrador=true

    Set Test Variable    ${BODY}
    Requisição API /usuarios

Quando requisitar a API de cadastro de usuário sem informar o email
    [Documentation]    Requisição da API sem informar campo email
    ${BODY}    Create Dictionary
    ...    nome=${DATA_USER.name}
    ...    password=${DATA_USER.password}
    ...    administrador=false

    Set Test Variable    ${BODY}
    Requisição API /usuarios

Quando requisitar a API de cadastro de usuário sem informar se é administrador
    [Documentation]    Requisição da API sem informar campo administrador
    ${BODY}    Create Dictionary
    ...    nome=${DATA_USER.name}
    ...    email=${DATA_USER.email}
    ...    password=${DATA_USER.password}

    Set Test Variable    ${BODY}
    Requisição API /usuarios

Quando requisitar a API de cadastro de usuário onde o campo administrador tenha valor inválido
    [Documentation]    Requisição da API informando o campo administrador com valor inválido
    ${BODY}    Create Dictionary
    ...    nome=${DATA_USER.name}
    ...    email=${DATA_USER.email}
    ...    password=${DATA_USER.password}
    ...    administrador=${VLR_INVALIDO}

    Set Test Variable    ${BODY}
    Requisição API /usuarios

Quando requisitar a API de cadastro de usuário informando os campos corretamente
    [Documentation]    Requisição com os campos corretos
    [Arguments]    ${ADM_S_N}
    Set Test Variable    ${ADM_S_N}
    Criar body e requisitar API de criação de usuário

Quando requisitar a API de cadastro de usuário informando os mesmos dados
    [Documentation]    Chama a API de cadastro de usuário
    Criar body e requisitar API de criação de usuário

# --- ENTAO
# Uma opção é criar um IF caso receba o compo nome X ter a mensagem Y, ao invés de fazer um então para cada cenário

Então a API deve informar que o campo nome é obrigatório
    [Documentation]   Valida que a resposta da API contém a mensagem de campo obrigatório para o nome
    Validar mensagem de erro no campo    ${CAMPO_NOME}    ${MSG_NOME_OBRIG}

Então a API deve informar que o campo senha é obrigatório
    [Documentation]   Valida que a resposta da API contém a mensagem de campo obrigatório senha
    Validar mensagem de erro no campo    ${CAMPO_PWD}    ${MSG_PWD_OBRIG}

Então a API deve informar que o campo email é obrigatório
    [Documentation]   Valida que a resposta da API contém a mensagem de campo obrigatório email
    Validar mensagem de erro no campo    ${CAMPO_EMAIL}    ${MSG_EMAIL_OBRIG}

Então a API deve informar que o campo administrador é obrigatório
    [Documentation]    Valida mensagem em relação ao campo
    Validar mensagem de erro no campo    ${CAMPO_ADM}    ${MSG_ADM_OBRIG}

Então a API deve informar que o campo administrador recebe true ou false
    [Documentation]    Valida mensagem em relação ao campo
    Validar mensagem de erro no campo    ${CAMPO_ADM}    ${MSG_ADM_VLR_INV}

Então a API deve informar mensagem de sucesso, juntamente com id do usuário
    [Documentation]    Valida mensagem em relação ao campo
    Validar response usuário e id criado    ${CAMPO_MSG}    ${MSG_USER_CREATED}
    Valida schema de usuário criado com sucesso

# --- E

E possuo um usuário cadastrado
    [Documentation]    Chama a API de cadastro de usuário para garantir que exista um usuário cadastrado para o teste
    Criar usuário    true

# --- STEPS

Requisição API /usuarios
    [Documentation]    Requisição isolada para api /usuarios
    ${RESPONSE}    POST On Session
    ...    alias=${ALIAS_API_SERVEREST}
    ...    url=${URL_USUARIOS}
    ...    json=${BODY}
    ...    expected_status=any
    Set Test Variable    ${RESPONSE}
    Set Test Variable    ${STATUS_RETORNADO}    ${RESPONSE.status_code}
    RETURN    ${RESPONSE.json()}

Valida schema de usuário criado com sucesso
    [Documentation]    Validação conforme arquivo json schema para resposta de usuario criado com sucesso
    Validate Jsonschema From File    ${RESPONSE.json()}    ${CURDIR}/../schemas/usuario_criado.json

Criar body e requisitar API de criação de usuário
    [Documentation]    Cria o body para requisição usando os dados da variável de suíte
    ${BODY}    Create Dictionary
    ...    nome=${DATA_USER.name}
    ...    email=${DATA_USER.email}
    ...    password=${DATA_USER.password}
    ...    administrador=${ADM_S_N}

    Set Test Variable    ${BODY}
    Requisição API /usuarios
