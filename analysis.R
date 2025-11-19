col_data_set <- colour_data(colours())

col_data_set

col_data_set |>
  filter(
    name %in% c("steelblue", "firebrick", "seagreen")
  ) |>
  pull(hex)

colorspace::qualitative_hcl(n = 9) |> specplot()


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
