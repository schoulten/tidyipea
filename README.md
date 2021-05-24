
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
Econômica Aplicada (IPEA) dataset, available by the IPEADATA API
<http://www.ipeadata.gov.br/api/>.

This is a work still in a very preliminary stage and probably does not
cover all the possibilities of API features or provides adequate
robustness against errors. mas pode ser uma alternativa de uso em
relação a outros pacotes arqudos do CRAN

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
my_tbl <- get_ipea(code = c("CAGED12_SALDON12", "CAGED12_DESLIGN12"))

dplyr::glimpse(my_tbl)
```

To see all available IPEADATA series codes, run this:

``` r
all_codes <- codes_ipea()

dplyr::glimpse(all_codes)
```

## Related works

Check out some similar works:

-   [ipeadatar](https://github.com/gomesleduardo/ipeadatar): An R
    package for Ipeadata API database
-   [ecoseries](https://github.com/fernote7/ecoseries): function to
    capture BACEN, Ipeadata and Sidra series using their APIs
