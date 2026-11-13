# Build and preview an article for a pkgdown website

Build and preview an article for a pkgdown website

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
