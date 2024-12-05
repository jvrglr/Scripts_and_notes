### Clear definitions:
```
Clear["Global`*"]
```
### Plot
```
Manipulate[Plot[x*x0+x1, {x, 0, 1}], {x1, 0, 1}, {x0, 0, 1}]
```
### Symbolize
why and how to use symbolize to define variables with subscript: https://support.wolfram.com/43606?src=mathematica

### Pure functions
Replace functions by a variable/functions.
Example: Replace function f[t] by a sum of a variable (v) and another function (g) of t
```
f -> (v + g[#1] &)
```
Example: Replace a function R1[t] by a variable with the same name
```
R1 -> (R1 &)
```
