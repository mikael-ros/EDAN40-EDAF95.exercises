# H-99 questions 46-50 :: "Logic and codes"
_as they were on the 19th of August 2024_

## 46
Let's start with all the predicates. I'll reduce them as I go along. I'll write both versions defined with operators and ones made with pattern matching.

### and
```haskell
and2 a b = a && b
and2 = \a b -> (&&) a b -- move operators leftward and arguments rightward
and2 = (&&) -- remove both arguments
```
We can also define a patternmatched version like:
```haskell
and2' True b = b -- If first is True, b completely steers the result
and2' False _ = False -- If first is false, it doesn't matter what b is, it will be false
```

### or
Can simply be defined yet again as the operator ``(||)``, or:
```haskell
or2' True _ = True -- If first is true it will be true
or2' False b = b -- If first is false, then the value is determined by b
```

### nand
As simple as ``(not .) . and2``, or:
```haskell
nand2' True b = not b
nand2' False _ = True
```

### nor
As simple as ``(not .) . or2``, or:
```haskell
nor2' True _ = False
nor2' False b = not b
```

### xor
A XOR gate is only true if neither value is the same. We have a couple options:
- False when a == b, True when a /= b
- "Build" a XOR gate with NOR and AND, see figure
- Pattern matching

![XOR gate using AND and NOR gates](https://i.sstatic.net/tL4Z5.png)

Option one will yield the basic ``xor2 = (/=)``, and option 2 will yield:
```haskell
xor2' a b = nor2 (nor2 a b) (and2 a b)
```
option 3 yields:
```haskell
xor2'' True b = not b -- When the first value is True, the value is determined solely by the second, which will yield True when False, hence not b
xor2'' a False = a -- Same as below, but flipped
xor2'' False b = b -- If first value is false, then it is entirely determined by b
```

### impl
I don't understand this operator very well, but here is it's truth table, so let's just go off that...

|a|b|a -> b|
|-|-|------|
|T|T|   T  |
|T|F|   F  |
|F|T|   T  |
|F|F|   T  |

I'll only be defining a pattern matched version.

### equ
This truth table makes more sense to me, I immediately see that we're essentially just going to need to define it as ``(==)``, but I'll also define the pattern matched version.

|a|b|a -> b|
|-|-|------|
|T|T|   T  |
|T|F|   F  |
|F|T|   F  |
|F|F|   T  |

```haskell
equ2' True b = b
equ2' a False = not a
equ2' False b = not b
```

### Truth table
To generate our values for the variables, we simply need to get the cartesian product of ``[True, False]`` with itself, which is easily done with a list comprehension like ``[(a,b) | a <- bools, b <- bools]``, where ``bools`` is the mentioned tuple (array in this case). To get the computations of each pair we then need to ``map`` the given logical expression over this generated list.

Finally, if we want to present it like given we need to generate a string somehow, or print as we go along. I think it'll be easier to prepare things step by step than make a massive function.

Install the ``lens`` package using:
```console
stack install lens
```

Then finally we get the result desired by using ``printTable2 <expression>``, where ``<expression>`` is a logical expression or function.

That took way too long...

**See the relevant functions in [``LogicAndCodes.hs``](LogicAndCodes.hs)**

## 47
I'll use the solution from the wiki, as I had no idea how to do this with precedence nor what Java's precedences were. I'll however define some operators instead of just using the function names. I'll use ``/\`` for AND and ``\/`` for OR.

**See the operators ``(/\)`` and ``(\/)`` in [``LogicAndCodes.hs``](LogicAndCodes.hs)**

## 48
### Operators
Again, I'll use the precedences given in the wiki, but define some sensible operators.

| Operator | Function |
|----------|----------|
| %        | XOR      |
| !\\/     | NOR      |
| !/\      | NAND     |
| ===      | EQU      |
| ==>      | IMPL     |

### Generalizing the table
I'm skipping this as it's just honestly too much work, and it isn't fun.

**See the relevant operators and functions in [``LogicAndCodes.hs``](LogicAndCodes.hs)**

## 49
Since I don't understand gray coding intuitively, I ended up having to use the solution from the wiki...

**See the function ``gray`` in [``LogicAndCodes.hs``](LogicAndCodes.hs)**

## 50
Skipping this since I don't have time.