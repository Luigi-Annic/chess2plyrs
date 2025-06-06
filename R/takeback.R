#' @title takeback
#'
#' @description  takeback
#'
#' @param game chess game object (i.e., a list with elements board, turn, history, and fen_history
#'              as created by newgame function)
#'
#' @return game (last move being deleted)
#' @export

takeback <- function(game) {

  game$fen_history <- game$fen_history[-length(game$fen_history)]
  game$board <- readfen(game$fen_history[length(game$fen_history)])$board
  game$history <- game$history[-length(game$history)]

  game$turn <- ifelse(length(game$history)%%2 == 0, 1, -1)

  game
}
