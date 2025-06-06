# title all_possibilities
#
# description finds all legal moves for the player moving, and all the squares under attack
#              from the opponent pieces.
#
# param game chess game object (i.e., a list with elements board, turn, history, and fen_history
#              as created by newgame function)
#
# return all chess possibilities
#

all_possibilities <- function(game) {

  currentboard = game$board
  turn = game$turn
  history = game$history

  legalmoves <- list()

  for (j in (1 : length(currentboard))) {
    if (currentboard[j] != "") {
      piece <- unlist(strsplit(currentboard[j], ""))[1]

      #if (pl == "K") piece <- King
      #if (pl == "Q") piece <- Queen
      #if (pl == "R") piece <- Rook
      #if (pl == "B") piece <- Bishop
      #if (pl == "N") piece <- Knight
      #if (pl == "p") piece <- Pawn

      turnx <- ifelse(unlist(strsplit(currentboard[j], ""))[2] == "w", 1, -1)
      mv0 <- defmoves(game, piece, initialposition = chess2plyrs::chesstools$tilenames[j], turnx)

      legalmoves[[unlist(strsplit(currentboard[j], ""))[2]]][[paste0(currentboard[j], "_", chess2plyrs::chesstools$tilenames[j])]] <- mv0
    }
  }

  # Now implement pinned piece restriction
  myself <- ifelse(turn == 1, "w", "b")
  enemy <- ifelse(turn == 1, "b", "w")
  legalmoves[[myself]] <- pinned_piece2(game, legalmoves = legalmoves)

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
        !available_K_squares %in% as.character(unlist(enemy_attacks(game))))

  # If castle is available, add it as a legal move:
  castlingrow <- ifelse(turn == 1, "1", "8")

  # short castle
  if (!grepl(paste0("e", castlingrow), paste0(history, collapse = "_"), fixed = T) &
      !grepl(paste0("h", castlingrow), paste0(history, collapse = "_"), fixed = T) &
      !(paste0("e", castlingrow) %in% unique(Reduce(c, legalmoves[[enemy]]))) &
      !(paste0("f", castlingrow) %in% unique(Reduce(c, legalmoves[[enemy]]))) &
      !(paste0("g", castlingrow) %in% unique(Reduce(c, legalmoves[[enemy]]))) &
      currentboard[chess2plyrs::chesstools$tilenames == paste0("f", castlingrow)] == "" &
      currentboard[chess2plyrs::chesstools$tilenames == paste0("g", castlingrow)] == "") {

    legalmoves[[myself]][[paste0("K", myself, "_", mykingposition)]] <- append(legalmoves[[myself]][[paste0("K", myself, "_", mykingposition)]], "0-0")
  }

  #long castle
  if (!grepl(paste0("e", castlingrow), paste0(history, collapse = "_"), fixed = T) &
      !grepl(paste0("a", castlingrow), paste0(history, collapse = "_"), fixed = T) &
      !(paste0("c", castlingrow) %in% unique(Reduce(c, legalmoves[[enemy]]))) &
      !(paste0("d", castlingrow) %in% unique(Reduce(c, legalmoves[[enemy]]))) &
      !(paste0("e", castlingrow) %in% unique(Reduce(c, legalmoves[[enemy]]))) &
      currentboard[chess2plyrs::chesstools$tilenames == paste0("b", castlingrow)] == "" &
      currentboard[chess2plyrs::chesstools$tilenames == paste0("c", castlingrow)] == "" &
      currentboard[chess2plyrs::chesstools$tilenames == paste0("d", castlingrow)] == "") {

    legalmoves[[myself]][[paste0("K", myself, "_", mykingposition)]] <- append(legalmoves[[myself]][[paste0("K", myself, "_", mykingposition)]], "0-0-0")
  }

  # En passant!?
  if (!is.null(history)) {
  if (grepl(paste0("^p", "[a-h]", ifelse(turn == 1,"7", "2"), "-", "[a-h]", ifelse(turn == 1,"5", "4")),
            history[length(history)])) {
    plt <- substr(history[length(history)],2,2)
    adjacent1 <- letters[which(letters == plt) -1]
    adjacent2 <- letters[which(letters == plt) +1]

    if (plt != "a") {
     if (currentboard[which(chess2plyrs::chesstools$tilenames == paste0(adjacent1, ifelse(turn == 1,"5", "4")))] == paste0("p", myself))
    {
      legalmoves[[myself]][[paste0("p", myself, "_", adjacent1, ifelse(turn == 1,"5", "4"))]] <- c(
        legalmoves[[myself]][[paste0("p", myself, "_", adjacent1, ifelse(turn == 1,"5", "4"))]],
        paste0(plt, ifelse(myself == "w", 6, 3), "_e.p."))
     }
    }

    if (plt != "h") {
       if  (currentboard[which(chess2plyrs::chesstools$tilenames == paste0(adjacent2, ifelse(turn == 1,"5", "4")))] == paste0("p", myself))
    {
      legalmoves[[myself]][[paste0("p", myself, "_", adjacent2, ifelse(turn == 1,"5", "4"))]] <- c(
        legalmoves[[myself]][[paste0("p", myself, "_", adjacent2, ifelse(turn == 1,"5", "4"))]],
        paste0(plt, ifelse(myself == "w", 6, 3), "_e.p."))
    }
}

  }
}


  # If we are in check, legalomves[[myself]] is overwritten, and this finds the available moves:
  if (length(names(kingcheck(game, legalmoves = legalmoves))) >0) { # what you need to do if you are in check
    parries <- parrycheck(game, legalmoves = legalmoves)
    escapes <- escapecheck(game, legalmoves = legalmoves) # questa semplicemente copia le mosse del re
    eaters  <- removeattacker(game, legalmoves = legalmoves)


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

