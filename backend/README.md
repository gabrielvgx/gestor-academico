### POST

<details>
  <summary>
    <code>POST</code>
    <code><b>/user</b></code>
  </summary>

#### Payload

> | name     | type     | data type | description                            |
> | -------- | -------- | --------- | -------------------------------------- |
> | email    | required | string    | E-mail do usuário                      |
> | userName | required | string    | Nome do usuário                        |
> | office   | required | string    | Cargo (PROFESSOR, SUPERVISOR, COZINHA) |

```json
{
  "email": "teste2@teste.com",
  "office": "PROFESSOR",
  "userName": "User Test"
}
```

#### Response

```json
{
  "message": "SUCCESS_CREATE_USER"
}
```

</details>

---

#### GET

<details>
  <summary>
    <code>GET</code>
    <code><b>/container/summary</b></code>
    <code>('stats' de todos os containers em servidores mapeados)</code>
  </summary>

##### Query Parameters

> | name     | type     | data type | description                                                                              |
> | -------- | -------- | --------- | ---------------------------------------------------------------------------------------- |
> | serverId | optional | string    | Nome do servidor a ser consultado, separado por vírgula em caso de múltiplos servidores. |

##### Responses

> | http code | content-type       | response                             |
> | --------- | ------------------ | ------------------------------------ |
> | `200`     | `application/json` | {"containers": [...], errors: [...]} |

</details>

---

#### PUT

<details>
  <summary>
    <code>PUT</code>
    <code><b>/container/start</b></code>
  </summary>

##### Parameters

> | name              | type     | data type    | description                  |
> | ----------------- | -------- | ------------ | ---------------------------- |
> | `stub_numeric_id` | required | int ($int64) | The specific stub numeric id |

##### Responses

> | http code | content-type               | response                                                     |
> | --------- | -------------------------- | ------------------------------------------------------------ |
> | `201`     | `text/plain;charset=UTF-8` | `Stub request index#<stub_numeric_id> updated successfully"` |
> | `400`     | `application/json`         | `{"code":"400","message":"Bad Request"}`                     |
> | `405`     | `text/html;charset=utf-8`  | None                                                         |

</details>

---

#### DELETE

<details>
  <summary><code>DELETE</code> <code><b>/container/:containerName</b></code></summary>

##### Parameters

> None

##### Responses

> | http code | content-type               | response                                             |
> | --------- | -------------------------- | ---------------------------------------------------- |
> | `200`     | `text/plain;charset=UTF-8` | `All in-memory YAML config was deleted successfully` |

</details>

---
