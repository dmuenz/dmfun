# Print an object for debugging

The name/call of the object, along with the name of the function from
which `debug_print` is called, are also printed. The whole thing is
surrounded by horizontal lines. This may be useful for debugging.

## Usage

``` r
debug_print(x, note = NULL)
```

## Arguments

- x:

  An object to print.

- note:

  An optional string to be printed, useful for giving more context.

## Value

Invisibly returns `x`.
