# Draw a gtable object, labeling and putting borders around grobs

Draws a [gtable](https://gtable.r-lib.org/reference/gtable-package.html)
object overlaid with the figure layout. I.e., by every non-zero grob is
labeled and given a border.

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

  A `gtable` object, or an object coercible to a `gtable`, like a
  `ggplot` or `patchwork` object.

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

## Examples

``` r
library(ggplot2)
p <- ggplot(mtcars, aes(hp, mpg)) +
  geom_point()

# show the plot
p


# show the plot overlaid with the plot layout
gtable_show_grobs(p)
```
