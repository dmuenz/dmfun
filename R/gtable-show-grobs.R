#' Draw a gtable, labeling and putting a border around every non-zero grob
#'
#' @param x A `gtable` object. Or a `ggplot` or `patchwork` object, which will
#'   be converted to a gtable, provided those packages are available.
#' @param color Color for grob names and border outlines.
#' @param fill Fill color for borders. Semi-transparent colors work well.
#' @param fontsize Size for grob names.
#' @param labels Either `TRUE`/`FALSE` for whether to print the grob names, or a
#' regex such that only grob names matching the regex will be printed.
#' @param show_zeroGrobs `TRUE`/`FALSE` for whether to show zeroGrobs.
#' @export
gtable_show_grobs <- function(x, color = "red", fill = "#80FFFF66",
                              fontsize = 12, labels = TRUE,
                              show_zeroGrobs = FALSE) {

  x <- gtable::as.gtable(x)

  layout <- x$layout
  n_grobs <- nrow(layout)

  if (n_grobs == 0) {
    cli::cli_alert_info("{.arg x} has no grobs so there is nothing to draw.")
    return(invisible(x))
  }

  layout$grob_id <- seq_len(n_grobs)
  layout <- layout[order(layout$z), ]

  z_max <- max(layout$z)

  make_range <- function(min, max) {
    if (min == max) paste(min)
    else paste0(min, "-", max)
  }

  for (i in seq_len(n_grobs)) {
    grid_id <- layout$grob_id[i]
    name <- layout$name[i]
    y_range <- make_range(layout$t[i], layout$b[i])
    x_range <- make_range(layout$l[i], layout$r[i])
    label <- paste0(name, " (", y_range, ", ", x_range, ")")

    if (!show_zeroGrobs && inherits(x$grobs[[grid_id]], "zeroGrob")) next

    x <- x |> gtable::gtable_add_grob(
      grobs = grid::rectGrob(gp = grid::gpar(col = color, fill = fill)),
      t = layout$t[i],
      l = layout$l[i],
      b = layout$b[i],
      r = layout$r[i],
      clip = "off",
      z = z_max + i,
      name = paste0(name, "-", "border")
    )
    if (isTRUE(labels) || (is.character(labels) && grepl(labels, name))) {
      rotate_regex <- "^(axis|ylab|strip)-[lr](-\\d+)*$|^ggaxt-ytab|^ggaxt-ylab"
      x <- x |> gtable::gtable_add_grob(
        grobs = grid::textGrob(
          label,
          rot = if (grepl(rotate_regex, name)) 90 else 0,
          gp = grid::gpar(col = color, fontsize = fontsize)
        ),
        t = layout$t[i],
        l = layout$l[i],
        b = layout$b[i],
        r = layout$r[i],
        clip = "off",
        z = z_max + n_grobs + i,
        name = paste0(name, "-", "label")
      )
    }
  }

  plot(x)
  invisible(x)
}
