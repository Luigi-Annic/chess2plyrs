#' @title engine2
#'
#' @description engine which chooses minimax between legal moves, with alpha beta pruning
#'
#' @param game chess game object (i.e., a list with elements board, turn, history, and fen_history
#'              as created by newgame function)
#' @param depth depth of the minimax. depth of 1 and 2 are fairly rapid.
#'
#' @return game with new move done
#' @export
#'

engine2 <- function(game, depth) {

  chosenone <- get_minimax_move2(game, depth = depth, alpha = -1000, beta = 1000)

  message("Chosen move by minimax mover:")
  message(chosenone)

  piece <- substr(chosenone, 1, 1)
  initialposition <-  substr(chosenone, 2, 3)
  finalposition <- if (grepl("0-0-0", chosenone)) "0-0-0" else if (grepl("0-0", chosenone)) "0-0" else substr(chosenone, 4, 5)


  make_move4(game, piece, initialposition, finalposition)
}

