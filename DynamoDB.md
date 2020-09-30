---
tags: knowledge, database, nosql
---

# DynamoDB

It's a [[NoSQL]] [[Database]] from [[AWS]]

## Differences from SQL Database

- Records of a table can have different fields
- Tables can be partitioned using **partition keys**, I think you cannot query *fast* across different partitions. I think an analogy to **partition keys** would be like having a table across multiple databases in [[SQL]] Databases
- Tables also have **sort keys**, this determines how records are ordered, and you can only query contiguous records, I think you cannot filter nor change the order (maybe only reverse the default order)
- So basically **partition keys** and **sort keys** determines how the table can be queried. This limitations is the tradeoff that makes [[DynamoDB]] fast.
- There are some advantages with the connection management, I think it allows a lot more concurrent connections, but I don't know the details.

## Use cases

- High scalability
- Better integration with serverless architecture, because of better connection management

## What led to learning this

- Podcast: [Full Stack Radio: 139: Alex DeBrie - DynamoDB for Relational Database Diehards](https://fullstackradio.com/episodes/139-20f6bb42)
