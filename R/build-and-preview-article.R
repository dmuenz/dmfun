#' Build and preview an article for a pkgdown website
#'
#' @param name Name of article. This should be either a path relative to
#'   `⁠vignettes/`⁠ *without extension*, or `index` or `README` or `NULL`. If
#'   `NULL` (the default), then the currently active article source file will be
#'   used.
#' @param ... Additional parameters passed to [pkgdown::build_article()].
#' @export
build_and_preview_article <- function(name = NULL, ...) {
  if (is.null(name)) {
    is_match <- FALSE
    name <- rstudioapi::getSourceEditorContext()$path
    proj <- rstudioapi::getActiveProject()
    if (!is.null(name) && !is.null(proj)) {
      name <- normalizePath(name, winslash = "/")
      proj <- normalizePath(proj, winslash = "/")
      if (startsWith(name, proj)) {
        name <- substring(name, nchar(proj) + 2)
        if (startsWith(name, "vignettes")) {
          name <- substring(name, nchar("vignettes") + 2)
          if (grepl("\\.[Rq]md$", name)) {
            name <- sub("\\.[Rq]md$", "", name)
            is_match <- TRUE
          }
        }
      }
    }

    if (!is_match) {
      cli::cli_abort("Cannot find an active source file that's a
                     vignette/article")
    }
  }

  if (length(name) != 1 || !is.character(name) || is.na(name))
    cli::cli_abort("{.arg name} should be an article name (without extension) or
                   else NULL")

  name_params <- expand.grid(
    folder = c("", "articles"),
    ext = c("Rmd", "qmd")
  )

  name_options <- sapply(1:nrow(name_params), \(i) {
    folder <- name_params$folder[i]
    ext <- name_params$ext[i]
    if (folder != "")
      name <- file.path(folder, name)
    paste0(name, ".", ext)
  }) |>
    Filter(\(name) file.exists(file.path("vignettes", name)), x = _)

  if (length(name_options) == 0)
    cli::cli_abort("Can't find article {.field name}")

  if (length(name_options) > 1)
    cli::cli_abort("Too many files match the name {.field name}:\n
      {.file {name_options}}")

  name <- sub("\\.[Rq]md", "", name_options)

  pkgdown::build_article(name, ...)
  pkgdown::preview_site(path = paste0(name, ".html"))
}
