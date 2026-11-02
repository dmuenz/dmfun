# Test if a package is available for use
is_package_available <- function(pkg) {
  (requireNamespace(pkg, quietly = TRUE))
}

# Convert an object to a gtable if it's either a ggplot or patchwork object;
# otherwise leave it as is
ggplot2gtable <- function(x) {
  if (is_package_available("ggplot2") && ggplot2::is_ggplot(x)) {
    if (inherits(x, "patchwork")) {
      if (is_package_available("patchwork"))
        x <- patchwork::patchworkGrob(x)
      else
        cli::cli_abort("Cannot convert a patchwork object to a gtable withouth
                       the {.pkg patchwork} package.")
    } else {
      x <- ggplot2::ggplotGrob(x)
    }
  }
  x
}
