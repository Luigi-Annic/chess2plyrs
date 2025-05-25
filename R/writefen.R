#' @title writefen
#'
#' @description write fen
#'
#' @param game chess game object (i.e., a list with elements board, turn, history, and fen_history
#'              as created by newgame function)
#' @param cb  chess board if cb_tf_insteadof_game set to TRUE
#' @param tb  turn if cb_tf_insteadof_game set to TRUE
#' @param cb_tb_insteadof_game if FALSE, uses game to create fen, if TRUE it uses cb and tb
#'
#' @return fen
#' @export
#'


writefen <- function(game, cb = NULL, tb = NULL, cb_tb_insteadof_game = FALSE) {

  if (cb_tb_insteadof_game == FALSE) {

   currentboard = game$board
   turn = game$turn

  } else {
    currentboard = cb
    turn = tb
   }

  currentboard2 <- ifelse(substr(currentboard, 2, 2) == "w", toupper(substr(currentboard, 1, 1)),
                          tolower(substr(currentboard, 1, 1)))

  currentboard3 <- ifelse(currentboard2 == "", 1, currentboard2)
  # 1) read matrix pieces by row
  tot <- c()
  for (j in 1:8){
    row <- if (j<=7) c(currentboard3[j,], "/") else currentboard3[j,]
    tot <- c(tot, row)
  }

  tot2 <- paste0(tot, collapse = "")

  tot2 <- gsub("11111111", "8", tot2)
  tot2 <- gsub("1111111", "7", tot2)
  tot2 <- gsub("111111", "6", tot2)
  tot2 <- gsub("11111", "5", tot2)
  tot2 <- gsub("1111", "4", tot2)
  tot2 <- gsub("111", "3", tot2)
  tot2 <- gsub("11", "2", tot2)

  fen <- if (turn == 1) paste0(tot2, " w") else paste0(tot2, " b")

  fen
}
