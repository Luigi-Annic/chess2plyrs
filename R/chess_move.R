#' @title chess_move
#'
#' @description Takes in input a move, evaluates whether it is legal,
#'             and if it is, then the game is updated
#'
#' @param game chess game object (i.e., a list with elements board, turn, history, and fen_history
#'              as created by newgame function)
#' @param piece letter indicating the piece to be moved (p, N, B, R, Q, K)
#' @param initialposition initial square of the piece
#' @param finalposition destination square
#'
#' @return makes move
#' @export
#'
#' @examples
#' newgame() |>
#' chess_move("N", "g1", "f3")
#'

chess_move <- function(game, piece, initialposition = "", finalposition = "") {

  currentboard = game$board
  turn = game$turn
  history = game$history
  fen_history = game$fen_history

  currentboard0 <- currentboard

  myself <- ifelse(game$turn == 1, "w", "b")

  if (grepl("e.p.", paste0(all_possibilities(game)[[myself]][[paste0(piece, myself, "_", initialposition)]], collapse = "")) &
      paste0(finalposition, "_e.p.") %in% all_possibilities(game)[[myself]][[paste0(piece, myself, "_", initialposition)]]) {

    currentboard[which(chess2plyrs::chesstools$tilenames == finalposition)] <- currentboard[which(chess2plyrs::chesstools$tilenames == initialposition)]
    currentboard[which(chess2plyrs::chesstools$tilenames == initialposition)] <- ""
    currentboard[which(chess2plyrs::chesstools$tilenames == paste0(substr(finalposition,1,1), substr(initialposition,2,2)))] <- ""

    move <- paste0(piece, initialposition, "x", finalposition, " e.p.")
    history <- c(history, move)
    turn <- ifelse(length(history)%%2 == 0, 1, -1)
    fen_history = c(fen_history, writefen(game, cb = currentboard, tb = turn, cb_tb_insteadof_game = TRUE))

  } else if (finalposition %in% all_possibilities(game)[[myself]][[paste0(piece, myself, "_", initialposition)]]) {

    if (finalposition == "0-0") { # if you are not in check, you may want to castle
      castlingrow <- ifelse(game$turn == 1, "1", "8")

      currentboard[which(chess2plyrs::chesstools$tilenames == paste0("g", castlingrow))] <- currentboard[which(chess2plyrs::chesstools$tilenames == paste0("e", castlingrow))]
      currentboard[which(chess2plyrs::chesstools$tilenames == paste0("f", castlingrow))] <- currentboard[which(chess2plyrs::chesstools$tilenames == paste0("h", castlingrow))]

      currentboard[which(chess2plyrs::chesstools$tilenames == paste0("e", castlingrow))] <- ""
      currentboard[which(chess2plyrs::chesstools$tilenames == paste0("h", castlingrow))] <- ""

      move <- paste0("Ke", castlingrow, "_0-0")
      history <- c(history, move)
      turn <- ifelse(length(history)%%2 == 0, 1, -1)
      fen_history = c(fen_history, writefen(game, cb = currentboard, tb = turn, cb_tb_insteadof_game = TRUE))

    } else if (finalposition == "0-0-0") {
      castlingrow <- ifelse(game$turn == 1, "1", "8")

      currentboard[which(chess2plyrs::chesstools$tilenames == paste0("c", castlingrow))] <- currentboard[which(chess2plyrs::chesstools$tilenames == paste0("e", castlingrow))]
      currentboard[which(chess2plyrs::chesstools$tilenames == paste0("d", castlingrow))] <- currentboard[which(chess2plyrs::chesstools$tilenames == paste0("a", castlingrow))]

      currentboard[which(chess2plyrs::chesstools$tilenames == paste0("a", castlingrow))] <- ""
      currentboard[which(chess2plyrs::chesstools$tilenames == paste0("e", castlingrow))] <- ""

      move <- paste0("Ke", castlingrow, "_0-0-0")
      history <- c(history, move)
      turn <- ifelse(length(history)%%2 == 0, 1, -1)
      fen_history = c(fen_history, writefen(game, cb = currentboard, tb = turn, cb_tb_insteadof_game = TRUE))

    } else { # or any other move!

      currentboard[which(chess2plyrs::chesstools$tilenames == finalposition)] <- currentboard[which(chess2plyrs::chesstools$tilenames == initialposition)]
      currentboard[which(chess2plyrs::chesstools$tilenames == initialposition)] <- ""

      # promotion of pawns in 1st/8th row (always to queen for now)
      if (piece == "p" & unlist(strsplit(finalposition, ""))[2] %in% c(1,8)) {
        currentboard[which(chess2plyrs::chesstools$tilenames == finalposition)] <- paste0("Q", ifelse(turn == 1, "w", "b"))
      }

      # Enforce capture notation if piece is captured (x)
      #move <- paste0(piece$label, initialposition, "-", finalposition)
      move <- if (currentboard0[chess2plyrs::chesstools$tilenames == finalposition] == "") {
        paste0(piece, initialposition, "-", finalposition)
      } else {
        paste0(piece, initialposition, "x", finalposition)
      }

      if (piece == "p" & unlist(strsplit(finalposition, ""))[2] %in% c(1,8)) move <-paste0(move, "=Q")


      history <- c(history, move)
      turn <- ifelse(length(history)%%2 == 0, 1, -1)
      fen_history = c(fen_history, writefen(game, cb = currentboard, tb = turn, cb_tb_insteadof_game = TRUE))
    }


  } else {
    message("Move not valid")
    history <- history
    fen_history = fen_history
  }


  return(list(board = currentboard, turn = turn,
              history = history, fen_history = fen_history))
}



