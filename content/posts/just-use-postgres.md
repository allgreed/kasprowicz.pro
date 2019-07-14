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
- TODO: can I tag #macielbl?

### PoC
- table with key and value (both strings)
- tiny wrapper to get a convinient API
- only thing that could be thought of as "hard" was error handling and programtiaclly doing an upsert
- 3h of casual development to get it to work => 100 lines of working code
- commit hash dfcaf09b1eb10013bd55646091be080df5d45e72

### Cleaning it up + adding some test (think of different heading)
- additional x h of work
- can be safely used in a startup / whatever

### Gettin' prodish!
- all the optimizations listed in notes

### Benchmark
- benchmark with Redis
    - lots of writes
    - lots of reads
    - overwrite
