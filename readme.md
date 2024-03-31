# EDAN40/EDAF95 Exercises
In this repo you will find solutions to the exercises given by the book Programming in Haskell Second Edition as part of the course literature recommended by the course [EDAN40](https://cs.lth.se/edan40) at Lunds Tekniska Högskola, as well as handpicked exercises from the lecturer. Some of these are common to the course [EDAF95](https://cs.lth.se/edaf95). For the classes, under the folder ``malec``, theres also solutions on the official page.

This is a complementary resource to my [Notion notes database](https://mikaelrr.notion.site/Delade-anteckningar-Hub-LTH-D-C-f2a47297b9b146dba372e02c4f789d55?pvs=4).

> [!NOTE]
> I will probably not go back and edit older assignments, unless I've made an error large enough or couldn't complete a task back when I did it. Feel free to contribute and fix errors.
> Note that no solutions to the assignments will be provided, for obvious reasons.

---
## Usage
Most exercise solutions are written so they can be tested and used many ways. You can:
### Compile and execute
This will run the main method in each file.
```sh
ghc Exercise*.hs
./Exercise*
```
### Load module
```console
$ ghci

$ GHCi, version 9.2.8: https://www.haskell.org/ghc/  :? for help
$ ghci > :l file.hs
```
After which you can run methods defined within the file.
### Testing with HUnit
This is experimental, I still haven't gotten this to work. When it does, however, it should be possible to run the tests file with any of the prior methods.

---
> [!CAUTION]
> For possible copyright infringement reasons, I will not provide the actual exercise headings, atleast not in entirety. You should own a legal copy of the book to use this repository.
---
Happy Haskell...ing? yeah :)
