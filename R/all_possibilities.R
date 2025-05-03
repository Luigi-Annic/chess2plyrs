#' @title all_possibilities
#'
#' @description finds all legal moves
#'
#' @param currentboard game$board
#'
#' @return all chess possiblities
#' @export
#'
#' @examples
#' game <- newgame()
#' all_possibilities()
#'

all_possibilities <- function(currentboard = game$board) {

  legalmoves <- list()

  for (j in (1 : length(game$board))) {
    if (game$board[j] != "") {
      pl <- unlist(strsplit(game$board[j], ""))[1]

      if (pl == "K") piece <- King
      if (pl == "Q") piece <- Queen
      if (pl == "R") piece <- Rook
      if (pl == "B") piece <- Bishop
      if (pl == "N") piece <- Knight
      if (pl == "p") piece <- Pawn

      turn <- ifelse(unlist(strsplit(game$board[j], ""))[2] == "w", 1, -1)
      mv0 <- defmoves(piece, initialposition = chess2plyrs::chesstools$tilenames[j], turn)

      legalmoves[[unlist(strsplit(game$board[j], ""))[2]]][[paste0(game$board[j], "_", chess2plyrs::chesstools$tilenames[j])]] <- mv0
    }
  }

  # Now implement pinned piece restriction
  myself <- ifelse(game$turn == 1, "w", "b")
  enemy <- ifelse(game$turn == 1, "b", "w")
  legalmoves[[myself]] <- pinned_piece2(legalmoves = legalmoves)

  # Our king can only go in squares which are not controlled by the enemy!
  mykingposition <- chess2plyrs::chesstools$tilenames[which(currentboard == paste0("K", myself) )]

  available_K_squares <- legalmoves[[myself]][[paste0("K", myself, "_", mykingposition)]]

  #enemypiecescontrols <- unique(Reduce(c, subset(legalmoves[[enemy]], substr(names(legalmoves[[enemy]]),1,1) != "p")))
  #enemypawns <- chess2plyrs::chesstools$tilenames[unlist(lapply(1:64, function(j) currentboard[j] == paste0("p", enemy)))]

  #pcol <- if (enemy == "w") whitepawns else blackpawns

  #enemypawnsattackers <- as.character(stats::na.omit(unique(as.character(pcol[3:4, enemypawns]))))

  #legalmoves[[myself]][[paste0("K", myself, "_", mykingposition)]] <- subset(available_K_squares,
  #!available_K_squares %in% c(enemypiecescontrols, enemypawnsattackers))

  legalmoves[[myself]][[paste0("K", myself, "_", mykingposition)]] <- subset(available_K_squares,
        !available_K_squares %in% as.character(unlist(enemy_attacks())))

  # If castle is available, add it as a legal move:
  castlingrow <- ifelse(game$turn == 1, "1", "8")

  # short castle
  if (!grepl(paste0("e", castlingrow), paste0(game$history, collapse = "_"), fixed = T) &
      !grepl(paste0("h", castlingrow), paste0(game$history, collapse = "_"), fixed = T) &
      !(paste0("e", castlingrow) %in% unique(Reduce(c, legalmoves[[enemy]]))) &
      !(paste0("f", castlingrow) %in% unique(Reduce(c, legalmoves[[enemy]]))) &
      !(paste0("g", castlingrow) %in% unique(Reduce(c, legalmoves[[enemy]]))) &
      currentboard[chess2plyrs::chesstools$tilenames == paste0("f", castlingrow)] == "" &
      currentboard[chess2plyrs::chesstools$tilenames == paste0("g", castlingrow)] == "") {

    legalmoves[[myself]][[paste0("K", myself, "_", mykingposition)]] <- append(legalmoves[[myself]][[paste0("K", myself, "_", mykingposition)]], "0-0")
  }

  #long castle
  if (!grepl(paste0("e", castlingrow), paste0(game$history, collapse = "_"), fixed = T) &
      !grepl(paste0("a", castlingrow), paste0(game$history, collapse = "_"), fixed = T) &
      !(paste0("c", castlingrow) %in% unique(Reduce(c, legalmoves[[enemy]]))) &
      !(paste0("d", castlingrow) %in% unique(Reduce(c, legalmoves[[enemy]]))) &
      !(paste0("e", castlingrow) %in% unique(Reduce(c, legalmoves[[enemy]]))) &
      currentboard[chess2plyrs::chesstools$tilenames == paste0("b", castlingrow)] == "" &
      currentboard[chess2plyrs::chesstools$tilenames == paste0("c", castlingrow)] == "" &
      currentboard[chess2plyrs::chesstools$tilenames == paste0("d", castlingrow)] == "") {

    legalmoves[[myself]][[paste0("K", myself, "_", mykingposition)]] <- append(legalmoves[[myself]][[paste0("K", myself, "_", mykingposition)]], "0-0-0")
  }

  # En passant!?
  if (!is.null(game$history)) {
  if (grepl(paste0("^p", "[a-h]", ifelse(game$turn == 1,"7", "2"), "-", "[a-h]", ifelse(game$turn == 1,"5", "4")),
            game$history[length(game$history)])) {
    plt <- substr(game$history[length(game$history)],2,2)
    adjacent1 <- letters[which(letters == plt) -1]
    adjacent2 <- letters[which(letters == plt) +1]

    if (plt != "a") {
     if (game$board[which(chess2plyrs::chesstools$tilenames == paste0(adjacent1, ifelse(game$turn == 1,"5", "4")))] == paste0("p", myself))
    {
      legalmoves[[myself]][[paste0("p", myself, "_", adjacent1, ifelse(game$turn == 1,"5", "4"))]] <- c(
        legalmoves[[myself]][[paste0("p", myself, "_", adjacent1, ifelse(game$turn == 1,"5", "4"))]],
        paste0(plt, ifelse(myself == "w", 6, 3), "_e.p."))
     }
    }

    if (plt != "h") {
       if  (game$board[which(chess2plyrs::chesstools$tilenames == paste0(adjacent2, ifelse(game$turn == 1,"5", "4")))] == paste0("p", myself))
    {
      legalmoves[[myself]][[paste0("p", myself, "_", adjacent2, ifelse(game$turn == 1,"5", "4"))]] <- c(
        legalmoves[[myself]][[paste0("p", myself, "_", adjacent2, ifelse(game$turn == 1,"5", "4"))]],
        paste0(plt, ifelse(myself == "w", 6, 3), "_e.p."))
    }
}

  }
}


  # If we are in check, legalomves[[myself]] is overwritten, and this finds the available moves:
  if (length(names(kingcheck(legalmoves = legalmoves))) >0) { # what you need to do if you are in check
    parries <- parrycheck(legalmoves = legalmoves)
    escapes <- escapecheck(legalmoves = legalmoves) # questa semplicemente copia le mosse del re
    eaters  <- removeattacker(legalmoves = legalmoves)


    keys <- unique(c(names(escapes), names(eaters), names(parries)))

    if (length(keys) >1) {
    legalmoves[[myself]] <- as.list(stats::setNames(mapply(c, escapes[keys], eaters[keys], parries[keys]), keys))
    } else if (length(keys) == 1){

    legalmoves[[myself]] <- list (keys = unique(as.character(c(unlist(parries), unlist(escapes), unlist(eaters)))))
    legalmoves[[myself]] <- stats::setNames(legalmoves[[myself]], keys)

    } else if (length(keys) == 0) message("Boooo")

    }
  return(legalmoves)
}

