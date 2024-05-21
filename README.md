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
