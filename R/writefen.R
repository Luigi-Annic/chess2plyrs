#' @title writefen
#'
#' @description writes fen
#'
#' @param currentboard currentboard
#' @param turn game$turn
#'
#' @return fen
#' @export
#'


writefen <- function(currentboard = game$board,
                     turn = game$turn) {

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
