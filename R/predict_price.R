
#' Predicts price
#'
#' @param city City name
#' @param district District name
#' @param rooms Number of rooms
#' @param floor Floor number
#' @param total_floors Total floors in the house
#' @param square Square meters for the flat
#' @param square_useful Useful square
#' @param kitchen Square meters for kitchen
#' @param type House type
#'
#' @return Flat price
#'
#' @export
#'
predict_price <- function(city = "Минск",
                          district = "Заводской р-н",
                          rooms = 2,
                          floor = 3,
                          total_floors = 8,
                          square = 45,
                          square_useful = 28,
                          kitchen = 6.5,
                          type = "панельный") {

  # Pre-processing
  city %<>% iconv(to = "UTF-8")
  district %<>% iconv(to = "UTF-8")
  type %<>% iconv(to = "UTF-8")

  # Reads model data
  all_levels <- readRDS(system.file("extdata/levels.RData", package = "realtr"))
  dummies <- readRDS(system.file("extdata/dummies.RData", package = "realtr"))
  model_rf <- readRDS(system.file("extdata/rf.RData", package = "realtr"))

  # Prepares data
  new_house <-
    data_frame(city = city,
               district = district,
               rooms = rooms,
               floor = floor,
               total_floors = total_floors,
               square = square,
               square_useful = square_useful,
               kitchen = kitchen,
               type = type) %>%
    mutate(district = factor(district, levels = all_levels$district),
           type = factor(type, levels = all_levels$type),
           useful = square_useful / square,
           is_first_floor = as.numeric(floor == 1),
           is_last_floor = as.numeric(floor == total_floors),
           price = 0) %>%
    mutate_each(funs(log), square, kitchen) %>%
    select(-city, -floor, -total_floors, -square_useful)

  # Extends data
  data_new_house <- data.frame(predict(dummies, newdata = new_house)) %>% tbl_df()

  # Makes prediction & returns
  new_price <- predict(model_rf, newdata = data_new_house %>% select(-price))
  exp(new_price) %>% as.numeric()
}

