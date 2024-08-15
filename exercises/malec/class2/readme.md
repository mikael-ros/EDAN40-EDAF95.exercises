# Class 2

## Propositional Logic
### 1
Like mentioned in the instructions, propositions can either be single variables, like ``p`` and ``q`` or a larger proposition. In addition, we have 3 operators AND, OR, and NOT.

Hence our data type will be roughly ``variable | and statement | or statement | not statement``

**See the type ``Proposition`` in [``ClassTwo.hs``](ClassTwo.hs)**

### 2
#### ``vars``
This function will have two cases really. If the current proposition is only a variable, we append the string, but otherwise we continue to recursively call it. I will, like Malec, define 4 cases since it is easier to work with here.

**See the function ``vars`` in [``ClassTwo.hs``](ClassTwo.hs)**
#### ``truthValue``
We essentially have to write a dictionary collector, where the variable is a key. It has to have 4 cases, for the different types, as we need to now compute the propositions. In some of the definitions we can avoid explicitly naming the states variable, as we can get by with composition. *(It is probably possible to go further, but not that immediately occured to me)*

**See the function ``truthValue`` in [``ClassTwo.hs``](ClassTwo.hs)**
### 3
For clarification, since I myself had to look it up due to forgetting, a tautology is a propositional formula that always holds true regardless of what the members values are, for example ``A || True`` will always be true, no matter what A is. Similarly the same would hold for ``A || !A``, since one of them will always be the opposite of false and hence true, making the formula true.

We can start by defining some base cases, like a proposition of a single variable - which will entirely depend on it and hence can't be a tautology.

For any other formula we have to assemble every combination, and check if all combinations evaluate to ``True``. Malec has chosen to do this by generating all value pairs of true and false, and creating tables from that to test with the ``truthValue`` function. This is equivalent to the cartesian product of all lists of all possible (2) combinations of each variable. This generates a structure like 
```haskell
    [
        [("variable", True), ("variable2", True)],
        [("variable", True), ("variable2", False)],
        [("variable", False), ("variable2", True)],
        [("variable", False), ("variable2", False)],
    ]
```
That is, a truth table (without the evaluations).

We can thereafter use the ``and`` function, which checks if every element of a list matches a predicate, to test whether the value of our proposition ``p`` is true in every combination of states - or equivalently if the whole column of evaluations would be true.

**See the function ``tautology`` and ``genTruthTable`` in [``ClassTwo.hs``](ClassTwo.hs)**

## File Systems
### 1