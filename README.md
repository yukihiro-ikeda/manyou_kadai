| User            |            |
|-----------------|------------|
| カラム          | データ型   |
| user_id         | string     |
| name            | string     |
| email           | string     |
| password_digest | string     |
|                 |            |
| Task            |            |
| カラム          | データ型   |
| task_id         | string     |
| user_id         | references |
| name            | string     |
| detail          | string     |
| priority        | integer    |
| limit           | date       |
|                 |            |
| Label           |            |
| カラム          | データ型   |
| label_id        | string     |
| user_id         | references |
| task_id         | references |