colour_data <- function(colour) {
  tibble(
    name = colour,
    hex = col2hex(colour)
  ) |>
    bind_cols(col2hcl(colour)) |>
    bind_cols(col2rgb(colour)) |>
    rename(
      hue = h,
      chroma = c,
      luminance = l,
      red = r,
      green = g,
      blue = b
    )
}

col2hex <- function(colour) {
  encode_native(colour) |> decode_native()
}

col2hcl <- function(colour) {
  decode_colour(colour, to = "hcl")
}

col2rgb <- function(colour) {
  decode_colour(colour, to = "rgb")
}
