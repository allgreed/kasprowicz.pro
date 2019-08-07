+++
description = ""
Fri 12 Jul 22:07:23 CEST 2019
draft = true
+++

## Just use Postgres

- trouble setting up Redis
- isn't SQL outdated?
- it's gonna need to be fast. Like 1m writes / second? I don't now - fast!
- I said if you're not sure about a DB just use Postgres, whatever
- you're not sure about a DB unless you've read [Designing Data-Intensive Applications by Martin Kleppmann](https://dataintensive.net/) - inb4 [listening to some random guy on a blog](https://christine.website/blog/experimental-rilkef-2018-11-30)
- TODO: can I tag #macielbl?

### PoC
- table with key and value (both strings)
- tiny wrapper to get a convinient API
- only thing that could be thought of as "hard" was error handling and programtiaclly doing an upsert
- 3h of casual development to get it to work => 100 lines of working code
- commit hash dfcaf09b1eb10013bd55646091be080df5d45e72

### Cleaning it up + adding some test (think of different heading)
- e62c59a07b5380abbafada910d7d52f2a3f4e4dc
- additional 1 h of work to clean the error handling

- b0d7fafa39b3cd67715ee217bd1e8c1fa2dafbf6
- additional 1 h of work to extract queries + prevent SQL injections

- ffe0d832b5d939070793b172aa7cc99b51333548
- additional 30 min of work to make the values JSONB and add delete

- 28614a320add632209a0494d3402273b90a1454c
- additional 30 min of work to allow different kv stores to coexist

- 2.5h to setup some basic property based testing
- dc9d4fb490d00cfeff2951a2214c1538183f89d9
- 0bbb4464a1ed1f62537927f57fdd83cd30d2a4d3

- total: 5.5h of work - can be "safely" used in a startup / whatever (as long as your objects are can be losslessly marshalled) and was tons of fun

### Let test cases hit the code!
- oracles are cool!

- x h to add statefull testing

- what issues were detected
    - "\\" in a string
    - the queries were not populated with custom table name properly

### Digresion: using JS on the server side is fascinating
- 2h to fight with JS quircks
    - weird JS values (like -0)
    - turns out it was unnecessary
    - but still can occur in production and cause tons of fascination
    - is it a good idea to let this kind of stuff near things like auth and payment? :D

### Gettin' prodish!
- npm package, readme, types, etc

### Benchmark
- benchmark with Redis
    - lots of writes
    - lots of reads
    - overwrite

### It goes up to 11
- all the optimizations listed in notes

