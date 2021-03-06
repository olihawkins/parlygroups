# Main functions for retrieving details on APPGs

#' Fetch details on APPG groups
#'
#' \code{appg_groups} retrieves basic details on the names of APPGs, their
#' purpose and category type. Each row is one APPG.
#'
#' If no parameters are supplied the function will return all APPGs.
#'
#' @param appg A character string of an APPG title written within a pair of single
#' qoute or double qoutes. Can be a vector with more than one element. By default
#' all APPG titles are selected.
#' @param category A characer string of a APPG type written within a pair of single
#' qoute or double qoutes. APPG types available: Country, Subject, Club. Can be a
#' vector with more than one element. By default all APPG types are selected.
#'
#' @return A tibble of basic details of APPGs, with one row per APPG.
#' @examples
#' appg_groups()
#' appg_groups(category = "Subject")
#' @export

appg_groups <- function(appg = NA, category = NA) {

  # Get group table
  table <- get_cached_tables("groups")

  # Filter if arguments used
  table <- filter_basic(table, appg, table$title)
  table <- filter_basic(table, category, table$category)

  # Return
  table
}

#' Fetch details on officers of APPGs
#'
#' \code{appg_officers} retrieves details on which MPs and Lords are officers
#' of APPGs along with their role and party affiliation. Each row is one
#' APPG officer.
#'
#' If no parameters are supplied the function will return all APPG officers.
#'
#' @param appg A character string of an APPG title written within a pair of single
#' qoute or double qoutes. Can be a vector with more than one element. By default
#' all APPG titles are selected.
#' @param category A characer string of a APPG type written within a pair of single
#' qoute or double qoutes. APPG types available: Country, Subject, Club. Can be a
#' vector with more than one element. By default all APPG types are selected.
#' @param officer A character string of an APPG officer written within a pair of
#' single qoute or double qoutes. Can be a vector with more than one element.
#' By default all APPG officers are selected.
#' @param party A character string of a political party/grouping within the House
#' of Commons or House of Lords written within a pair of single qoute or double
#' qoutes. Can be a vector with more than one element. By default all parties are
#' selected.
#'
#' @return A tibble of details on APPG officers, with one row per APPG
#' officer.
#' @examples
#' appg_officers()
#' appg_officers(officer = c("Chi Onwurah", "Lord Chidgey"))
#' appg_officers(officer = "Chi Onwurah", category = "Subject")
#' @export

appg_officers <- function(appg = NA, category = NA, officer = NA, party = NA) {

  # Get members table
  table <- get_cached_tables(get = "officers")

  # Filter if parameters used
  table <- filter_basic(table, appg, table$title)
  table <- filter_basic(table, category, table$category)
  table <- filter_basic(table, officer, table$officer_name)
  table <- filter_basic(table, category, table$category)
  table <- filter_basic(table, party, table$officer_party)

  # Return
  table
}

#' Fetch details on APPG financial funding
#'
#' \code{appg_financial} retrieves details on financial funding given
#' to APPGs along with the source and value of the funding, date recieved and
#' registered. Each row is one APPG financial funding record.
#'
#' If no parameters are supplied the function will return a tibble of all
#' financial funding given to APPGs.
#'
#' @param appg A character string of an APPG title written within a pair of single
#' qoute or double qoutes. Can be a vector with more than one element. By default
#' all APPG titles are selected.
#' @param category A characer string of a APPG type written within a pair of single
#' qoute or double qoutes. APPG types available: Country, Subject, Club. Can be a
#' vector with more than one element. By default all APPG types are selected.
#' @param source A character string of the source of financial funding written
#' within a pair of single qoute or double qoutes. Can be a vector with more than
#' one element. By default all sources are selected.
#' @param value_from A non-negative numeric indicating the value of the financial
#' funding. By default the minimum value in the data is used.
#' @param value_to A non-negative numeric indicating the value of the financial
#' funding. By default the maximum value if the data is used.
#' @param received_from A character string of the date when the financial
#' funding was received written within a pair of single qoute
#' or double qoutes. The date must be in ISO 8601 format, i.e. ("YYYY-MM-DD").
#' By default the earliest date in the data is used.
#' @param received_to A character string of the date when the financial
#' funding was received written within a pair of single qoute
#' or double qoutes. The date must be in ISO 8601 format, i.e. ("YYYY-MM-DD").
#' By default the latest date in the data is used.
#' @param registered_from A character string of the date when the financial
#' funding was registered written within a pair of single qoute
#' or double qoutes. The date must be in ISO 8601 format, i.e. ("YYYY-MM-DD").
#' By default the earliest date in the data is used.
#' @param registered_to A character string of the date when the financial
#' funding was registered written within a pair of single qoute
#' or double qoutes. The date must be in ISO 8601 format, i.e. ("YYYY-MM-DD").
#' By default the latest date in the data is used.
#' @return A tibble of key details on APPG financial funding, with one
#' row per APPG financial funding.
#' @examples
#' appg_financial()
#' appg_financial(category = "Subject", value_from = 1000, value_to = 2000)
#' appg_financial(received_from = "2018-01-01", received_to = "2018-06-01")
#' @export

appg_financial <- function(
  appg = NA,
  category = NA,
  source = NA,
  value_from = NA,
  value_to = NA,
  received_from = NA,
  received_to = NA,
  registered_from = NA,
  registered_to = NA) {

  # Get financial table
  table <- get_cached_tables(get = "financial")

  # Filter if arguments used
  table <- filter_basic(table, appg, table$title)
  table <- filter_basic(table, category, table$category)
  table <- filter_basic(table, source, table$financial_source)
  table <- filter_value(table, value_from, value_to, table$financial_value)
  table <- filter_date(table, received_from, received_to, table$financial_received)
  table <- filter_date(table, registered_from, registered_to, table$financial_registered)

  # Return
  table
}

#' Fetch details on APPG benefits in kind
#'
#' \code{appg_benefits} retrieves details on benefits in kind given
#' to APPGs along with the source of the benefit, benefit value range, date
#' recieved and registered. Each row is one APPG benefit in kind record.
#'
#' If no parameters are supplied the function will return a tibble of all
#' benefits in kind to APPGs.
#'
#' @param appg A character string of an APPG title written within a pair of single
#' qoute or double qoutes. Can be a vector with more than one element. By default
#' all APPG titles are selected.
#' @param category A characer string of a APPG type written within a pair of single
#' qoute or double qoutes. APPG types available: Country, Subject, Club. Can be a
#' vector with more than one element. By default all APPG types are selected.
#' @param source A character string of the source of benefit in kind written
#' within a pair of single qoute or double qoutes. Can be a vector with more than
#' one element. By default all sources are selected.
#' @param low_value_from A non-negative numeric indicating the lower value range
#' of the benefit in kind. By default the minimum value in the data is used.
#' @param low_value_to A non-negative numeric indicating the lower value range
#' of the benefit in kind. By default the maximum value if the data is used.
#' @param high_value_from A non-negative numeric indicating the higher value range
#' of the benefit in kind. By default the minimum value in the data is used.
#' @param high_value_to A non-negative numeric indicating the higher value range
#' of the benefit in kind. By default the maximum value if the data is used.
#' @param received_from A character string of the date when the benefit
#' in kind was received written within a pair of single qoute
#' or double qoutes. The date must be in ISO 8601 format, i.e. ("YYYY-MM-DD").
#' By default the earliest date in the data is used.
#' @param received_to A character string of the date when the benefit
#' in kind was received written within a pair of single qoute
#' or double qoutes. The date must be in ISO 8601 format, i.e. ("YYYY-MM-DD").
#' By default the latest date in the data is used.
#' @param registered_from A character string of the date when the benefit
#' in kind was registered written within a pair of single qoute
#' or double qoutes. The date must be in ISO 8601 format, i.e. ("YYYY-MM-DD").
#' By default the earliest date in the data is used.
#' @param registered_to A character string of the date when the benefit
#' in kind was registered written within a pair of single qoute
#' or double qoutes. The date must be in ISO 8601 format, i.e. ("YYYY-MM-DD").
#' By default the latest date in the data is used.
#' @return A tibble of key details on APPG benefits in kind, with one
#' row per APPG benefit in kind.
#' @examples
#' appg_benefits()
#' appg_benefits(category = "Subject", low_value_from = 1000, low_value_to = 2000)
#' appg_benefits(received_from = "2018-01-01", received_to = "2018-06-01")
#' @export

appg_benefits <- function(
  appg = NA,
  category = NA,
  source = NA,
  low_value_from = NA,
  low_value_to = NA,
  high_value_from = NA,
  high_value_to = NA,
  received_from = NA,
  received_to = NA,
  registered_from = NA,
  registered_to = NA) {

  # Get benefits table
  table <- get_cached_tables(get = "benefits")

  # Filter if arguments used
  table <- filter_basic(table, appg, table$title)
  table <- filter_basic(table, category, table$category)
  table <- filter_basic(table, source, table$financial_source)
  table <- filter_value(table, low_value_from, low_value_to, table$benefit_value_lower)
  table <- filter_value(table, high_value_from, high_value_to, table$benefit_value_higher)
  table <- filter_date(table, received_from, received_to, table$benefit_received)
  table <- filter_date(table, registered_from, registered_to, table$benefit_registered)

  # Return
  table
}

#' Fetch details on APPG Annual General Meetings
#'
#' \code{appg_agm} retrieves details on APPG Annual General Meetings
#' along with whether a financial statement was issued, the latest AGM meeting
#' and reporting year. Each row is one APPG AGM record.
#'
#' If no parameters are supplied the function will return a tibble of all
#' APPG AGMs.
#'
#' @param appg A character string of an APPG title written within a pair of single
#' qoute or double qoutes. Can be a vector with more than one element. By default
#' all APPG titles are selected.
#' @param category A characer string of a APPG type written within a pair of single
#' qoute or double qoutes. APPG types available: Country, Subject, Club. Can be a
#' vector with more than one element. By default all APPG types are selected.
#' @param statement A character string of Yes or No as to whether the APPG issued
#' a financial statment at the latest AGM written within a pair of single qoute
#' or double qoutes. By default both Yes and No is selected.
#' @param latest_agm_from A character string of the date of the latest AGM
#' written within a pair of single qoute or double qoutes. The date must be
#' in ISO 8601 format, i.e. ("YYYY-MM-DD"). By default the earliest date in
#' the data is used.
#' @param latest_agm_to A character string of the date of the latest AGM
#' written within a pair of single qoute or double qoutes. The date must be
#' in ISO 8601 format, i.e. ("YYYY-MM-DD"). By default the latest date in
#' the data is used.
#' @param deadline_from A character string of the date of the reporting
#' deadline written within a pair of single qoute or double qoutes.
#' The date must be in ISO 8601 format, i.e. ("YYYY-MM-DD"). By default the
#' earliest date in the data is used.
#' @param deadline_to A character string of the date of the reporting
#' deadline written within a pair of single qoute or double qoutes.
#' The date must be in ISO 8601 format, i.e. ("YYYY-MM-DD"). By default the
#' latest date in the data is used.
#' @return A tibble of key details on APPG Annual General Meetings, with one
#' row per APPG AGM.
#' @examples
#' appg_agm()
#' appg_agm(category = "Subject", statement = "No")
#' appg_agm(deadline_from = "2019-11-01", deadline_to = "2020-06-01")
#' @export

appg_agm <- function(
  appg = NA,
  category = NA,
  statement = NA,
  latest_agm_from = NA,
  latest_agm_to = NA,
  deadline_from = NA,
  deadline_to = NA) {

  # Get agm table
  table <- get_cached_tables(get = "agm")

  # Filter if arguments used
  table <- filter_basic(table, appg, table$title)
  table <- filter_basic(table, category, table$category)
  table <- filter_basic(table, statement, table$statement)
  table <- filter_date(table, latest_agm_from, latest_agm_to, table$latest_agm)
  table <- filter_date(table, deadline_from, deadline_to, table$reporting_deadline)

  # Return
  table
}
