---
title: The WITH statement
tags: database, potsgresql, transaction, sql, english
date: 2020-11-13
---

Allows to save into variables tables results returned from a `SELECT` or [INSERT ... RETURNING](INSERT%20...%20RETURNING.md) statement, and use them in following querys.

Also allows to chain multiple `INSERTS`, and if any of them fails, all previous `INSERTS` are rolledback.\
*Note: autoincrements still increase on failures, hence skipped.*

So It's excellent to avoid explicitly using transactions

## Example

```sql
WITH inserted_user as (
    INSERT INTO users (username, name, password_hash)
    VALUES ('master', 'master', '$argon2i$v=19$m=4096,t=10,p=1$l9mKHF/++OJO4Fzj5VvOxw$smezKrrynx74W2+7L4zyiKUXWFdQDqdKf2RBMU4p0JI')
    RETURNING user_id
), inserted_role as (
    INSERT INTO roles (name)
    VALUES ('master')
    RETURNING role_id
), t as (
    INSERT INTO join_users_roles (user_id, role_id)
    SELECT user_id, role_id
    FROM inserted_user, inserted_role
)
INSERT INTO join_roles_permissions (role_id, permission_id)
SELECT role_id, permission_id FROM inserted_role, permissions;
```

## What led to learning this

- Needed to insert a bunch of data atomically accross many tables, see the [example](#example) above. Working on a [tiny family project](https://github.com/taionca/taionca/)
