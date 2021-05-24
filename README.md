
<!-- README.md is generated from README.Rmd. Please edit that file -->

# tidyipea

<!-- badges: start -->

[![](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)
[![R-CMD-check](https://github.com/schoulten/tidyipea/workflows/R-CMD-check/badge.svg)](https://github.com/schoulten/tidyipea/actions)
[![](https://img.shields.io/github/last-commit/schoulten/tidyipea.svg)](https://github.com/schoulten/tidyipea/commits/master)
[![License:
MIT](https://img.shields.io/badge/license-MIT-blue.svg)](https://cran.r-project.org/web/licenses/MIT)
<!-- badges: end -->

The goal of **tidyipea** is to provide access to Instituto de Pesquisa
Econômica Aplicada (IPEA) dataset, available by the [IPEADATA
API](http://www.ipeadata.gov.br/api/).

This is a work still in a very preliminary stage and probably does not
cover all the possibilities of API features or provides adequate
robustness against errors, but it can be an alternative to other
packages currently archived on CRAN (see [related works](#related-works)
below).

## Installation

<!-- You can install the released version of tidyipea from [CRAN](https://CRAN.R-project.org) with: -->
<!-- ``` r -->
<!-- install.packages("tidyipea") -->
<!-- ``` -->

You can install the development version from
[GitHub](https://github.com/schoulten/tidyipea) with:

``` r
# install.packages("devtools")
devtools::install_github("schoulten/tidyipea")
```

## Example

This is a basic example which shows you how to get IPEADATA series:

``` r
library(tidyipea)
library(dplyr)

# Get CAGED data
my_tbl <- tidyipea::get_ipea(code = c("CAGED12_SALDON12", "CAGED12_DESLIGN12"))

dplyr::glimpse(my_tbl)
#> Rows: 30
#> Columns: 3
#> $ date  <date> 2020-01-01, 2020-02-01, 2020-03-01, 2020-04-01, 2020-05-01, 202~
#> $ value <dbl> 66818, 188869, -207401, -860503, -331901, -10984, 131010, 249388~
#> $ code  <fct> CAGED12_SALDON12, CAGED12_SALDON12, CAGED12_SALDON12, CAGED12_SA~
```

To see all available IPEADATA series codes, run this:

``` r
all_codes <- tidyipea::codes_ipea()

dplyr::glimpse(all_codes)
#> Rows: 8,874
#> Columns: 7
#> $ code       <chr> "ABATE_ABPEAV", "ABATE_ABPEBV", "ABATE_ABPESU", "ABATE_ABQU~
#> $ name       <chr> "Abate - aves - peso das carcaças", "Abate - bovinos - peso~
#> $ theme      <fct> Macroeconomic, Macroeconomic, Macroeconomic, Macroeconomic,~
#> $ source     <fct> IBGE/Coagro, IBGE/Coagro, IBGE/Coagro, IBGE/Coagro, IBGE/Co~
#> $ freq       <fct> Yearly, Yearly, Yearly, Yearly, Yearly, Yearly, Monthly, Mo~
#> $ lastupdate <date> 2021-03-18, 2021-03-18, 2021-03-18, 2021-03-18, 2021-03-18~
#> $ status     <fct> Active, Active, Active, Active, Active, Active, Inactive, A~
```

## Related works

Check out some similar works:

-   [ipeadatar](https://github.com/gomesleduardo/ipeadatar): An R
    package for Ipeadata API database
-   [ecoseries](https://github.com/fernote7/ecoseries): function to
    capture BACEN, Ipeadata and Sidra series using their APIs
