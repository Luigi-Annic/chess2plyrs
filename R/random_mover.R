#' @title random_mover
#'
#' @description engine which chooses randomly between legal moves
#'
#' @return game with new move done
#' @export
#'

random_mover <- function() {
  chosenone <- sample(legalmoves(), 1)

  message("Chosen move:")
  message(chosenone)

  make_move4(piece = substr(chosenone, 1, 1),
             initialposition =  substr(chosenone, 2, 3),
             finalposition =  substr(chosenone, 4, 5))
}






