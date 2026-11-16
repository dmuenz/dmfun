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

## Examples

``` r
# inspect `x` inside a function
my_sum <- function(x) {
  debug_print(x)
  sum(x, na.rm = TRUE)
}

my_sum(1:5)
#> ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾
#> Printing x
#>     from my_sum()
#> --------
#> [1] 1 2 3 4 5
#> ____________________
#> [1] 15

# debug_print also works out of a function
debug_print(1:5 + 6)
#> ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾
#> Printing 1:5 + 6
#>     from eval()
#> --------
#> [1]  7  8  9 10 11
#> ____________________
```
