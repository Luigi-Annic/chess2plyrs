#' @title newgame
#'
#' @description sets up a new game
#'
#' @return new game
#' @export


newgame <- function(){
  list(board = chess2plyrs::chesstools$init,
       turn = 1,
       history = c())
}
