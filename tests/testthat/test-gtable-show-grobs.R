test_that("gtable_show_grobs works", {
  p <- ggplot2::ggplot(mtcars, ggplot2::aes(hp, mpg))

  vdiffr::expect_doppelganger(
    "default settings",
    gtable_show_grobs(p)
  )

  vdiffr::expect_doppelganger(
    "show zeroGrobs",
    gtable_show_grobs(p, show_zeroGrobs = TRUE)
  )

  vdiffr::expect_doppelganger(
    "change colors and fontsize",
    gtable_show_grobs(p, color = "blue", fill = "white", fontsize = 8)
  )

  vdiffr::expect_doppelganger(
    "no labels",
    gtable_show_grobs(p, labels = FALSE)
  )

  vdiffr::expect_doppelganger(
    "some labels",
    gtable_show_grobs(p, labels = "lab|axis")
  )

  expect_snapshot(gtable_show_grobs(gtable::gtable()))
})

test_that("gtable_show_grobs errors correctly", {
  expect_snapshot(gtable_show_grobs(1), error = TRUE)

  p <- ggplot2::ggplot(mtcars, ggplot2::aes(hp, mpg))

  expect_snapshot(gtable_show_grobs(p, color = "waka"), error = TRUE)
  expect_snapshot(gtable_show_grobs(p, fill = "waka"), error = TRUE)
  expect_snapshot(gtable_show_grobs(p, fontsize = -1), error = TRUE)
  expect_snapshot(gtable_show_grobs(p, labels = -1), error = TRUE)
  expect_snapshot(gtable_show_grobs(p, show_zeroGrobs = -1), error = TRUE)
})
