#' Print a tibble with additional display options
#'
#' Prints a [tibble][tibble::tibble-package] with optional control over the
#' column type row, row IDs, and tibble header. Apart from these display
#' options, normal tibble printing behavior is preserved.
#'
#' @param x A tibble, or an object coercible to a tibble, like a data frame.
#' @param ... Additional arguments passed to the [default tibble print
#'   method][tibble::formatting], such as `n` and `width`.
#' @param show_types `TRUE`/`FALSE`, whether to show a row of column types, such
#'   as `<chr>` and `<dbl>`.
#' @param show_rowid `TRUE`/`FALSE`, whether to show a column of row ID numbers.
#' @param show_header `TRUE`/`FALSE`, whether to show a tibble header, such as
#'   "# A tibble: 10 x 3".
#'
#' @returns Invisibly returns `x`.
#'
#' @export
#' @examples
#' x <- tibble::tibble(name = c("Alice", "Bob"), age = c(30, 40))
#' print_tbl(x) # normal tibble printing
#' print_tbl(x, show_types = FALSE)  # drop the row of column types
#' print_tbl(x, show_rowid = FALSE)  # drop the column of row IDs
#' print_tbl(x, show_header = FALSE) # drop the "# A tibble..." line
print_tbl <- function(
  x,
  ...,
  show_types = TRUE,
  show_rowid = TRUE,
  show_header = TRUE
) {
  y <- tibble::as_tibble(x)

  rlang::check_bool(show_types)
  rlang::check_bool(show_rowid)
  rlang::check_bool(show_header)

  # Store new parameters as attributes on a temporary tibble subclass. The S3
  # methods then consult those attributes and otherwise fall straight through to
  # pillar's default behavior.
  y <- structure(
    y,
    show_types = show_types,
    show_rowid = show_rowid,
    show_header = show_header,
    class = c("tbl_print_options", class(y))
  )

  print(y, ...)
  invisible(x)
}

# Helper: remove the type component before pillar determines column width
remove_type_component <- function(x) {
  if (is.null(x)) {
    return(NULL)
  }

  components <- unclass(x)
  components$type <- NULL

  pillar::new_pillar(
    components,
    width = attr(x, "width")
  )
}

# Row of column types
#' @exportS3Method pillar::ctl_new_pillar
ctl_new_pillar.tbl_print_options <- function(
  controller,
  x,
  width,
  ...,
  title = NULL
) {
  out <- NextMethod()

  if (isFALSE(attr(controller, "show_types"))) {
    out <- remove_type_component(out)
  }

  out
}

# Column of row ID numbers
#' @exportS3Method pillar::ctl_new_rowid_pillar
ctl_new_rowid_pillar.tbl_print_options <- function(
  controller,
  x,
  width,
  ...,
  title = NULL,
  type = NULL
) {
  if (isFALSE(attr(controller, "show_rowid"))) {
    return(NULL)
  }

  NextMethod()
}

# Header line (i.e., "A tibble: r x c")
#' @exportS3Method pillar::tbl_format_header
tbl_format_header.tbl_print_options <- function(
  x,
  setup,
  ...
) {
  if (isFALSE(attr(x, "show_header"))) {
    return(character())
  }

  NextMethod()
}
