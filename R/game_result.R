#' @title game_result
#'
#' @description This function tells if the game is still ongoing,
#' or if a checkamte or stalemate are on the board
#'
#' @param game chess game object (i.e., a list with elements board, turn, history, and fen_history
#'              as created by newgame function)
#'
#' @return a message
#' @export
#'



game_result <- function(game) {

  currentboard = game$board
  turn = game$turn

  playersturn <- ifelse(turn == 1, "w", "b")
  color <- ifelse(playersturn == "w", "white", "black")
  other <- ifelse(playersturn == "w", "black", "white")

  if (length(as.character(unlist(all_possibilities(game)[[playersturn]]))) == 0) {
    if (length(kingcheck(game, legalmoves = all_possibilities(game))) > 0) {
      game_ended <- 1
      message("Checkmate! End of the game")
      message(paste0(other, " wins"))
    } else {
      game_ended <- 1
      message("Stalemate! Draw")
    }
  } else {
    game_ended <- 0
    message("There are still legal moves available, the game is ongoing")
    message(paste0("To move: " , color))
  }

  return(game_ended)

}
