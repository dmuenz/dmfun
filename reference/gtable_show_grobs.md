# Draw a gtable, labeling and putting a border around every non-zero grob

Draw a gtable, labeling and putting a border around every non-zero grob

## Usage

``` r
gtable_show_grobs(
  x,
  color = "red",
  fill = "#80FFFF66",
  fontsize = 12,
  labels = TRUE,
  show_zeroGrobs = FALSE
)
```

## Arguments

- x:

  A `gtable` object. Or a `ggplot` or `patchwork` object, which will be
  converted to a gtable, provided those packages are available.

- color:

  Color for grob names and border outlines.

- fill:

  Fill color for borders. Semi-transparent colors work well.

- fontsize:

  Size for grob names.

- labels:

  Either `TRUE`/`FALSE` for whether to print the grob names, or a regex
  such that only grob names matching the regex will be printed.

- show_zeroGrobs:

  `TRUE`/`FALSE` for whether to show zeroGrobs.

## See also

[`gtable_print()`](https://dmuenz.github.io/dmfun/reference/gtable_print.md)
