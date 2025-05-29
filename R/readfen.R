#' @title readfen
#'
#' @description read fen (Forsyth–Edwards Notation) notation
#'
#' @param fenstring fen string (pieces and turn)
#'
#' @return board and turn
#' @export
#'
#' @examples
#' readfen("r3kb1r/pp1nqppp/4bp2/2p5/3P4/1B3N2/PPP1QPPP/R1B1K2R w")
#'


#fenstring <- "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w"

readfen <- function(fenstring) {
  fenstring2 <- unlist(strsplit(fenstring, " "))[1] # takes first part o FEN (before blank)

  fenstrip <- unlist(strsplit(fenstring2, ""))
  fenfin <- c()
  for (x in fenstrip) {
    if (is.na(suppressWarnings(as.numeric(x)))) {
      fenfin<- c(fenfin, x)
    } else {
      fenfin <- c(fenfin, rep("", as.numeric(x)))
    }
  }

  fenfin <- subset(fenfin, fenfin != "/")

  fenfin <- ifelse(fenfin == "", "",
                   ifelse(fenfin %in% letters, paste0(toupper(fenfin), "b"), paste0(toupper(fenfin), "w")))

  fenfin <- gsub("P", "p", fenfin)

  currentboard <- matrix(data = fenfin, 8, 8, byrow = T,
                          dimnames = list(c("8", "7", "6", "5", "4", "3", "2", "1"), c(letters[1:8])))

  turn <- ifelse(unlist(strsplit(fenstring, " "))[2] == "w", 1, -1)

  list(board = currentboard, turn = turn, history = c())
}


