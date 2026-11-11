# Test if a package is available for use
is_package_available <- function(pkg) {
  (requireNamespace(pkg, quietly = TRUE))
}
