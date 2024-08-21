# EDAN40/EDAF95 Exercises
> [!NOTE]
> I am currently lagging slightly behind, be patient as I go through the course work.

In this repo you will find solutions to the exercises given by the book Programming in Haskell Second Edition as part of the course literature* recommended by the course [EDAN40](https://cs.lth.se/edan40)** at Lunds Tekniska Högskola, as well as handpicked exercises from the lecturer and solutions for past exams. Some of these are common to the course [EDAF95](https://cs.lth.se/edaf95). Additionally, you will also find solutions to [H-99: Ninety-Nine Haskell Problems](https://wiki.haskell.org/H-99:_Ninety-Nine_Haskell_Problems), from the [Haskell wiki](https://wiki.haskell.org), as they were around August 2024 (specific dates given for each section), and some random experiments.

For the classes, under the folder [``exercises/malec``](exercises/malec), and the exams, under the folder [``exams``](exams), there are also solutions on the official page. For the 2020 exam specifically, I have also provided an exam file (extracted from the solutions file), as Malec did not provide one himself. Similarly, there might also be more information on those exercises under their original sources, as this years lecturer Jacek Malec based the exercises on a compilation of original sources, listed in the corresponding classes.

This is a complementary resource to my [Notion notes database](https://mikaelrr.notion.site/Delade-anteckningar-Hub-LTH-D-C-f2a47297b9b146dba372e02c4f789d55?pvs=4).

> [!NOTE]
> I will probably not go back and edit older assignments, unless I've made an error large enough or couldn't complete a task back when I did it. Feel free to contribute and fix errors.
> Note that no solutions to the assignments will be provided, for obvious reasons.

> ``*`` specifically referring to the book "Programming in Haskell" (second edition), written by Graham Hutton and published in 2016 - my copy was printed 2021. ISBN ``978-1-316-62622-1``. Find it cheapest by referring to a tool like ``bokfynd.se`` (unaffiliated, just like the site) - book entry [here](https://www.bokfynd.nu/9781316626221/programming-in-haskell/). It is possible that these exercises are compatible with the previous version, please let me know.

> ``**`` course instance given to D22, during spring 2024

---
## Usage
> [!TIP]
> Another way to use this repo is to create a fork or branch, then remove all my solutions (either all at once, or as you go). Then you'll be left with test cases that, as long as you preserve my naming conventions, can be used to test your solutions as you go. If you desire you can submit it to me, and I'll figure out a way to display both mine and your solutions (for example creating seperate folder structures)

### Load module
```console
ghci

GHCi, version 9.2.8: https://www.haskell.org/ghc/  :? for help
ghci > :l file.hs
```
Sometimes you may have to use ``stack ghci`` in place of ``ghci``, for example when using installed packages.

After which you can run methods defined within the file.
### Testing
Some modules have tests included, usually the solutions for the book.

The modules are tested with HUnit, which you can find [here](https://hackage.haskell.org/package/HUnit). A guide can be found [here](https://wiki.haskell.org/HUnit_1.0_User%27s_Guide).
#### Stack
1. Install [Stack](https://docs.haskellstack.org/en/stable/), if not present
2. Run the following: in your terminal (not GHCi)
```console
stack install HUnit
```
> [!NOTE]
> You can probably use cabal, but I found Stack to be easier.
#### Executing tests
Tests are run by running 
```haskell
ghci> :l <testsmodule>
ghci> runTestTT <testlist>
```
In some cases I have also defined a main method, which allows you to run the lests like (or similar):
```haskell
ghci> :l <testsmodule>
ghci> main
```

Where ``<testsmodule>`` is the module containing the tests and ``<testlist>`` is any lists of tests currently loaded. I try to name them in UpperCamelCase and lowerCamelCase with the same name in general.

This should then return something like (if the tests pass):
```console
Cases: 4  Tried: 4  Errors: 0  Failures: 0
Counts {cases = 4, tried = 4, errors = 0, failures = 0}
```

> [!NOTE]
> Don't forget to reload (``:r`` in ghci) the test module in ghci when changing methods in the source file

---
## Contributing
Feel free to contribute small fixes or optimizations to any code. I will likely accept pull requests if they are limited in scope or if they provide solutions for exercises I have chosen not to do. Pull requests containing code that is vastly different from mine, using methods I don't understand or that are poorly documented will not be accepted. Similarly any type of plagiarism is not welcome.

Generally I try to stick to methods discussed in a module or chapter when solving the exercises for that module/chapter even if I have progressed further, as to not confuse others - please try to adhere to this as well :) For the same reason, I don't provide point free solutions for the book*.

---
> [!CAUTION]
> For possible copyright infringement reasons, I will not provide the actual exercise instructions from the book*, atleast not in entirety. You should own a legal copy of the book to use this repository.
---
Happy Haskell...ing? yeah :)
