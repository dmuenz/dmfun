# the logo was originally created by an AI chatbot as a 1024x1024 image with a
# white background around the hex logo. Here we remove that background, trim the
# image so there's no background area around the logo, and then shrink the image
# so the file size is much smaller.

img <-
  magick::image_read("logo/logo-from-chat.png") |>
  magick::image_fill(color = "transparent", point = "+1+1", fuzz = 20) |>
  magick::image_trim() |>
  magick::image_resize("480x556!")

img

magick::image_write(img, "logo/logo.png")
tinyimg::tinypng("logo/logo.png", output = identity, lossy = 2.3)

fs::file_copy("logo/logo.png", "man/figures/logo.png", overwrite = TRUE)
