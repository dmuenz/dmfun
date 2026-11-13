# Lint a package and write findings to Markdown

Run
[`lintr::lint_package()`](https://lintr.r-lib.org/reference/lint.html)
and save the findings in a Markdown file named `lint-package.md` in the
package's root directory.

## Usage

``` r
lint_package_to_md(path = ".", ...)
```

## Arguments

- path:

  Path to the top-level directory of the source package.

- ...:

  Additional arguments passed to
  [`lintr::lint_package()`](https://lintr.r-lib.org/reference/lint.html).

## Details

You should add `^lint-package\\.md$` to `.Rbuildignore`. And you might
want to add `lint-package.md` to `.gitignore`.

## See also

[`lint_simplify()`](https://dmuenz.github.io/dmfun/reference/lint_simplify.md)

## Examples

``` r
if (FALSE) { # interactive()
lint_package_to_md()
}
```
