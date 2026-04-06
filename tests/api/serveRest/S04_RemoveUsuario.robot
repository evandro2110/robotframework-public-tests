*** Settings ***
Documentation    Arquivo que contém os testes da API ServeRest - Delete /usuarios

# Hooks e Keywords Globais
Resource         ../../../resource/commons/api/commonsApiServeRest.resource
Resource         ../../../resource/api/serveRest/steps/removerUsuario.resource
Resource         ../../../resource/api/serveRest/steps/consultarUsuario.resource

Default Tags     delete    critical
Test Teardown    Delete All Sessions


*** Test Cases ***
CT01: Remove usuário - Sucesso
    [Documentation]    Validação do comportamento ao requisitar API de remoção de usuário
    [Setup]   Criar usuário para testes
    Dado que possuo uma sessão na API ServeRest
    Quando requisitar a API de remoção de usuário
    Então o status code será    200
    E deverá ser retornada a mensagem no response    ${CAMPO_MSG}    ${MSG_USUARIO_REMOVIDO}

CT02: Tentar remover usuário informando ID inexistente
    [Documentation]    Validação do comportamento ao requisitar API de remoção de usuário com ID inexistente
    Dado que possuo uma sessão na API ServeRest
    E possuo um ID de usuário inexistente
    Quando requisitar a API de remoção de usuário
    Então o status code será    200
    E deverá ser retornada a mensagem no response    ${CAMPO_MSG}    ${MSG_NENHUM_REG_REMOV}
