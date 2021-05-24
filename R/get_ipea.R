#' Get IPEADATA series
#'
#' @param code Character vector with series code.
#'
#' @return A tibble with data from IPEADATA
#' @description This function provides the extraction of data using IPADATA's API <http://www.ipeadata.gov.br/api/>.
#' @details See the [codes_ipea()] to available series codes and other information.
#' @encoding UTF-8
#' @export
#'
#' @examples
#' get_ipea(c("CAGED12_SALDON12", "CAGED12_DESLIGN12"))
get_ipea <- function(code){

  # Check if argument is character
  if (purrr::is_character(code) & !purrr::is_null(code)) {
    code <- toupper(code)
  } else stop("Code argument must be a character, check the argument.", call. = FALSE)

  # Ler página
  raw_dados <- try(
    suppressWarnings(
      purrr::map(
        .x = purrr::map(
          .x = code,
          ~paste0(
            "http://www.ipeadata.gov.br/api/odata4/ValoresSerie(SERCODIGO='",
            .x,
            "')"
          )
        ),
        ~jsonlite::fromJSON(.x)
      )
    ),
    silent = TRUE
  )

  # Warning message for series with null return
  if (0 %in% purrr::map(
    .x = 1:length(code) %>% purrr::set_names(code),
    ~length(raw_dados[[.x]][["value"]]))
  ) {

    flag <- purrr::map(
      .x = 1:length(code) %>% purrr::set_names(code),
      ~length(raw_dados[[.x]][["value"]])
    ) %>%
      dplyr::as_tibble() %>%
      tidyr::pivot_longer(colnames(.)) %>%
      dplyr::filter(value == 0)

    if (0 %in% flag$value) {

      stop(
        paste0(
          "Code [",
          paste(flag$name, collapse = ", "),
          "] not available / not found in IPEADATA."
        ),
        call. = FALSE
      )

    }

  }

  # Data wrangling
  dados <- purrr::map(.x = 1:length(code), ~raw_dados[[.x]][["value"]]) %>%
    dplyr::bind_rows() %>%
    dplyr::select("date" = `VALDATA`, "value" = `VALVALOR`, "code" = `SERCODIGO`) %>%
    dplyr::mutate(
      date = lubridate::as_date(date),
      code = as.factor(code)
    ) %>%
    dplyr::as_tibble()

  return(dados)

}
