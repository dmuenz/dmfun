# Print a gtable object as a tibble

Prints a
[gtable](https://gtable.r-lib.org/reference/gtable-package.html) object
in an easier-to-read format compared to the [default gtable print
method](https://gtable.r-lib.org/reference/print.gtable.html). There are
also extra options for conveniently subsetting the printed gtable.

## Usage

``` r
gtable_print(x, zsort = FALSE, show_zeroGrobs = TRUE, filter = NULL)
```

## Arguments

- x:

  A `gtable` object, or an object coercible to a `gtable`, like a
  `ggplot` or `patchwork` object.

- zsort:

  Sort by z values? Default `FALSE`.

- show_zeroGrobs:

  `TRUE`/`FALSE` for whether to show zeroGrobs.

- filter:

  If a character vector of regexes, only grob names matching at least
  one regex will be printed. If `NULL` (the default), no filtering by
  grob name.

## Details

`gtable_print()` prints a gtable's layout using a custom tibble
subclass, allowing for some parts of a standard printed tibble to be
hidden, like the `"# A tibble..."` header line and the row of column
types.

The `cells` column in the output is slightly different than the `cells`
column in the default gtable print method. Specifically,
`gtable_print()` simplifies `cells` in cases where a grob sits in only
one row or one column. E.g., if a grob is just in row 3 and column 2,
then the default method would print `"(3-3, 2-2)"`, while
`gtable_print()` prints `"(3, 2)"`.

## See also

[`gtable_show_grobs()`](https://dmuenz.github.io/dmfun/reference/gtable_show_grobs.md)

## Examples

``` r
# Let's print the gtable of a ggplot object. For comparison we'll use both
# the default method and gtable_print().
library(ggplot2)
p <- ggplot(mtcars, aes(hp, mpg))

# Convert p to a gtable and print with the default printing method. Note that
# the "grob" column may get separated from the rest of the table, depending
# on the console width. That makes it hard to read.
gtable::as.gtable(p)
#> TableGrob (16 x 13) "layout": 22 grobs
#>     z         cells             name
#> 1   0 ( 1-16, 1-13)       background
#> 2   5 ( 8- 8, 6- 6)           spacer
#> 3   7 ( 9- 9, 6- 6)           axis-l
#> 4   3 (10-10, 6- 6)           spacer
#> 5   6 ( 8- 8, 7- 7)           axis-t
#> 6   1 ( 9- 9, 7- 7)            panel
#> 7   9 (10-10, 7- 7)           axis-b
#> 8   4 ( 8- 8, 8- 8)           spacer
#> 9   8 ( 9- 9, 8- 8)           axis-r
#> 10  2 (10-10, 8- 8)           spacer
#> 11 10 ( 7- 7, 7- 7)           xlab-t
#> 12 11 (11-11, 7- 7)           xlab-b
#> 13 12 ( 9- 9, 5- 5)           ylab-l
#> 14 13 ( 9- 9, 9- 9)           ylab-r
#> 15 14 ( 9- 9,11-11)  guide-box-right
#> 16 15 ( 9- 9, 3- 3)   guide-box-left
#> 17 16 (13-13, 7- 7) guide-box-bottom
#> 18 17 ( 5- 5, 7- 7)    guide-box-top
#> 19 18 ( 9- 9, 7- 7) guide-box-inside
#> 20 19 ( 4- 4, 7- 7)         subtitle
#> 21 20 ( 3- 3, 7- 7)            title
#> 22 21 (14-14, 7- 7)          caption
#>                                            grob
#> 1                rect[plot.background..rect.37]
#> 2                                zeroGrob[NULL]
#> 3            absoluteGrob[GRID.absoluteGrob.25]
#> 4                                zeroGrob[NULL]
#> 5                                zeroGrob[NULL]
#> 6                       gTree[panel-1.gTree.16]
#> 7            absoluteGrob[GRID.absoluteGrob.21]
#> 8                                zeroGrob[NULL]
#> 9                                zeroGrob[NULL]
#> 10                               zeroGrob[NULL]
#> 11                               zeroGrob[NULL]
#> 12 titleGrob[axis.title.x.bottom..titleGrob.29]
#> 13   titleGrob[axis.title.y.left..titleGrob.32]
#> 14                               zeroGrob[NULL]
#> 15                               zeroGrob[NULL]
#> 16                               zeroGrob[NULL]
#> 17                               zeroGrob[NULL]
#> 18                               zeroGrob[NULL]
#> 19                               zeroGrob[NULL]
#> 20         zeroGrob[plot.subtitle..zeroGrob.34]
#> 21            zeroGrob[plot.title..zeroGrob.33]
#> 22          zeroGrob[plot.caption..zeroGrob.35]

# Better printing with gtable_print() -- the columns all stay together, with
# wide columns (e.g., "grob") getting abbreviated if needed. Note that
# gtable_print() handles the conversion of p to a gtable automatically.
gtable_print(p)
#> TableGrob (16 x 13) "layout": 22 grobs
#> id  z cells        name             grob                                       
#>  1  0 (1-16, 1-13) background       rect[plot.background..rect.72]             
#>  2  5 (   8,    6) spacer           zeroGrob[NULL]                             
#>  3  7 (   9,    6) axis-l           absoluteGrob[GRID.absoluteGrob.61]         
#>  4  3 (  10,    6) spacer           zeroGrob[NULL]                             
#>  5  6 (   8,    7) axis-t           zeroGrob[NULL]                             
#>  6  1 (   9,    7) panel            gTree[panel-1.gTree.53]                    
#>  7  9 (  10,    7) axis-b           absoluteGrob[GRID.absoluteGrob.57]         
#>  8  4 (   8,    8) spacer           zeroGrob[NULL]                             
#>  9  8 (   9,    8) axis-r           zeroGrob[NULL]                             
#> 10  2 (  10,    8) spacer           zeroGrob[NULL]                             
#> 11 10 (   7,    7) xlab-t           zeroGrob[NULL]                             
#> 12 11 (  11,    7) xlab-b           titleGrob[axis.title.x.bottom..titleGrob.6…
#> 13 12 (   9,    5) ylab-l           titleGrob[axis.title.y.left..titleGrob.67] 
#> 14 13 (   9,    9) ylab-r           zeroGrob[NULL]                             
#> 15 14 (   9,   11) guide-box-right  zeroGrob[NULL]                             
#> 16 15 (   9,    3) guide-box-left   zeroGrob[NULL]                             
#> 17 16 (  13,    7) guide-box-bottom zeroGrob[NULL]                             
#> 18 17 (   5,    7) guide-box-top    zeroGrob[NULL]                             
#> 19 18 (   9,    7) guide-box-inside zeroGrob[NULL]                             
#> 20 19 (   4,    7) subtitle         zeroGrob[plot.subtitle..zeroGrob.69]       
#> 21 20 (   3,    7) title            zeroGrob[plot.title..zeroGrob.68]          
#> 22 21 (  14,    7) caption          zeroGrob[plot.caption..zeroGrob.70]        
```
