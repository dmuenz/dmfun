#' Draw a gtable object, labeling and putting borders around grobs
#'
#' Draws a [gtable][gtable::gtable-package] object overlaid with the figure
#' layout. I.e., by default, every non-zero grob is labeled and given a border.
#'
#' @param x A `gtable` object, or an object coercible to a `gtable`, like a
#'   `ggplot` or `patchwork` object.
#' @param color Color for grob names and border outlines.
#' @param fill Fill color for borders. Semi-transparent colors work well.
#' @param fontsize Size for grob names.
#' @param labels Either `TRUE`/`FALSE` for whether to print the grob names, or a
#' regex such that only grob names matching the regex will be printed.
#' @param show_zeroGrobs `TRUE`/`FALSE` for whether to show zeroGrobs.
#'
#' @seealso [gtable_print()]
#' @export
#' @examples
#' library(ggplot2)
#' p <- ggplot(mtcars, aes(hp, mpg)) +
#'   geom_point()
#'
#' # show the plot
#' p
#'
#' # show the plot overlaid with the plot layout
#' gtable_show_grobs(p)
gtable_show_grobs <- function(
  x,
  color = "red",
  fill = "#80FFFF66",
  fontsize = 12,
  labels = TRUE,
  show_zeroGrobs = FALSE
) {
  x <- gtable::as.gtable(x)

  check_color(color)
  check_color(fill)
  rlang::check_number_decimal(fontsize, min = 0, allow_infinite = FALSE)
  rlang::check_bool(show_zeroGrobs)
  if (!rlang::is_bool(labels) && !rlang::is_string(labels)) {
    rlang::stop_input_type(labels, "`TRUE` or `FALSE` or a regex string")
  }

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

  # Add grob borders and labels to the gtable
  for (i in seq_len(n_grobs)) {
    grid_id <- layout$grob_id[i]
    if (!show_zeroGrobs && inherits(x$grobs[[grid_id]], "zeroGrob")) next

    name <- layout$name[i]
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
      y_range <- make_range(layout$t[i], layout$b[i])
      x_range <- make_range(layout$l[i], layout$r[i])
      label <- paste0(name, " (", y_range, ", ", x_range, ")")

      x <- x |> gtable::gtable_add_grob(
        grobs = adaptive_text_grob(
          label,
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

# Create a grob that chooses horizontal or vertical text at draw time
adaptive_text_grob <- function(label, gp = grid::gpar()) {
  grid::grob(
    label = label,
    gp = gp,
    cl = "adaptive_text_grob"
  )
}

#' @exportS3Method grid::drawDetails
drawDetails.adaptive_text_grob <- function(x, recording = TRUE) {
  horizontal <- grid::textGrob(label = x$label, gp = x$gp)

  # Width & height of horizontal text
  text_w <- width2mm(grid::grobWidth(horizontal))
  text_h <- height2mm(grid::grobHeight(horizontal))

  # Available width & height for fitting the text. At draw time, "npc" reflects
  # the dimensions of the grob's actual gtable cell.
  vp_w <- width2mm(grid::unit(1, "npc"))
  vp_h <- height2mm(grid::unit(1, "npc"))

  # Does text fit horizontally?
  horizontal_fits <- text_w <= vp_w && text_h <= vp_h

  # Compare how much the text overflows in each orientation.
  # Rotating 90 degrees swaps the text's width and height.
  horizontal_overflow <- max(text_w / vp_w, text_h / vp_h)
  vertical_overflow   <- max(text_h / vp_w, text_w / vp_h)

  # Prefer horizontal unless it doesn't fit and vertical fits better
  use_vertical <-
    !horizontal_fits &&
    vertical_overflow < horizontal_overflow

  grid::grid.draw(
    grid::textGrob(
      label = x$label,
      rot = if (use_vertical) 90 else 0,
      gp = x$gp
    )
  )
}

width2mm <- function(x) grid::convertWidth(x, "mm", valueOnly = TRUE)
height2mm <- function(x) grid::convertHeight(x, "mm", valueOnly = TRUE)
