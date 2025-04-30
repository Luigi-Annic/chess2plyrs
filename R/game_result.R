#' @title game_result
#'
#' @description # game ending check
#'
#' @param currentboard game$currentboard
#' @param turn game4turn
#'
#' @return a message
#' @export
#'



game_result <- function(currentboard = game$board, turn = game$turn) {
  playersturn <- ifelse(turn == 1, "w", "b")
  color <- ifelse(playersturn == "w", "white", "black")
  other <- ifelse(playersturn == "w", "black", "white")

  if (length(as.character(unlist(all_possibilities()[[playersturn]]))) == 0) {
    if (length(kingcheck(currentboard = currentboard, turn = turn, legalmoves = all_possibilities(currentboard = currentboard))) > 0) {
      message("Checkmate! End of the game")
      message(paste0(other, " wins"))
    } else {
      message("Stalemate! Draw")
    }
  } else {
    message("There are still legal moves available, the game is ongoing")
    message(paste0("To move: " , color))
  }

}
