# Find closest named colours.

Searches through R's built-in named colors from
[`colors()`](https://rdrr.io/r/grDevices/colors.html) to find the
closest matches to a given input color. Uses Euclidean distance in HCL
(Hue-Chroma-Luminance) color space to determine similarity.

## Usage

``` r
nearest_colour(
  colour,
  n = 1,
  method = c("hcl", "hue_chroma", "hue_luminance", "chroma_luminance", "hue", "chroma",
    "luminance")
)
```

## Arguments

- colour:

  A character string specifying a color in hex format (e.g., "#FF5733")
  or a named R color (e.g., "red").

- n:

  An integer specifying the number of closest colors to return. Default
  is 1.

- method:

  character how to perform the sorting. Default is "hcl", and it is done
  by euclidean distance. Total options are "hcl", "hue_chroma",
  "hue_luminance", "chroma_luminance", "hue", "chroma", and "luminance".

## Value

A tibble with the closest colours and its details.

## Examples

``` r
library(colorspace)
qual_cols <- qualitative_hcl(7)
qual_cols
#> [1] "#E16A86" "#C18500" "#799D00" "#00AB6E" "#00A9BE" "#6C8EE6" "#D169D0"
swatchplot(qual_cols)

near_qual_cols <- nearest_colour(qual_cols)
#> Called from: nearest_colour(qual_cols)
#> debug: r_cols <- colour_data(colours())
#> debug: topair_cols <- colour_data(colour)
#> debug: pair_cols <- dplyr::cross_join(x = r_cols, y = topair_cols, suffix = c("_base", 
#>     "_input"))
#> debug: pair_cols <- dplyr::mutate(pair_cols, dist_l = abs(luminance_base - 
#>     luminance_input), dist_c = abs(chroma_base - chroma_input), 
#>     dist_h = abs(hue_base - hue_input), dist_h_c = abs(dist_h^2 + 
#>         dist_c^2), dist_h_l = abs(dist_h^2 + dist_l^2), dist_c_l = abs(dist_c^2 + 
#>         dist_l^2), dist_hcl = sqrt(dist_l^2 + dist_c^2 + dist_h^2))
#> debug: closest_pair <- dplyr::select(dplyr::arrange(dplyr::ungroup(dplyr::slice_head(dplyr::arrange(dplyr::group_by(pair_cols, 
#>     name_input), .data[[method_var]]), n = n)), hue_base), name_base, 
#>     hex_base, hex_input)
#> debug: closest_pair
near_qual_cols$hex.x
#> Warning: Unknown or uninitialised column: `hex.x`.
#> NULL
near_qual_cols$hex.x |> swatchplot(qual_cols)
#> Warning: Unknown or uninitialised column: `hex.x`.
#> Error in matrix(y, ncol = length(y)): 'data' must be of a vector type, was 'NULL'
near_qual_cols$hex.x |> specplot(qual_cols)
#> Warning: Unknown or uninitialised column: `hex.x`.
#> Error in CheckMatrix(coords): invalid color matrix
nearest_colour(qual_cols)$hex.x |> swatchplot(qual_cols)
#> Called from: nearest_colour(qual_cols)
#> debug: r_cols <- colour_data(colours())
#> debug: topair_cols <- colour_data(colour)
#> debug: pair_cols <- dplyr::cross_join(x = r_cols, y = topair_cols, suffix = c("_base", 
#>     "_input"))
#> debug: pair_cols <- dplyr::mutate(pair_cols, dist_l = abs(luminance_base - 
#>     luminance_input), dist_c = abs(chroma_base - chroma_input), 
#>     dist_h = abs(hue_base - hue_input), dist_h_c = abs(dist_h^2 + 
#>         dist_c^2), dist_h_l = abs(dist_h^2 + dist_l^2), dist_c_l = abs(dist_c^2 + 
#>         dist_l^2), dist_hcl = sqrt(dist_l^2 + dist_c^2 + dist_h^2))
#> debug: closest_pair <- dplyr::select(dplyr::arrange(dplyr::ungroup(dplyr::slice_head(dplyr::arrange(dplyr::group_by(pair_cols, 
#>     name_input), .data[[method_var]]), n = n)), hue_base), name_base, 
#>     hex_base, hex_input)
#> debug: closest_pair
#> Warning: Unknown or uninitialised column: `hex.x`.
#> Error in matrix(y, ncol = length(y)): 'data' must be of a vector type, was 'NULL'
nearest_colour(qual_cols, method = "hue_chroma")$hex.x |> swatchplot(qual_cols)
#> Called from: nearest_colour(qual_cols, method = "hue_chroma")
#> debug: r_cols <- colour_data(colours())
#> debug: topair_cols <- colour_data(colour)
#> debug: pair_cols <- dplyr::cross_join(x = r_cols, y = topair_cols, suffix = c("_base", 
#>     "_input"))
#> debug: pair_cols <- dplyr::mutate(pair_cols, dist_l = abs(luminance_base - 
#>     luminance_input), dist_c = abs(chroma_base - chroma_input), 
#>     dist_h = abs(hue_base - hue_input), dist_h_c = abs(dist_h^2 + 
#>         dist_c^2), dist_h_l = abs(dist_h^2 + dist_l^2), dist_c_l = abs(dist_c^2 + 
#>         dist_l^2), dist_hcl = sqrt(dist_l^2 + dist_c^2 + dist_h^2))
#> debug: closest_pair <- dplyr::select(dplyr::arrange(dplyr::ungroup(dplyr::slice_head(dplyr::arrange(dplyr::group_by(pair_cols, 
#>     name_input), .data[[method_var]]), n = n)), hue_base), name_base, 
#>     hex_base, hex_input)
#> debug: closest_pair
#> Warning: Unknown or uninitialised column: `hex.x`.
#> Error in matrix(y, ncol = length(y)): 'data' must be of a vector type, was 'NULL'
nearest_colour(qual_cols, method = "hue_luminance")$hex.x |> swatchplot(qual_cols)
#> Called from: nearest_colour(qual_cols, method = "hue_luminance")
#> debug: r_cols <- colour_data(colours())
#> debug: topair_cols <- colour_data(colour)
#> debug: pair_cols <- dplyr::cross_join(x = r_cols, y = topair_cols, suffix = c("_base", 
#>     "_input"))
#> debug: pair_cols <- dplyr::mutate(pair_cols, dist_l = abs(luminance_base - 
#>     luminance_input), dist_c = abs(chroma_base - chroma_input), 
#>     dist_h = abs(hue_base - hue_input), dist_h_c = abs(dist_h^2 + 
#>         dist_c^2), dist_h_l = abs(dist_h^2 + dist_l^2), dist_c_l = abs(dist_c^2 + 
#>         dist_l^2), dist_hcl = sqrt(dist_l^2 + dist_c^2 + dist_h^2))
#> debug: closest_pair <- dplyr::select(dplyr::arrange(dplyr::ungroup(dplyr::slice_head(dplyr::arrange(dplyr::group_by(pair_cols, 
#>     name_input), .data[[method_var]]), n = n)), hue_base), name_base, 
#>     hex_base, hex_input)
#> debug: closest_pair
#> Warning: Unknown or uninitialised column: `hex.x`.
#> Error in matrix(y, ncol = length(y)): 'data' must be of a vector type, was 'NULL'
```
