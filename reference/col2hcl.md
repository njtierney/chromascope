# Convert colour to HCL values

go from a colour like "red" to a HCL matrix, values of hue, chroma, and
luminance

## Usage

``` r
col2hcl(colour)
```

## Arguments

- colour:

  a colour name from
  [`colours()`](https://rdrr.io/r/grDevices/colors.html) or
  [`colors()`](https://rdrr.io/r/grDevices/colors.html)

## Value

A matrix of hue, chroma, and luminance

## Examples

``` r
col2hcl("red")
#>            h       c        l
#> [1,] 12.1744 179.049 53.24079
```
