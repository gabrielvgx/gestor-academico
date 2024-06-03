# Gestor Acadêmico

### Ambiente (Pré Requisitos)

- PHP 8.2
- npm (>= 10.2.3)
- node (>= v18.19.0)

#### Banco de Dados

- MySql >= 8.0.36

#### Executando o projeto

- frontend
  - Criar arquivo .env baseado no arquivo .env.example
  - Rodar o seguinte comando:
  ```sh
  npm run dev
  ```

* backend

  - Criar arquivo .env baseado no arquivo .env.example
  - Executar o seguinte comando:

  ```sh
  composer install
  ```

#### Notificações do sistema

STATUS (PLANEJAMENTO) / NRREVIEW

- APROVADO
- REJEITADO
- PENDENTE

SUPERVISOR -> Planejamentos não analisados
SUPERVISOR -> Requisição de material não analisada
TEACHER -> Planejamentos não enviados (analisando parametrizacao de dias anteriores ao plano)
TEACHER -> Planejamentos com modificação no status
TEACHER -> Materiais aprovados / rejeitados

### EndPoints

- Todas as rotas de backend possuem validação em middleware de JWT, exceto a
  rotina de login (/auth) utilizada para gerar o token de autenticação

<details>
  <summary>
    <code>POST</code>
    <code><b>/auth</b></code>
    <code>(Autenticar usuário na plataforma)</code>
  </summary>

##### Payload

```json
{
  "email": "example@example.com",
  "password": "password"
}
```

</details>

---

<details>
  <summary>
    <code>POST</code>
    <code><b>/user</b></code>
    <code>(criar usuário)</code>
  </summary>

##### Payload

```json
{
  "userName": "Username",
  "office": "TEACHER|SUPERVISOR|KITCHEN",
  "email": "example@example.como"
}
```

</details>

### Gráficos:

- Histórico de Desperdício (bar-chart) (prototipado)
  https://echarts.apache.org/examples/en/editor.html?c=bar1

- Materiais mais solicitados (bar-chart)
  https://echarts.apache.org/examples/en/editor.html?c=data-transform-sort-bar

- Meses com mais solicitação de materiais
  https://echarts.apache.org/examples/en/editor.html?c=bar1

- Entrega de Planos escolares (prototipado)
  - Entregue no prazo
  - Entregue atrasado
  - Não entreguee
    https://echarts.apache.org/examples/en/editor.html?c=pie-simple
- Análise por usuário (histórico de entregas)
- Análise por usuário (histórico de solicitação de materiais)

Images:
https://www.freepik.com/free-photo/school-supplies-top-view-background-chalkboard-free-space_9416293.htm#fromView=search&page=6&position=30&uuid=023f39b0-1fab-48db-9771-8bda201118bc

https://www.freepik.com/free-ai-image/school-supply-green-chalkboard-copy-space-background_126532741.htm#fromView=search&page=2&position=48&uuid=023f39b0-1fab-48db-9771-8bda201118bc

https://www.freepik.com/free-photo/healthy-school-lunch-box-with-beef-sandwich-fresh-vegetables-bottle-water-fruits-blue-table-top-view-flat-lay_7380127.htm#fromView=search&page=1&position=14&uuid=90473e97-0ddd-4907-b137-42bed49bffdd
