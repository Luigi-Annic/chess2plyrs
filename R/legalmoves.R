#' @title legalmoves
#'
#' @description lists legal moves
#'
#' @param game chess game object (i.e., a list with elements board, turn, history, and fen_history
#'              as created by newgame function)
#'
#' @return character vector
#' @export
#'
#' @examples
#' newgame() |>
#' legalmoves()
#'

legalmoves <- function(game){
  turn = game$turn
  myself <- ifelse(turn == 1, "w", "b")

  lg <- all_possibilities(game)[[myself]]


  unlist(lapply(1:length(unlist(lg)),
                function(x) paste0(substr(names(unlist(lg))[x] ,1,1),
                                   substr(names(unlist(lg))[x] ,4,5),
                                   unlist(lg)[x])))
}
