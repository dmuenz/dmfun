# Draw a gtable object, labeling and putting borders around grobs

Draws a [gtable](https://gtable.r-lib.org/reference/gtable-package.html)
object overlaid with the figure layout. I.e., by default, every non-zero
grob is labeled and given a rectangular border.

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

  Fill color for border rectangles.

- fontsize:

  Size for grob names.

- labels:

  Either `TRUE`/`FALSE` for whether to print the grob names, or a regex
  such that only grob names matching the regex will be printed.

- show_zeroGrobs:

  `TRUE`/`FALSE` for whether to show zeroGrobs.

## Details

For the border rectangles, the default fill color is semi-transparent,
so grobs in `x` are visible but a little faint; this makes the layout
info easier to read. Setting the fill to be fully opaque (e.g.,
`fill = "white"`) would make the layout info even easier to see, but
then the grobs in `x` will be totally hidden. And setting the fill be
fully transparent (i.e., `fill = NA`) would fully show the grobs in `x`
but potentially make the layout info hard to see.

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
