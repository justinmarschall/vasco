# vasco

An R package for exploring your data.

## Purpose

`vasco` leverages [`purrr`](https://purrr.tidyverse.org/) and [`ggplot2`](https://ggplot2.tidyverse.org/) to iterate through an entire data frame, producing plots for *all* variables of a given type.

## Usage

There are four main functions in the vasco library:

+ Plotting numeric variables
    + `plot_density()`
    + `plot_histogram()`
    + `plot_scatter()`
+ Plotting categorical variables
    + `plot_bar()`

Each function works in the same way--pass a data frame to the function, and `vasco` will return *n* plots, given the number of numeric or categorical variables.  For data frames with greater than 50 variables, pass parameter `n` to override the `plot_check()` helper function.  It's recommended to write many plots to PDF to improve readability.

### Numeric Variables

```r
plot_density(iris)

plot_histogram(iris)

plot_scatter(iris)
```

### Categorical Variables

```r
plot_bar(iris)
```

### Plotting Many Variables

```r
setwd("U:/your_file_path")

pdf("your_file_name.pdf", width = 14, height = 8.5)

purrr::map_dfc(1:60, rnorm, n = 100, sd = 1) %>% 
    plot_density(n = 60)

dev.off()
```

