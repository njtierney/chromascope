#' Find closest named colours.
#'
#' Searches through R's built-in named colors from `colors()` to find the closest matches to a given input color. Uses Euclidean distance in HCL (Hue-Chroma-Luminance) color space to determine similarity.
#'
#' @param colour A character string specifying a color in hex format (e.g., "#FF5733") or a named R color (e.g., "red").
#' @param n An integer specifying the number of closest colors to return. Default is 1.
#'
#' @returns A tibble with the closest colours and its details.
#' @export
#'
#' @examples
#' library(colorspace)
#' qual_cols <- qualitative_hcl(7)
#' close_r_cols(qual_cols)
#'
#'
close_r_cols <- function(colour, n = 1) {
  # Generate colour data for both data
  r_cols <- colour_data(colours())
  topair_cols <- colour_data(colour)

  # Cross join topair_cols to r_cols
  pair_cols <- dplyr::cross_join(r_cols, topair_cols)

  # Calculate distance of the hcl pairs
  pair_cols <- pair_cols |>
    dplyr::mutate(
      l_dist = abs(luminance.x - luminance.y),
      c_dist = abs(chroma.x - chroma.y),
      h_dist = abs(hue.x - hue.y),
      hcl_dist = sqrt(l_dist^2 + c_dist^2 + h_dist^2)
    )

  # Find the pair with the shortest distance
  closest_pair <- pair_cols |>
    dplyr::group_by(name.y) |>
    dplyr::arrange(hcl_dist) |>
    dplyr::slice_head(n = n) |>
    dplyr::ungroup()

  # Print closest_pair
  closest_pair
}
