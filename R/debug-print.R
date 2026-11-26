#' Print an object for debugging
#'
#' Prints an object's expression, the call stack from which `debug_print` is
#' called, and the evaluated result of the expression. The whole thing is
#' surrounded by horizontal lines. This may be useful for simple debugging.
#'
#' @param x An object to print.
#' @param note An optional string (or something coercible to a string) to be
#'   printed. Useful for giving more context.
#'
#' @returns Invisibly returns `x`.
#' @export
#' @examples
#' \dontshow{old_op <- options(rlang_trace_top_env = rlang::current_env())}
#' # inspect `x` inside a function
#' my_sum <- function(x) {
#'   debug_print(x)
#'   sum(x, na.rm = TRUE)
#' }
#'
#' my_sum(1:5)
#'
#' # inspect `x_i` inside a nested function
#' sum_of_means <- function(...) {
#'   sum(
#'     sapply(list(...), \(x_i) {
#'       debug_print(x_i)
#'       mean(x_i)
#'     }),
#'     na.rm = TRUE
#'   )
#' }
#'
#' sum_of_means(1:3, 4:6)
#'
#' # debug_print also works outside of a function
#' debug_print(1:5 + 6)
#' \dontshow{options(old_op)}
debug_print <- function(x, note = NULL) {
  if (!is.null(note)) {
    note_try <- tryCatch(as.character(note), error = identity)
    if (inherits(note_try, "error")) {
      rlang::stop_input_type(note, "`NULL` or coercible to character")
    }
    note <- note_try
  }

  traces <- rlang::trace_back(bottom = 2)$call |> lapply(\(tr) {
    as.character(tr) |> stats::setNames(names(tr))
  })

  call_stack <- NULL
  if (length(traces) > 0) {
    calls <- NULL
    for (i in rev(seq_along(traces))) {
      if (any(grepl("\\bdebug_print\\b", traces[[i]]))) {
        calls <- sapply(1:i, \(j) traces[[j]][1])
        break
      }
    }

    if (is.null(calls)) {
      calls <- sapply(traces, \(tr) tr[1])
    }

    call_stack <- paste0(calls, "()", collapse = " -> ")
  }

  cat0(strrep("\u203E", 20), "\n")
  cat0("Printing ", deparse(substitute(x)), "\n")
  if (!is.null(call_stack)) cat0("    from ", call_stack, "\n")
  if (length(note) > 0) cat0("Note: ", note, "\n")
  cat0(strrep("-", 8), "\n")
  print(x)
  cat0(strrep("_", 20), "\n")
  invisible(x)
}
