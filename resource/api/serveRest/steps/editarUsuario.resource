*** Settings ***
Documentation    Arquivo de contendo os passos que serão usados de API PUT /usuarios ServeRest

Resource         ../../../commons/api/commonsApiServeRest.resource
Resource         ../steps/criarUsuario.resource     


*** Variables ***
${MSG_SUCESSO_EDICAO}  Registro alterado com sucesso
${NOME_EDITADO}        NOME EDITADO
${EMAIL_EDITADO}       editado@qa.com.br
${PASSWORD_EDITADO}    SENHA EDITADA


*** Keywords ***
# --- DADO
# --- QUANDO    

Quando requisitar a API de edição de usuários
    [Documentation]    Keyword para resquitar o json da edição
    Requisitar API PUT /usuarios 
   
# --- ENTAO
# --- E

E deverá ser retornado a mensagem de sucesso da edição
    [Documentation]    Valida mensagem de resposta da API para edição de usuário
    Validar mensagem de response    ${CAMPO_MSG}    ${MSG_SUCESSO_EDICAO}

# --- STEPS

Requisitar API PUT /usuarios
    [Documentation]    Requisição da API de edição de usuários com parâmetros
    ${RESPONSE}    PUT On Session
    ...    alias=${ALIAS_API_SERVEREST}
    ...    url=${URL_USUARIOS}
    ...    params=${ID_USUARIO}
    ...    expected_status=any

    Preparar body para edição
    Set Test Variable    ${RESPONSE}
    Set Test Variable    ${STATUS_RETORNADO}    ${RESPONSE.status_code}

    RETURN    ${RESPONSE.json()}

Criar massa de usuário para edição
    [Documentation]    Cria massa de usuário para a edição
    [Arguments]    ${ADM_S_N}
    Create Session    alias=${ALIAS_API_SERVEREST}    url=${BASE_URL_SERVEREST}
    Criar dados para novo usuário
    Set Test Variable    ${ADM_S_N}
    Criar body e requisitar API de criação de usuário
    Validar response usuário e id criado

Preparar body para edição
    [Documentation]    Preparando body para edição de usuário
    ${BODY}    Create Dictionary
    ...    nome=${NOME_EDITADO}
    ...    email=${EMAIL_EDITADO}
    ...    password=${PASSWORD_EDITADO}
    ...    administrador=${ADM_S_N}

    Set Test Variable    ${BODY}