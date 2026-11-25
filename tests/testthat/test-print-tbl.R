test_that("print_tbl works", {
  x <- tibble::tibble(name = c("Alice", "Bob"), age = c(30, 40))

  expect_snapshot(print_tbl(x))
  expect_snapshot(print_tbl(x, show_types = FALSE))
  expect_snapshot(print_tbl(x, show_rowid = FALSE))
  expect_snapshot(print_tbl(x, show_header = FALSE))
  expect_snapshot(print_tbl(x, n = 1))
})

test_that("print_tbl errors correctly", {
  expect_snapshot(print_tbl(mean), error = TRUE)

  x <- tibble::tibble(name = c("Alice", "Bob"), age = c(30, 40))

  expect_snapshot(print_tbl(x, show_types = 1), error = TRUE)
  expect_snapshot(print_tbl(x, show_rowid = 1), error = TRUE)
  expect_snapshot(print_tbl(x, show_header = 1), error = TRUE)
})
