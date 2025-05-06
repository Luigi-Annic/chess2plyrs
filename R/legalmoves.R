#' @title legalmoves
#'
#' @description lists legal moves
#'
#'
#' @return character vector
#' @export
#'

legalmoves <- function(){

  turn <- game$turn
  myself <- ifelse(turn == 1, "w", "b")

  lg <- all_possibilities()[[myself]]
  turn = game$turn

  unlist(lapply(1:length(unlist(lg)),
                function(x) paste0(substr(names(unlist(lg))[x] ,1,1),
                                   substr(names(unlist(lg))[x] ,4,5),
                                   unlist(lg)[x])))
}
