#' Get available series from IPEADATA
#'
#' @param language 	String specifying the selected language. Language options are English ("en", default) and Brazilian portuguese ("br").
#'
#' @return Tibble containing Ipeadata code, name, theme, source, frequency, last update and activity status of available series.
#' @description Returns a tibble with available series from IPEADATA'S API.
#' @encoding UTF-8
#' @export
#'
#' @examples
#' all_codes <- codes_ipea()
codes_ipea <- function(language = c("en", "br")) { #f unction from IPEADATAR with MIT license

  # Check language arg
  language <- match.arg(language)

  # URL for metadata
  url <- 'http://www.ipeadata.gov.br/api/odata4/Metadados/'

  # Get data
  series <- jsonlite::fromJSON(url, flatten = TRUE)[[2]] %>%
    dplyr::as_tibble() %>%
    dplyr::select(
      c(
        'SERCODIGO', 'SERNOME', 'BASNOME', 'FNTSIGLA',
        'PERNOME', 'SERATUALIZACAO', 'SERSTATUS'
        )
      ) %>%
    dplyr::mutate(
      FNTSIGLA       = as.factor(FNTSIGLA),
      SERATUALIZACAO = lubridate::as_date(SERATUALIZACAO),
      SERSTATUS      = as.character(SERSTATUS) %>%
        dplyr::if_else(is.na(.), '', .)
      )

  # Setting labels in selected language
  if (language == 'en') {

    series <- series %>%
      dplyr::mutate(
        SERSTATUS = factor(
          SERSTATUS,
          levels = c('A', 'I', ''),
          labels =  c('Active', 'Inactive', '')
          ),
        PERNOME = iconv(PERNOME, 'UTF-8', 'ASCII//TRANSLIT') %>%
          factor(
            levels = c(
              'Anual', 'Decenal', 'Diaria', 'Irregular',
              'Mensal', 'Quadrienal', 'Quinquenal',
              'Semestral', 'Trimestral', 'Nao se aplica'
              ),
            labels = c(
              'Yearly', 'Decennial', 'Daily', 'Irregular',
              'Monthly', 'Quadrennial', 'Quinquennial',
              'Semiannual', 'Quarterly', 'Not applicable'
              )
            ),
        BASNOME = iconv(BASNOME, 'UTF-8', 'ASCII//TRANSLIT') %>%
          factor(
            levels = c('Macroeconomico', 'Regional', 'Social'),
            labels = c('Macroeconomic', 'Regional', 'Social')
            )
        ) %>%
      purrr::set_names(
        c('code', 'name', 'theme', 'source', 'freq', 'lastupdate', 'status')
        )

  } else {

    series <- series
      dplyr::mutate(
        SERSTATUS = factor(
          SERSTATUS,
          levels = c('A', 'I', ''),
          labels =  c('Ativa', 'Inativa', '')
          ),
        BASNOME = factor(BASNOME),
        PERNOME = factor(PERNOME)
        ) %>%
      purrr::set_names(
        c('code', 'name', 'theme', 'source', 'freq', 'lastupdate', 'status')
        )

  }

  return(series)
}
