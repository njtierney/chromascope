col2hcl <- function(x) {
  x_col <- col2rgb(x)

  hcl_cols <- colorspace::RGB(
    R = x_col[1, ],
    G = x_col[2, ],
    B = x_col[3, ]
  ) |>
    as("polarLUV") |>
    coords()

  tibble::tibble(
    name = x,
    hue = hcl_cols[, "H"],
    chroma = hcl_cols[, "C"],
    luminance = hcl_cols[, "L"],
    hex = col2hex(x)
  )
}

rgb2hex <- function(x) {
  rgb_cols <- t(x)
  rgb(
    red = rgb_cols[, "red"],
    green = rgb_cols[, "green"],
    blue = rgb_cols[, "blue"],
    maxColorValue = 255
  )
}

col2hex <- function(x) {
  col2rgb(x) |>
    rgb2hex()
}

viridisLite::viridis(n = 7) |> specplot()

library(colorspace)

col_data_set <- col2hcl(colours())

col_data_set
library(tidyverse)
col_data_set |>
  filter(
    name %in% c("steelblue", "firebrick", "seagreen")
  ) |>
  pull(hex)

firebrick_hcl <- col2hcl("firebrick")

cs_firebrick <- sequential_hcl(
  n = 7,
  h = firebrick_hcl$hue
  # c = firebrick_hcl$chroma
)

light_firebrick <- lighten(
  "firebrick",
  amount = seq(0, 0.9, length.out = 7)
)

demoplot(cs_firebrick, type = "heatmap")
demoplot(light_firebrick, type = "heatmap")

par(
  mfrow(1, 2)
)

specplot(
  cs_firebrick,
  light_firebrick
)

hcl(
  h = 120,
  c = 0,
  l = 100
) |>
  swatchplot()


###

nearRcolor <- function(
  rgb,
  cSpace = c("hsv", "rgb255", "Luv", "Lab"),
  dist = switch(cSpace, "hsv" = 0.10, "rgb255" = 30, "Luv" = 15, "Lab" = 12)
) {
  if (is.character(rgb)) rgb <- col2rgb(rgb)
  stopifnot(length(rgb <- as.vector(rgb)) == 3)
  Rcol <- col2rgb(.cc <- colors())
  uniqC <- !duplicated(t(Rcol)) # gray9 == grey9 (etc)
  Rcol <- Rcol[, uniqC]
  .cc <- .cc[uniqC]
  cSpace <- match.arg(cSpace)
  convRGB2 <- function(Rgb, to)
    t(convertColor(t(Rgb), from = "sRGB", to = to, scale.in = 255))
  ## the transformation,  rgb{0..255} --> cSpace :
  TransF <- switch(
    cSpace,
    "rgb255" = identity,
    "hsv" = rgb2hsv,
    "Luv" = function(RGB) convRGB2(RGB, "Luv"),
    "Lab" = function(RGB) convRGB2(RGB, "Lab")
  )
  d <- sqrt(colSums((TransF(Rcol) - as.vector(TransF(rgb)))^2))
  iS <- sort.list(d[near <- d <= dist]) # sorted: closest first
  setNames(.cc[near][iS], format(zapsmall(d[near][iS]), digits = 3))
}
