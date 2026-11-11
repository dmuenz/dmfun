#' Print a gtable object
#'
#' @param x A `gtable` object. Or a `ggplot` or `patchwork` object, which will
#'   be converted to a gtable, provided those packages are available.
#' @param zsort Sort by z values? Default `FALSE`.
#' @param show_zeroGrobs `TRUE`/`FALSE` for whether to show zeroGrobs.
#' @param filter If a character vector of regexes, only grob names matching at
#'   least one regex will be printed. If `NULL` (the default), no filtering by
#'   grob name.
#' @export
gtable_print <- function(x, zsort = FALSE, show_zeroGrobs = TRUE,
                         filter = NULL) {

  x <- gtable::as.gtable(x)

  caption <- utils::capture.output(info <- print(x))[1]
  cat(caption, "\n", sep = "")

  if (is.null(info))
    return()

  info_fmt <- info |>
    structure(class = c("tbl", "data.frame")) |>
    format(n = Inf)

  header <- info_fmt[2]
  body <- info_fmt[-(1:3)]

  if (zsort) {
    body <- body[order(info$z)]
    info <- info[order(info$z), ]
  }

  if (!show_zeroGrobs) {
    zeroGrob_flag <- grepl("^zeroGrob\\b", info$grob)
    body <- body[!zeroGrob_flag]
    info <- info[!zeroGrob_flag, , drop = FALSE]

    n_zeroGrobs_hidden <- sum(zeroGrob_flag)
  } else
    n_zeroGrobs_hidden <- 0

  if (!is.null(filter)) {
    if (!(is.character(filter) && length(filter) >= 1))
      cli::cli_abort("{.arg filter} must be NULL or a character vector.")

    names <- sub("^.*\\([\\d, -]+\\) +", "", body, perl = TRUE)
    names <- sub(" +\\S+ *$", "", names, perl = TRUE)

    keep <- lapply(filter, \(f) grep(f, names, perl = TRUE)) |>
      unlist() |>
      unique() |>
      sort()

    body <- body[keep]
    info <- info[keep, , drop = FALSE]

    n_filter_hidden <- length(names) - length(keep)
  } else
    n_filter_hidden <- 0

  body <- sub("\033[38;5;250m", "", body, fixed = TRUE)
  body <- sub("\033[39m", "", body, fixed = TRUE)

  if (length(body) > 0)
    c(header, body) |>
    compress_parallel_spaces() |>
    paste0("\n", collapse = "") |>
    cat()

  if (n_zeroGrobs_hidden > 0)
    cli::cli_alert_info("{n_zeroGrobs_hidden} zeroGrobs are not listed above.")

  if (n_filter_hidden > 0)
    cli::cli_alert_info("{n_filter_hidden} grobs are hidden due to {.arg filter}.")

  invisible(info)
}

compress_parallel_spaces <- function(x) {
  # convert to a matrix where each cell is a single character. There's one row
  # for each element of x, with characters split into the columns.
  char_mat <- stringi::stri_split_boundaries(
    x,
    type = "character",
    simplify = TRUE
  )

  # find indexes of columns that are all spaces, and whether these "space
  # columns" are just to the right of another space column.
  space_col_index <- apply(char_mat, 2, \(x) all(x == " ")) |> which()
  repeat_space_col <- c(0, diff(space_col_index)) == 1

  # replace a leading space column and repeat space columns with a column of ""
  for (i in seq_along(space_col_index)) {
    if (space_col_index[i] == 1 || repeat_space_col[i])
      char_mat[, space_col_index[i]] <- ""
  }

  # convert back to a vector, same length as x, by pasting together the columns
  apply(char_mat, 1, \(vec) paste(vec, collapse = ""))
}
