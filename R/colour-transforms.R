#' Convert colour to hex value
#'
#' @description go from a colour like "red" to the hex code, "#FF0000"
#'
#' @param colour a colour name from [colours()] or [colors()]
#'
#' @returns
#' A hex color hex value
#'
#' @export
#' @examples
#' col2hex("red")
col2hex <- function(colour) {
  farver::encode_native(colour) |>
    farver::decode_native()
}

#' Convert colour to HCL values
#'
#' @description go from a colour like "red" to a HCL matrix, values of hue,
#'   chroma, and luminance
#'
#' @inheritParams col2hex
#'
#' @returns A matrix of hue, chroma, and luminance
#'
#' @export
#' @examples
#' col2hcl("red")
col2hcl <- function(colour) {
  farver::decode_colour(colour, to = "hcl")
}

#' Convert colour to RGB values
#'
#' @description go from a colour like "red" to a HCL matrix, values of red,
#' green, and blue.
#'
#' @inheritParams col2hex
#'
#' @returns A matrix of red, green, and blue.
#'
#' @export
#' @examples
#' col2rgb("red")
col2rgb <- function(colour) {
  farver::decode_colour(colour, to = "rgb")
}

#' Create a data frame of colour values
#'
#' @inheritParams col2hex
#'
#' @returns data frame of colours with columns: name, hex, hue, chroma,
#'   luminance, red, green, blue
#' @export
#'
#' @examples
#' colour_data("red")
colour_data <- function(colour) {
  tibble::tibble(
    name = colour,
    hex = col2hex(colour)
  ) |>
    dplyr::bind_cols(col2hcl(colour)) |>
    dplyr::bind_cols(col2rgb(colour)) |>
    dplyr::rename(
      hue = h,
      chroma = c,
      luminance = l,
      red = r,
      green = g,
      blue = b
    )
}
