test_that("debug_print works", {
  expect_snapshot(debug_print(1:5))
  expect_snapshot(debug_print(1:5, note = "Hi!"))

  my_sum1 <- function(x) {
    debug_print(x)
    sum(x, na.rm = TRUE)
  }

  my_sum2 <- function(x) {
    do_nothing <- function(y) {
      debug_print(y)
      y
    }
    x <- do_nothing(x)
    sum(x, na.rm = TRUE)
  }

  expect_snapshot(my_sum1(1:5))
  expect_snapshot(my_sum2(1:5))

  add1 <- function(x) {
    sapply(x, \(x_i) {
      debug_print(x_i)
      x_i + 1
    })
  }

  expect_snapshot(add1(1:2))
})

test_that("debug_print errors correctly", {
  expect_snapshot(debug_print(1:5, note = mean), error = TRUE)
})
