---
title: INSERT ... RETURNING
tags: database, potsgresql, sql, english
date: 2020-11-13
---

You can return any information about any inserted element in the `INSERT` statement by using the `RETURNING ...` clause

## Example

```sql
INSERT INTO roles (name)
VALUES ('master')
RETURNING role_id
```

So after `RETURNING` you choose all the columns you want to get

Very useful along [The WITH statement](The%20WITH%20statement.md) to chain a bunch of insertions atomically without using transactions

---

## What led to learning this

- Started using the SQL language in PostgreSQL. Working on a [tiny family project](https://github.com/taionca/taionca/)
