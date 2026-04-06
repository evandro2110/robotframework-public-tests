# Documentação Técnica: Projeto de Automação de Testes (public-tests)

Esta documentação descreve o projeto **public-tests**, uma solução robusta de automação de testes cobrindo as frentes **Web, API e Mobile**, desenvolvida com foco em manutenibilidade e escalabilidade.

---

## 1. Visão Geral do Projeto

O propósito deste projeto é garantir a qualidade contínua de aplicações através de testes automatizados de ponta a ponta (E2E) e de integração de serviços. A automação foi construída utilizando o **Robot Framework** como core, aproveitando a sintaxe baseada em palavras-chave (Keywords) para tornar os testes legíveis tanto para técnicos quanto para stakeholders.

---

## 2. Arquitetura e Estrutura

O projeto segue uma estrutura organizada para separar responsabilidades entre casos de teste, recursos e dados.

*   **`tests/`**: Contém as suítes de testes propriamente ditas.
    *   `api/`: Testes de contrato, status codes e lógica de negócio de endpoints.
    *   `web/`: Fluxos de interface seguindo o padrão **Page Object Model (POM)**.
    *   `mobile/`: Testes para aplicações nativas e híbridas.
*   **`resource/`**: Local onde residem as Keywords personalizadas e variáveis.
    *   `commons/`: Keywords compartilhadas (ex: iniciar sessão API, finalizar teste web).
    *   `web/sauceDemo/page_object/`: Elementos da página (Locators).
    *   `api/serveRest/steps/`: Lógica de requisição para cada endpoint.
*   **`schemas/`**: Arquivos `.json` utilizados para validar a estrutura das respostas das APIs.
*   **`logs/`**: Diretório gerado automaticamente para armazenar relatórios e evidências (screenshots).

---

## 3. Suítes de Testes (Test Cases)

### Automação de API (ServeRest)
Os testes de API focam na validação de endpoints de usuários, cobrindo métodos POST, GET e PUT.

| Endpoint | Método | Descrição do Fluxo |
| :--- | :--- | :--- |
| `/usuarios` | POST | Cadastro com sucesso (admin/comum), validação de campos obrigatórios e e-mail duplicado. |
| `/usuarios` | GET | Listagem geral, busca por filtros (ID, nome, e-mail) e validação de usuários inexistentes. |
| `/usuarios/{id}`| PUT | Edição de dados do usuário, validação de e-mail inválido e campos obrigatórios na atualização. |
| `/login` | POST | Validação de credenciais e armazenamento de token de autenticação. |

### Automação Web (Sauce Demo)
Os testes Web cobrem o fluxo principal de e-commerce na plataforma Sauce Demo.

| Página | Ações Testadas |
| :--- | :--- |
| **Login** | Acesso com usuário válido, tentativa de login inválido e validação de mensagens de erro. |
| **Home Page** | Ordenação de produtos por nome (A-Z, Z-A) e por preço (maior/menor). |
| **Carrinho** | Adição de produtos aleatórios, remoção de itens e persistência da quantidade no ícone do carrinho. |
| **Checkout** | Validação de campos obrigatórios, cálculo de preço final e finalização da compra com sucesso. |

---

## 4. Dicionário de Keywords

As Keywords foram criadas para abstrair a complexidade do código e permitir o reuso.

| Keyword | Origem | Descrição |
| :--- | :--- | :--- |
| `Abrir Navegador` | Common Web | Inicializa o browser configurando opções como o modo Headless. |
| `Iniciar sessão API ServeRest` | Common API | Configura a URL base e headers para as requisições REST. |
| `Preencher campo e valor` | Web Steps | Keyword genérica que aguarda o elemento ficar visível, clica e insere o texto. |
| `Validar schema de usuário...`| API Steps | Utiliza o `JsonValidator` para comparar o response da API com o contrato definido em `.json`. |
| `Gerar First Name...` | Faker Data | Gera dados randômicos via FakerLibrary para preenchimento de formulários. |
| `Finalizar Teste` | Web Hook | Teardown que fecha o navegador e captura screenshot em caso de falha. |

---

### Relatórios
Após a execução, os resultados (log.html e report.html) estarão disponíveis na pasta `./logs`. Para visualizar o relatório avançado, utilize o Allure descrito melhor dentro do arquivo README.md

---

## Conclusão

O projeto apresenta uma **cobertura abrangente**, desde validações de baixo nível (contratos de API e status codes) até fluxos críticos de negócio na interface Web (checkout e login). A arquitetura modular permite que novas funcionalidades sejam adicionadas rapidamente, enquanto a integração com ferramentas de análise estática e geração de dados dinâmicos garante a confiabilidade da suíte de testes.