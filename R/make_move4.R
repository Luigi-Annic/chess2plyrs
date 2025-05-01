#' @title make_move4
#'
#' @description makes move
#'
#' @param piece piece to be moved
#' @param initialposition initial square of the piece
#' @param finalposition final square
#' @param currentboard game$board
#' @param turn game$turn
#'
#' @return makes move
#' @export
#'


make_move4 <- function(piece, initialposition = "", finalposition = "", currentboard = game$board,
                       turn = game$turn) {

  myself <- ifelse(game$turn == 1, "w", "b")

  if (grepl("e.p.", paste0(all_possibilities()[[myself]][[paste0(piece$label, myself, "_", initialposition)]], collapse = "")) &
      paste0(finalposition, "_e.p.") %in% all_possibilities()[[myself]][[paste0(piece$label, myself, "_", initialposition)]]) {

    currentboard[which(tilenames == finalposition)] <- currentboard[which(tilenames == initialposition)]
    currentboard[which(tilenames == initialposition)] <- ""
    currentboard[which(tilenames == paste0(substr(finalposition,1,1), substr(initialposition,2,2)))] <- ""

    move <- paste0(piece$label, initialposition, "x", finalposition, " e.p.")
    history <- c(game$history, move)
    turn <- ifelse(length(history)%%2 == 0, 1, -1)

  } else if (finalposition %in% all_possibilities()[[myself]][[paste0(piece$label, myself, "_", initialposition)]]) {

    if (finalposition == "0-0") { # if you are not in check, you may want to castle
      castlingrow <- ifelse(game$turn == 1, "1", "8")

      currentboard[which(tilenames == paste0("g", castlingrow))] <- currentboard[which(tilenames == paste0("e", castlingrow))]
      currentboard[which(tilenames == paste0("f", castlingrow))] <- currentboard[which(tilenames == paste0("h", castlingrow))]

      currentboard[which(tilenames == paste0("e", castlingrow))] <- ""
      currentboard[which(tilenames == paste0("h", castlingrow))] <- ""

      move <- paste0("Ke", castlingrow, "_0-0")
      history <- c(game$history, move)
      turn <- ifelse(length(history)%%2 == 0, 1, -1)

    } else if (finalposition == "0-0-0") {
      castlingrow <- ifelse(game$turn == 1, "1", "8")

      currentboard[which(tilenames == paste0("c", castlingrow))] <- currentboard[which(tilenames == paste0("e", castlingrow))]
      currentboard[which(tilenames == paste0("d", castlingrow))] <- currentboard[which(tilenames == paste0("a", castlingrow))]

      currentboard[which(tilenames == paste0("a", castlingrow))] <- ""
      currentboard[which(tilenames == paste0("e", castlingrow))] <- ""

      move <- paste0("Ke", castlingrow, "_0-0-0")
      history <- c(game$history, move)
      turn <- ifelse(length(history)%%2 == 0, 1, -1)

    } else { # or any other move!

      currentboard[which(tilenames == finalposition)] <- currentboard[which(tilenames == initialposition)]
      currentboard[which(tilenames == initialposition)] <- ""

      # promotion of pawns in 1st/8th row (always to queen for now)
      if (piece$label == "p" & unlist(strsplit(finalposition, ""))[2] %in% c(1,8)) {
        currentboard[which(tilenames == finalposition)] <- paste0("Q", ifelse(turn == 1, "w", "b"))
      }

      # Enforce capture notation if piece is captured (x)
      #move <- paste0(piece$label, initialposition, "-", finalposition)
      move <- if (game$board[tilenames == finalposition] == "") {
        paste0(piece$label, initialposition, "-", finalposition)
      } else {
        paste0(piece$label, initialposition, "x", finalposition)
      }

      if (piece$label == "p" & unlist(strsplit(finalposition, ""))[2] %in% c(1,8)) move <-paste0(move, "=Q")


      history <- c(game$history, move)
      turn <- ifelse(length(history)%%2 == 0, 1, -1)
    }


  } else {
    message("Move not valid")
    history <- game$history
  }


  return(list(board = currentboard, turn = turn, history = history))
}



