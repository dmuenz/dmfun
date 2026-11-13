# Simplify a lintr object for easy printing

Converts the output of
[`lintr::lint_package()`](https://lintr.r-lib.org/reference/lint.html)
into a data frame with only a few key columns.

## Usage

``` r
lint_simplify(lint)
```

## Arguments

- lint:

  A lint object returned by the lintr package.

## Value

A data frame of lintr findings, with columns `#`, `filename`, `line`,
and `col`.

## See also

[`lint_package_to_md()`](https://dmuenz.github.io/dmfun/reference/lint_package_to_md.md)

## Examples

``` r
if (FALSE) { # interactive()
lint <- lintr::lint_package()
lint_simplify(lint)
}
```
