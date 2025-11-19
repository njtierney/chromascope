#' Find closest named colours.
#'
#' Searches through R's built-in named colors from `colors()` to find the closest matches to a given input color. Uses Euclidean distance in HCL (Hue-Chroma-Luminance) color space to determine similarity.
#'
#' @param colour A character string specifying a color in hex format (e.g., "#FF5733") or a named R color (e.g., "red").
#' @param n An integer specifying the number of closest colors to return.
#'   Default is 1.
#' @param method character how to perform the sorting. Default is "hcl", and
#'   it is done by euclidean distance. Total options are "hcl", "hue_chroma",
#'  "hue_luminance", "chroma_luminance", "hue", "chroma", and "luminance".
#'
#' @returns A tibble with the base R name from [colours()] that matches the
#'   given provided colours. It contains three columns: "name_base",
#'   "hex_base", and "hex_input".
#'
#' @export
#'
#' @examples
#' library(colorspace)
#' qual_cols <- qualitative_hcl(7)
#' qual_cols
#' swatchplot(qual_cols)
#' near_qual_cols <- nearest_colour(qual_cols)
#' near_qual_cols
#'
#' library(dplyr)
#'
#' near_qual_cols |>
#'   pull(hex_base) |>
#'   swatchplot(qual_cols)
#'
#' near_qual_cols |>
#'   pull(hex_base) |>
#'   specplot(qual_cols)
#'
#'
nearest_colour <- function(
  colour,
  n = 1,
  method = c(
    "hcl",
    "hue_chroma",
    "hue_luminance",
    "chroma_luminance",
    "hue",
    "chroma",
    "luminance"
  )
) {
  # check the arguments
  method <- rlang::arg_match(method)

  method_var <- switch(
    method,
    luminance = "dist_l",
    chroma = "dist_c",
    hue = "dist_h",
    hue_chroma = "dist_h_c",
    hue_luminance = "dist_h_l",
    chroma_luminance = "dist_c_l",
    hcl = "dist_hcl"
  )

  browser()
  # Generate colour data for both data
  r_cols <- colour_data(colours())
  topair_cols <- colour_data(colour)

  # Cross join topair_cols to r_cols
  pair_cols <- dplyr::cross_join(
    x = r_cols,
    y = topair_cols,
    suffix = c("_base", "_input")
  )

  # Calculate distance of the hcl pairs
  pair_cols <- pair_cols |>
    dplyr::mutate(
      dist_l = abs(luminance_base - luminance_input),
      dist_c = abs(chroma_base - chroma_input),
      dist_h = abs(hue_base - hue_input),
      dist_h_c = abs(dist_h^2 + dist_c^2),
      dist_h_l = abs(dist_h^2 + dist_l^2),
      dist_c_l = abs(dist_c^2 + dist_l^2),
      dist_hcl = sqrt(dist_l^2 + dist_c^2 + dist_h^2)
    )

  # Find the pair with the shortest distance
  closest_pair <- pair_cols |>
    dplyr::group_by(name_input) |>
    # ensure we refer to the variable by name - this is some data-masking/NSE
    dplyr::arrange(.data[[method_var]]) |>
    dplyr::slice_head(n = n) |>
    dplyr::ungroup() |>
    dplyr::arrange(hue_base) |>
    dplyr::select(
      name_base,
      hex_base,
      hex_input
    )

  # Print closest_pair
  closest_pair
}
