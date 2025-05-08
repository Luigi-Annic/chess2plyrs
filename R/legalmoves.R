#' @title legalmoves
#'
#' @description lists legal moves
#'
#' @param turn turn
#'
#' @return character vector
#' @export
#'
#' @examples
#' game <- newgame()
#' legalmoves()
#'

legalmoves <- function(turn = game$turn){

  myself <- ifelse(turn == 1, "w", "b")

  lg <- all_possibilities()[[myself]]


  unlist(lapply(1:length(unlist(lg)),
                function(x) paste0(substr(names(unlist(lg))[x] ,1,1),
                                   substr(names(unlist(lg))[x] ,4,5),
                                   unlist(lg)[x])))
}
