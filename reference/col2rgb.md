# Convert colour to RGB values

go from a colour like "red" to a HCL matrix, values of red, green, and
blue.

## Usage

``` r
col2rgb(colour)
```

## Arguments

- colour:

  a colour name from
  [`colours()`](https://rdrr.io/r/grDevices/colors.html) or
  [`colors()`](https://rdrr.io/r/grDevices/colors.html)

## Value

A matrix of red, green, and blue.

## Examples

``` r
col2rgb("red")
#>        r g b
#> [1,] 255 0 0
```
