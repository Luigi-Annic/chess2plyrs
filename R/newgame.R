#' @title newgame
#'
#' @description sets up a new chess game
#'
#' @return new game
#' @export


newgame <- function(){
  list(board = chess2plyrs::chesstools$init,
       turn = 1,
       history = c(),
       fen_history = c("rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w"))
}
