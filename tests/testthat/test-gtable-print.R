test_that("gtable_print works", {
  p <- ggplot2::ggplot(mtcars, ggplot2::aes(hp, mpg))

  expect_snapshot(gtable_print(p))
  expect_snapshot(gtable_print(p, zsort = TRUE))
  expect_snapshot(gtable_print(p, show_zeroGrobs = FALSE))
  expect_snapshot(gtable_print(p, filter = "axis"))
  expect_snapshot(gtable_print(p, filter = c("axis", "lab")))
})

test_that("gtable_print errors correctly", {
  expect_snapshot(gtable_print(1), error = TRUE)

  p <- ggplot2::ggplot(mtcars, ggplot2::aes(hp, mpg))

  expect_snapshot(gtable_print(p, zsort = 1), error = TRUE)
  expect_snapshot(gtable_print(p, show_zeroGrobs = 1), error = TRUE)
  expect_snapshot(gtable_print(p, filter = 1), error = TRUE)
})
