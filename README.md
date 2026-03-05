# 🤖 robotframework-public-tests

Este repositório é um projeto completo de automação utilizando **Robot Framework**, cobrindo as três frentes: **Web, API e Mobile**.

## 🚀 Tecnologias e Bibliotecas
- **Robot Framework**: Core do projeto.
- **SeleniumLibrary**: Automação Web.
- **RequestsLibrary**: Testes de API REST com validação de JSON.
- **AppiumLibrary**: Automação Mobile (Android/iOS).

## 📂 Estrutura do Projeto
- `tests/api`: Validação de contratos e status codes.
- `tests/web`: Fluxos de interface seguindo Page Object Model (POM).
- `tests/mobile`: Testes de apps nativos/híbridos.

## 🛠️ Configurações de auditoria estática estão presentes no arquivo:
- `.robocop`
Para garantir a manutenibilidade e o Clean Code, este projeto utiliza o Robocop como linter estático. Para validar o projeto, execute:
- `robocop .`


## 🛠️ Como Executar

1. Instale as dependências:
   `pip install -r requirements.txt`

2. Execute os testes por Tag:
   - **API:** `robot -d ./logs -i api tests/`
   - **Web:** `robot -d ./logs -i web tests/`
   - **Mobile:** `robot -d ./logs -i mobile tests/`

3. Resultado final da última execução
![Robot Framework CI](https://github.com/evandro2110/robotframework-public-tests/actions/workflows/robot.yml/badge.svg)