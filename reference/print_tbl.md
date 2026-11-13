# Print a tibble with additional display options

Prints a
[tibble](https://tibble.tidyverse.org/reference/tibble-package.html)
with optional control over the column type row, row IDs, and tibble
header. Apart from these display options, normal tibble printing
behavior is preserved.

## Usage

``` r
print_tbl(x, ..., show_types = TRUE, show_rowid = TRUE, show_header = TRUE)
```

## Arguments

- x:

  A tibble, or an object coercible to a tibble, like a data frame.

- ...:

  Additional arguments passed to the [default tibble print
  method](https://tibble.tidyverse.org/reference/formatting.html), such
  as `n` and `width`.

- show_types:

  `TRUE`/`FALSE`, whether to show a row of column types, such as `<chr>`
  and `<dbl>`.

- show_rowid:

  `TRUE`/`FALSE`, whether to show a column of row ID numbers.

- show_header:

  `TRUE`/`FALSE`, whether to show a tibble header, such as "# A tibble:
  10 x 3".

## Value

Invisibly returns `x`.

## Examples

``` r
x <- tibble::tibble(name = c("Alice", "Bob"), age = c(30, 40))
print_tbl(x) # normal tibble printing
#> # A tibble: 2 × 2
#>   name    age
#> * <chr> <dbl>
#> 1 Alice    30
#> 2 Bob      40
print_tbl(x, show_types = FALSE)  # drop the row of column types
#> # A tibble: 2 × 2
#>   name  age
#> 1 Alice  30
#> 2 Bob    40
print_tbl(x, show_rowid = FALSE)  # drop the column of row IDs
#> # A tibble: 2 × 2
#> name    age
#> <chr> <dbl>
#> Alice    30
#> Bob      40
print_tbl(x, show_header = FALSE) # drop the "# A tibble..." line
#>   name    age
#> * <chr> <dbl>
#> 1 Alice    30
#> 2 Bob      40
```
