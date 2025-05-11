#' @title random_mover
#'
#' @description engine which chooses randomly between legal moves
#'
#' @param game chess game object (i.e., a list with elements board, turn, history, and fen_history
#'              as created by newgame function)
#'
#' @return game with new move done
#' @export
#'

random_mover <- function(game) {
  chosenone <- sample(legalmoves(game), 1)

  message("Chosen move:")
  message(chosenone)

  make_move4(game,
             piece = substr(chosenone, 1, 1),
             initialposition =  substr(chosenone, 2, 3),
             finalposition =  substr(chosenone, 4, 5))
}






