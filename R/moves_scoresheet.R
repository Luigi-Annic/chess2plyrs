#' @title moves_scoresheet
#'
#' @description Creates move scorelist, in scientific notation
#'
#' @param game chess game object (i.e., a list with elements board, turn, history, and fen_history
#'              as created by newgame function)
#' @param shortnotation Use short scientific notation? TRUE is the default
#'
#' @return moves scoresheet
#' @export
#'
#' @examples
#'
#' g <- newgame() |>
#'   chess_move("p", "e2", "e4") |>
#'   chess_move("p", "e7", "e5") |>
#'   chess_move("N", "g1", "f3") |>
#'   chess_move("N", "b8", "c6") |>
#'   chess_move("B", "f1", "b5") |>
#'   chess_move("N", "g8", "f6") |>
#'   chess_move("K", "e1", "0-0")|>
#'   chess_move("N", "f6", "e4")
#' moves_scoresheet(g)
#'


# Creates move scorelist, in beautiful notation
# Note that shortnotation might incur in lack of clarity when two moves are possible
# e.g. when Knight on b3, other Knight on f3, and short move listed as Nd4
# Anyway, the scorelist saved in history also has the starting square so you can look at it in case of doubt

moves_scoresheet <- function(game, shortnotation = TRUE){
  h = game$history

  if (shortnotation == TRUE) {
    h_orig <- h_alt<- h
    substr(h, 2,4) <- "  "
    h <- gsub(" ", "", h)
    h <- gsub("p|_|-", "", h)
    h <- gsub("000", "0-0-0", h)
    h <- gsub("00", "0-0", h)
    h <- gsub("K0-0", "0-0", h)

    substr(h_alt, 1,1) <- substr(h_alt, 3,3) <- " "
    h_alt <- gsub(" ", "", h_alt)

    hfin <- ifelse(paste0(substr(h_orig,1,1), substr(h_orig,4,4)) == "px", h_alt ,h)
  } else hfin = h

  alt <- unlist(lapply(1:length(h), function(j) ifelse(j %%2 == 0, -1, 1)))

  data.frame(n = 1:ceiling(length(h)/2),
             white = hfin[alt == 1],
             black = if (length(h)%%2 == 0) hfin[alt == -1] else c(hfin[alt == -1], ""))
}
