---
tags: english, idea
date: 2022-05-17
---

# Descentralized database (social consensus)

1- Append-only?, full history of operations. Deletes / edits do not remove data, they only modify the "active state"

2- Agents are public keys or similar (DIDs?)

3- Operations are signed, and receivers verify if operation is valid, and sender is allowed

4- Operations form a Merkel-DAG (similar to git, they link to the tips of current "active state", like a commit/merge in git)

So far I think I've basically described [OrbitDB](https://github.com/orbitdb/orbit-db)

Consensus is where things get real hard, [OrbitDb seems to use a last-write-wins CRDT](https://news.ycombinator.com/item?id=22920204), and although I don't know the details of orbitDb, I think for many simple use-cases, conflicts can just be resolved on the social layer. But I think we need to provide agents with good tools to resolve conflicts

I'll try my best here with some ideas:

- When merging, we can order operations by their timestamp, if operations enter conflict, raise it to the conflicting agents, or someone with permission to solve them.

If an agent makes public an operation that forks its own history, mark agent as malicious or compromised, alert other agents, this needs resolution on the social layer, you have proof of misconduct, an agent has signed diverging operations

Any operation becomes fully settled if you have proof that all agents of your system have referenced it directly or indirectly through newer operations.

Timestamps can be upgraded by using @opentimestamps to get proof that an operation existed at time X (prevents creation of operations in hindsight). Though this does not prove operation has been made public

## More Up-to-date ideas

- [Local-first software](https://www.inkandswitch.com/local-first.html)
- [Riffle](https://riffle.systems/)
- [ElectricSQL](https://electric-sql.com/)
- localfirst.fm: #10 – Matt Wonlaw: cr-sqlite, syncing strategies and incremental view maintenance \
    Starting from: 00:53:20 \
    Episode webpage: https://localfirst.fm/10 \
    Media file: https://media.transistor.fm/dce148a6/f3921284.mp3#t=3200
