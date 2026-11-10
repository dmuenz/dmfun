#' Lint a package and write findings to Markdown
#'
#' Run [lintr::lint_package()] and save the findings in a Markdown file named
#' `lint-package.md` in the package's root directory.
#'
#' You should add `^lint-package\\.md$` to `.Rbuildignore`. And you might want
#' to add `lint-package.md` to `.gitignore`.
#'
#' @param path Path to the top-level directory of the source package.
#' @param ... Additional arguments passed to [lintr::lint_package()].
#'
#' @seealso [lint_simplify()]
#' @export
#' @examplesIf interactive()
#' lint_package_to_md()
lint_package_to_md <- function(path = ".", ...) {
  # Normalize the package path and get package name
  path <- pkgload::pkg_path(path)
  package <- pkgload::pkg_name(path)

  # Temporarily move to the package path
  withr::local_dir(path)

  # Lint the package
  lint <- lintr::lint_package(path, ...) |> lint_simplify()

  # Format lint findings as a Markdown table
  lint_table <- knitr::kable(lint, format = "pipe") |> paste(collapse = "!EOL!")

  # Create the Markdown file
  cli::format_inline(
"# Lint R package **{package}** {pkgload::pkg_version_raw(path)}

{Sys.Date()}

[`lintr::lint_package()`](https://lintr.r-lib.org/reference/lint.html)
reported {cli::no(nrow(lint))} finding{?s}.

{lint_table}

<br>Created by `dmfun::lint_package_to_md()`.",
    collapse = FALSE
  ) |>
    gsub("!EOL!", "\n", x = _, fixed = TRUE) |>
    writeLines("lint-package.md")

  # Report that Markdown file was created
  cli::cli_alert_success("Created {.file lint-package.md} in \\
                         {.pkg {package}}'s root.")

  # Advise user to add Markdown file to .Rbuildignore
  if (!file.exists(".Rbuildignore")) {
    cli::cli_alert_info("You should create .Rbuildignore and add \\
                        {.val ^lint-package\\.md$}")
  } else if (!any(readLines(".Rbuildignore") == "^lint-package\\.md$")) {
    cli::cli_alert_info("You should add {.val ^lint-package\\.md$} to \\
                        {.file .Rbuildignore}.")
  }

  # Advise user to consider adding Markdown file to .gitignore
  if (!file.exists(".gitignore")) {
    cli::cli_alert_info("Consider creating .gitignore and adding \\
                        {.val lint-package.md}")
  } else if (!any(readLines(".gitignore") == "lint-package.md")) {
    cli::cli_alert_info("Consider adding {.val lint-package.md} to \\
                        {.file .gitignore}.")
  }

  invisible(TRUE)
}

#' Simplify a lintr object for easy printing
#'
#' Converts the output of [lintr::lint_package()] into a data frame with only a
#' few key columns.
#'
#' @param lint A lint object returned by the lintr package.
#'
#' @returns A data frame of lintr findings, with columns `#`, `filename`,
#'   `line`, and `col`.
#'
#' @seealso [lint_package_to_md()]
#' @export
#' @examplesIf interactive()
#' lint <- lintr::lint_package()
#' lint_simplify(lint)
lint_simplify <- function(lint) {
  if (!inherits(lint, "lints")) {
    cli::cli_abort("{.arg lint} does not seem to be a lint object from the
                   {.pkg lintr} package")
  }

  lint <- as.data.frame(lint)
  lint <- lint[, c("filename", "message", "line_number", "column_number")]
  names(lint) <- c("filename", "message", "line",        "col")
  lint <- cbind(`#` = seq_len(nrow(lint)), lint)
  lint
}
