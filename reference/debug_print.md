# Print an object for debugging

Prints an object's expression, the call stack from which `debug_print`
is called, and the evaluated result of the expression. The whole thing
is surrounded by horizontal lines. This may be useful for simple
debugging.

## Usage

``` r
debug_print(x, note = NULL)
```

## Arguments

- x:

  An object to print.

- note:

  An optional string (or something coercible to a string) to be printed.
  Useful for giving more context.

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

# inspect `x_i` inside a nested function
sum_of_means <- function(...) {
  sum(
    sapply(list(...), \(x_i) {
      debug_print(x_i)
      mean(x_i)
    }),
    na.rm = TRUE
  )
}

sum_of_means(1:3, 4:6)
#> ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾
#> Printing x_i
#>     from sum_of_means() -> sapply()
#> --------
#> [1] 1 2 3
#> ____________________
#> ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾
#> Printing x_i
#>     from sum_of_means() -> sapply()
#> --------
#> [1] 4 5 6
#> ____________________
#> [1] 7

# debug_print also works outside of a function
debug_print(1:5 + 6)
#> ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾
#> Printing 1:5 + 6
#> --------
#> [1]  7  8  9 10 11
#> ____________________
```
