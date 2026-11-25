# Check if an argument is a color, and produce a friendly error message if not
check_color <- function(col, allow_null = FALSE,
                        arg = rlang::caller_arg(col),
                        call = rlang::caller_env()) {
  force(arg)

  type <- "a color"
  if (allow_null) type <- paste(type, "or `NULL`")

  if (is.null(col)) {
    if (allow_null)
      return(invisible(NULL))
    else
      cli::cli_abort("{.arg {arg}} must be {type}.", call = call)
  }

  if (!is.atomic(col))
    cli::cli_abort("{.arg {arg}} must be {type}.", call = call)

  tryCatch(
    grDevices::col2rgb(col),
    error = function(e) {
      msg <- paste("{.arg {arg}}:", conditionMessage(e))
      cli::cli_abort(msg, call = call)
    }
  )

  invisible(NULL)
}
