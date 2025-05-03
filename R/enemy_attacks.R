# QUesta funzione riprta tutte le caselle che sono teoricamente attaccate dall'avversario.
# Questo serve per sapere se il re puo andare in quella casa o no.
#
# DIfferisce da all_possibilities[[enemy]] per il fatto che anche le caselle su cui c'e un altro
# pezzo nemico sono segnalate come non praticabili.
#
# Quindi se ho cavallo in f3 e pedone in g5, il re visualizza che non puo andare in g5 oerche difeso
# dal cavallo anche se materialmente il cavallo non potrebbe andare in g5 perche ce un pezzo amico
# ovviamente

# Cattura en passant non e cercata ne segnalata, ma non ci serve finche dobbiamo valutare dove puo e
# dove non puo muoversi il mio re

# Credo che per quanto sia allettante usarla in modo piu diffuso, sia meglio tenere questa funzione
# soltanto per la verifica delle case dove il mio re puo andare in questo momento. Probabilmente meglio
# tenere all_possibilities()[[enemy]] per le altre valutazioni per evitare bug

enemy_attacks <- function(currentboard = game$board, turn = game$turn) {
  myself <- ifelse(turn == 1, "w", "b")
  enemy <- ifelse(game$turn == 1, "b", "w")

  enemymvs <- list()

  for (j in (1 : length(game$board))) {
    if (substr(game$board[j],2,2 ) == enemy) {
      piece <- unlist(strsplit(game$board[j], ""))[1]

      #if (pl == "K") piece <- King
      #if (pl == "Q") piece <- Queen
      #if (pl == "R") piece <- Rook
      #if (pl == "B") piece <- Bishop
      #if (pl == "N") piece <- Knight
      #if (pl == "p") piece <- Pawn

      turn <- ifelse(unlist(strsplit(game$board[j], ""))[2] == "w", 1, -1)
      mv0 <- defmoves(piece, initialposition = chess2plyrs::chesstools$tilenames[j], turn, msf_chckobs = FALSE)

      enemymvs[[unlist(strsplit(game$board[j], ""))[2]]][[paste0(game$board[j], "_", chess2plyrs::chesstools$tilenames[j])]] <- mv0
    }
  }

  return(enemymvs)
}
