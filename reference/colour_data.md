# Create a data frame of colour values

Create a data frame of colour values

## Usage

``` r
colour_data(colour)
```

## Arguments

- colour:

  a colour name from
  [`colours()`](https://rdrr.io/r/grDevices/colors.html) or
  [`colors()`](https://rdrr.io/r/grDevices/colors.html)

## Value

data frame of colours with columns: name, hex, hue, chroma, luminance,
red, green, blue

## Examples

``` r
colour_data("red")
#> # A tibble: 1 × 8
#>   name  hex       hue chroma luminance   red green  blue
#>   <chr> <chr>   <dbl>  <dbl>     <dbl> <int> <int> <int>
#> 1 red   #FF0000  12.2   179.      53.2   255     0     0
```
