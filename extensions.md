
# RecordWildCards

```
data C = C {a :: Int, b :: Int, c :: Int, d :: Int}
f (C {a = 1, b = b, c = c, d = d}) = b + c + d
```

Record wildcard syntax permits a “..” in a record pattern, where each elided field f is replaced by the pattern f = f. For example, the above pattern can be written as

```
f (C {a = 1, ..}) = b + c + d
```

# NamedFieldPuns

When using records, it is common to write a pattern that binds a variable with the same name as a record field, such as:

```
data C = C {a :: Int}
f (C {a = a}) = a
```

Record punning permits the variable name to be elided, so one can simply write

```
f (C {a}) = a
```