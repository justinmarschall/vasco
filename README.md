# vasco

An R package for exploring your data.

## Usage

There are three main functions in the vasco library:

+ Plotting numeric variables
    + plot_density()
    + plot_histogram()
+ Plotting categorical variables
    + plot_bar()

Each function works in the same way--pass a data frame to the function, and vasco will return n plots, given the number of numeric or categorical variables.  For data frames with greater than 50 variables, pass parameter `n` to override the `plot_check()` helper function.

### plot_density()

```r
plot_density(iris)

purrr::map_dfc(1:60, rnorm, n = 100, sd = 1) %>% 
    plot_density(n = 60)
```

### plot_histogram()

```r
plot_histogram(iris)
```

### plot_bar()

```r
plot_bar(iris)
```

