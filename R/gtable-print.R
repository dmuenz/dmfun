#' Print a gtable object as a tibble
#'
#' Prints a [gtable][gtable::gtable-package] object in an easier-to-read format
#' compared to the [default gtable print method][gtable::print.gtable]. There
#' are also extra options for conveniently subsetting the printed gtable.
#'
#' `gtable_print()` prints a gtable's layout using a custom tibble subclass,
#' allowing for some parts of a standard printed tibble to be hidden, like the
#' `"# A tibble..."` header line and the row of column types.
#'
#' The `cells` column in the output is slightly different than the `cells`
#' column in the default gtable print method. Specifically, `gtable_print()`
#' simplifies `cells` in cases where a grob sits in only one row or one column.
#' E.g., if a grob is just in row 3 and column 2, then the default method would
#' print `"(3-3, 2-2)"`, while `gtable_print()` prints `"(3, 2)"`.
#'
#' @param x A `gtable` object, or an object coercible to a `gtable`, like a
#'   `ggplot` or `patchwork` object.
#' @param zsort Sort by z values? Default `FALSE`.
#' @param show_zeroGrobs `TRUE`/`FALSE` for whether to show zeroGrobs.
#' @param filter If a character vector of regexes, only grob names matching at
#'   least one regex will be printed. If `NULL` (the default), no filtering by
#'   grob name.
#'
#' @seealso [gtable_show_grobs()]
#' @export
#' @examples
#' # Let's print the gtable of a ggplot object. For comparison we'll use both
#' # the default method and gtable_print().
#' library(ggplot2)
#' p <- ggplot(mtcars, aes(hp, mpg))
#'
#' # Convert p to a gtable and print with the default printing method. Note that
#' # the "grob" column may get separated from the rest of the table, depending
#' # on the console width. That makes it hard to read.
#' gtable::as.gtable(p)
#'
#' # Better printing with gtable_print() -- the columns all stay together, with
#' # wide columns (e.g., "grob") getting abbreviated if needed. Note that
#' # gtable_print() handles the conversion of p to a gtable automatically.
#' gtable_print(p)
gtable_print <- function(
  x,
  zsort = FALSE,
  show_zeroGrobs = TRUE,
  filter = NULL
) {
  x <- gtable::as.gtable(x)

  rlang::check_bool(zsort)
  rlang::check_bool(show_zeroGrobs)

  if (!(is.null(filter) || is.character(filter) && length(filter) >= 1)) {
    rlang::stop_input_type(filter, "a character vector", allow_null = TRUE)
  }

  layout <- x$layout

  # Header
  cat(glue::glue(
    "TableGrob ({length(x$heights)} x {length(x$widths)}) \"layout\": \\
      {nrow(layout)} grobs",
    keep_whitespace = FALSE
  ))
  cat("\n")

  # Stop if gtable has no grobs
  if (nrow(layout) == 0) {
    return(invisible(x))
  }

  # Add row numbers (id) and grob names (grob) to the layout data frame
  info <- cbind(
    id = seq_len(nrow(layout)),
    layout,
    grob = vapply(x$grobs, as.character, character(1))
  )

  # Optionally reorder by z column
  if (zsort) {
    info <- info[order(layout$z), ]
  }

  # Optionally filter out zeroGrobs
  n_zeroGrobs_hidden <- 0
  if (!show_zeroGrobs) {
    zeroGrob_flag <- grepl("^zeroGrob\\b", info$grob)
    info <- info[!zeroGrob_flag, ]

    n_zeroGrobs_hidden <- sum(zeroGrob_flag)
  }

  # Optionally keep rows of info whose names match at least one regex in filter
  n_filter_hidden <- 0
  if (!is.null(filter)) {
    n_before <- nrow(info)

    keep <- lapply(filter, \(f) grep(f, info$name, perl = TRUE)) |>
      unlist() |>
      unique() |>
      sort()

    info <- info[keep, ]

    n_filter_hidden <- n_before - nrow(info)
  }

  # Combine the t, b, l, and r columns into one new column like "(t-b, l-r)"
  info$cells <- glue::glue(
    "({pos_fmt(info$t, info$b)}, {pos_fmt(info$l, info$r)})"
  )

  # Select the columns we want in a certain order
  info <- info[, c("id", "z", "cells", "name", "grob")]

  # Print layout info as a tibble
  print_tbl(
    info,
    n = Inf,
    show_types = FALSE,
    show_rowid = FALSE,
    show_header = FALSE
  )

  if (n_zeroGrobs_hidden > 0) {
    tibble_info("{n_zeroGrobs_hidden} zeroGrobs are omitted.")
  }

  if (n_filter_hidden > 0) {
    tibble_info("{n_filter_hidden} grobs are omitted due to {.arg filter}.")
  }

  invisible(x)
}

pos_fmt <- function(side1, side2) {
  side1[side1 == side2] <- 0
  side1 <- format(side1)
  side2 <- format(side2)
  if (all(side1 == "0")) {
    range <- side2
  } else {
    range <- paste0(side1, "-", side2)
    range <- sub("\\b0-", "  ", range, perl = TRUE)
  }
  range
}

tibble_info <- function(x, .envir = parent.frame()) {
  x <- cli::format_inline(x, .envir = .envir)
  x <- paste("# \u2139", x)
  cat(pillar::style_subtle(x), "\n", sep = "")
}
