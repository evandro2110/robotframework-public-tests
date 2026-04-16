*** Settings ***
Documentation    Arquivo que contém os testes da API ServeRest - Put /usuarios

# Hooks e Keywords Globais
Resource         ../../../resource/api/serveRest/steps/editarUsuario.resource
Resource         ../../../resource/api/serveRest/steps/consultarUsuario.resource

Test Setup       Criar massa de usuário para edição    true
Test Teardown    Delete All Sessions


*** Test Cases ***
CT01: Atualiza todos os dados de um usuário cadastrado
    [Documentation]    Validação do comportamento ao requisitar API de edição de usuário para atualizar todos os dados
    [Tags]   API_S03CT01    positive
    Dado que possuo uma sessão na API ServeRest
    Quando Requisitar API PUT /usuarios    true
    Então o status code será    200
    E a API deverá apresentar a mensagem    ${CAMPO_MSG}    ${MSG_SUCESSO_EDICAO}
    E os dados da edição serão gravados com sucesso

CT02: Atualiza um usuário e-mail inválido
    [Documentation]    Validação do comportamento ao requisitar API de edição de usuário para atualizar o nome
    [Tags]    API_S03CT02    negative
    Dado que possuo uma sessão na API ServeRest
    Quando Requisitar API PUT /usuarios e-mail inválido    true    ${EMAIL_INVALIDO}
    Então o status code será    400
    E a API deverá apresentar a mensagem    ${CAMPO_EMAIL}    ${MSG_EMAIL_INVALIDO}

CT03: Atualiza um usuário sem o parâmetro de nome
    [Documentation]    Validação do comportamento ao requisitar API de edição de usuário sem parâmetro de nome
    [Tags]    API_S03CT03    negative
    Dado que possuo uma sessão na API ServeRest
    Quando Requisitar API PUT /usuarios    false
    Então o status code será    400
    E a API deverá apresentar a mensagem     ${CAMPO_NOME}    ${MSG_NOME_OBRIGATORIO}

CT04: Atualiza um usuário sem o parâmetro de e-mail
    [Documentation]    Validação do comportamento ao requisitar API de edição de usuário sem parâmetro de e-mail
    [Tags]    API_S03CT04    negative
    Dado que possuo uma sessão na API ServeRest
    Quando Requisitar API PUT /usuarios    true
    Então o status code será    400
    E a API deverá apresentar a mensagem    ${CAMPO_EMAIL}    ${MSG_EMAIL_OBRIGATORIO}

CT05: Atualiza um usuário sem o parâmetro de password
    [Documentation]    Validação do comportamento ao requisitar API de edição de usuário sem parâmetro de password
    [Tags]    API_S03CT05    negative
    Dado que possuo uma sessão na API ServeRest
    Quando Requisitar API PUT /usuarios    false
    Então o status code será    400
    E a API deverá apresentar a mensagem    ${CAMPO_PWD}    ${MSG_SENHA_OBRIGATORIO}

CT06: Atualiza um usuário sem o parâmetro de administrador
    [Documentation]    Validação do comportamento ao requisitar API de edição de usuário sem parâmetro de adm
    [Tags]    API_S03CT06    negative
    Dado que possuo uma sessão na API ServeRest
    Quando Requisitar API PUT /usuarios    false
    Então o status code será    400
    E a API deverá apresentar a mensagem    ${CAMPO_ADM}    ${MSG_ADM_OBRIGATORIO}

CT07: Atualiza todos os dados de um usuário cadastrado
    [Documentation]    Validação do requisição API de edição de usuário com parâmetro ADM vazio
    [Tags]   API_S03CT07    negative
    Dado que possuo uma sessão na API ServeRest
    Quando Requisitar API PUT /usuarios    ${EMPTY}
    Então o status code será    400
    E a API deverá apresentar a mensagem    ${CAMPO_ADM}    ${MSG_ADM_EDIT_INV}
