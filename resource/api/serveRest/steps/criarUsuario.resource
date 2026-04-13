*** Settings ***
Documentation    Arquivo de contendo os passos que serão usados de API de usuários ServeRest

Resource         ../../../commons/api/commonsApiServeRest.resource
Resource         ../steps/consultarUsuario.resource


*** Variables ***
${MSG_ADM_VLR_INV}        administrador deve ser 'true' ou 'false'
${MSG_EMAIL_EXISTENTE}    Este email já está sendo usado
${VLR_INVALIDO}           tst


*** Keywords ***
# --- DADO
# --- QUANDO

Quando requisitar a API POST /usuario
    [Documentation]   Requisita a API de cadastro de usuário sem informar o campo nome
    [Arguments]    ${ADM_S_N}
    Set Test Variable    ${ADM_S_N}
    Iniciar sessão API ServeRest
    ${BODY}    Load Json From File     ${CURDIR}/../payload/${TEST_TAGS[0]}.json
    ${BODY}    Update Value To Json    ${BODY}    $..nome            ${DATA_USER.name}
    ${BODY}    Update Value To Json    ${BODY}    $..email           ${DATA_USER.email}
    ${BODY}    Update Value To Json    ${BODY}    $..password        ${DATA_USER.password}
    ${BODY}    Update Value To Json    ${BODY}    $..administrador   ${ADM_S_N}

    Set Test Variable    ${BODY}
    Requisitar API POST /usuarios

# --- ENTAO
# Uma opção é criar um IF caso receba o compo nome X ter a mensagem Y, ao invés de fazer um então para cada cenário

Então a API deve informar que o campo nome é obrigatório
    [Documentation]   Valida que a resposta da API contém a mensagem de campo obrigatório para o nome
    Validar mensagem de response    ${CAMPO_NOME}    ${MSG_NOME_OBRIGATORIO}

Então a API deve informar que o campo senha é obrigatório
    [Documentation]   Valida que a resposta da API contém a mensagem de campo obrigatório senha
    Validar mensagem de response    ${CAMPO_PWD}    ${MSG_SENHA_OBRIGATORIO}

Então a API deve informar que o campo email é obrigatório
    [Documentation]   Valida que a resposta da API contém a mensagem de campo obrigatório email
    Validar mensagem de response    ${CAMPO_EMAIL}    ${MSG_EMAIL_OBRIGATORIO}

Então a API deve informar que o campo administrador é obrigatório
    [Documentation]    Valida mensagem em relação ao campo
    Validar mensagem de response    ${CAMPO_ADM}    ${MSG_ADM_OBRIGATORIO}

Então a API deve informar que o campo administrador recebe true ou false
    [Documentation]    Valida mensagem em relação ao campo
    Validar mensagem de response    ${CAMPO_ADM}    ${MSG_ADM_VLR_INV}

Então a API deve informar mensagem de sucesso, juntamente com id do usuário
    [Documentation]    Valida mensagem em relação ao campo
    Validar response usuário e id criado    ${CAMPO_MSG}    ${MSG_USER_CREATED}
    Valida schema de usuário criado com sucesso

# --- E

E possuo um usuário cadastrado
    [Documentation]    Chama a API de cadastro de usuário para garantir que exista um usuário cadastrado para o teste
    Criar usuário para testes    true

# --- STEPS

Valida schema de usuário criado com sucesso
    [Documentation]    Validação conforme arquivo json schema para resposta de usuario criado com sucesso
    Validate Jsonschema From File    ${RESPONSE.json()}    ${CURDIR}/../schemas/usuario_criado.json
