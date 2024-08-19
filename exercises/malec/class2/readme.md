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
A file could be defined as having a name, and containing another file or a directory. In our case this is best defined as either being a ``File`` containing a ``String`` (name) or a ``Directory`` containing a ``String`` (name). A directory could itself be a synonym for a list of files ``[File]``.

A file system is for me seen as a root file that we navigate from.

**See the types ``File`` and ``Directory`` in [``ClassTwo.hs``](ClassTwo.hs)**

### 2
Theres perhaps two approaches to this. Either we do some form of BFS or DFS algorithm with backtracking, or we simply create a function that generates all paths to all files, and simply searches for any path where ``x`` is at the end.

I will be implementing something akin to BFS, maybe actually BFS (honestly not sure and don't care about proving). I will be searching each layer for the file, returning ``Nothing`` when the file doesn't match and ``Just path`` when it finds it. Each recursive step attaches one new layer to the array of filenames (called a path). This doesn't return a string like file/file2/file3, but an array of strings ``["file", "file2", "file3"]`` that could be turned into the desired path string with some other function.

**See the functions ``search`` and ``printPath`` in [``ClassTwo.hs``](ClassTwo.hs)**

## Sets
### 1
We'll use a list internally as suggested. 

#### Empty set
We'll just create a ``Set`` with the empty list ``[]``.

#### Creating sets
I assume they mean creating ones from a list, since we already have the empty set constructor. To adhere to set rules, we have to just remove the duplicates from the list, and pass that onto the constructor.