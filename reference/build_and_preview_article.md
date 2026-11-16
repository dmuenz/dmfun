# Build and preview an article for a pkgdown website

When writing an article or vignette for your pkgdown site, you may want
to quickly build and preview it. This function does both of those
things! It uses
[`pkgdown::build_article()`](https://pkgdown.r-lib.org/reference/build_articles.html)
and
[`pkgdown::preview_site()`](https://pkgdown.r-lib.org/reference/preview_site.html).
By default it works with the active file in your IDE (using the
rstudioapi package), so you don't need to pass any arguments.

## Usage

``` r
build_and_preview_article(name = NULL, ...)
```

## Arguments

- name:

  Name of article. This should be either a path relative to `⁠vignettes/`⁠
  *without extension*, or `index` or `README` or `NULL`. If `NULL` (the
  default), then the currently active article source file will be used.

- ...:

  Additional parameters passed to
  [`pkgdown::build_article()`](https://pkgdown.r-lib.org/reference/build_articles.html).

## Examples

``` r
if (FALSE) { # interactive()
build_and_preview_article()
}
```
