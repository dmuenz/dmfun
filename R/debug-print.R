#' Print an object for debugging
#'
#' The name/call of the object, along with the name of the function from which
#' `debug_print` is called, are also printed. The whole thing is surrounded by
#' horizontal lines. This may be useful for debugging.
#'
#' @param x An object to print.
#' @param note An optional string to be printed, useful for giving more context.
#'
#' @returns Invisibly returns `x`.
#' @export
#' @examples
#' # inspect `x` inside a function
#' my_sum <- function(x) {
#'   debug_print(x)
#'   sum(x, na.rm = TRUE)
#' }
#'
#' my_sum(1:5)
#'
#' # debug_print also works out of a function
#' debug_print(1:5 + 6)
debug_print <- function(x, note = NULL) {
  traces <- rlang::trace_back(bottom = 2)$call |> lapply(\(tr) {
    as.character(tr) |> stats::setNames(names(tr))
  })
  caller_vec <- NULL
  for (i in rev(seq_along(traces))) {
    if (traces[[i]][1] != "<fn>") {
      caller_vec <- traces[[i]]
      break
    }
  }
  caller <- if (identical(caller_vec[[1]], "do.call")) {
    if ("what" %in% names(caller_vec)) caller_vec["what"]
    else caller_vec[[2]]
  } else {
    caller_vec[[1]]
  }

  cat("/================\n")
  cat("Printing ", deparse(substitute(x)), "\n", sep = "")
  if (!is.null(caller)) cat("    from ", caller, "()\n", sep = "")
  if (!is.null(note)) cat("Note: ", note, "\n", sep = "")
  cat("--------\n")
  print(x)
  cat("================/\n")
  invisible(x)
}
