# Kingcheck function returns all pieces giving check to the king
kingcheck <- function(game, legalmoves){

  currentboard = game$board
  turn = game$turn

  checkinglines <- list()
  myself <- ifelse(turn == 1, "w", "b")
  enemy <- ifelse(turn == 1, "b", "w")
  enemy_moves = legalmoves[[enemy]]

  mykingposition <- chess2plyrs::chesstools$tilenames[which(currentboard == paste0("K", myself) )]

  enemypawns <- chess2plyrs::chesstools$tilenames[unlist(lapply(1:64, function(j) currentboard[j] == paste0("p", enemy)))]

  pcol <- if (enemy == "w") chess2plyrs::chesstools$whitepawns else chess2plyrs::chesstools$blackpawns

  for (j in names(enemy_moves)) {
    if ((substr(j,1,1) != "p" & mykingposition %in% enemy_moves[[j]]) |
        (substr(j,1,1) == "p" & mykingposition %in% pcol[3:4, substr(j,4,5)])) {
      checkinglines[[j]] <- enemy_moves[[j]]
    }
  }

  return(checkinglines)
}

parrycheck <- function(game,legalmoves) {

  currentboard = game$board
  turn = game$turn

  checkparry <- list()

  if (length(names(kingcheck(game, legalmoves = legalmoves))) <= 1 ) {

  myself <- ifelse(turn == 1, "w", "b")
  mymoves =legalmoves[[myself]]
  mykingposition <- chess2plyrs::chesstools$tilenames[which(currentboard == paste0("K", myself) )]

  checking_item <- names(kingcheck(game, legalmoves = legalmoves))
  checking_tile <- substr(checking_item, 4,5)

  if (substr(checking_item,1,1) %in% c("B", "Q", "R") & length(checking_item) == 1) {
    # diagonals
    for (j in 1 : length(chess2plyrs::chesstools$alldiags)) {
      if (checking_tile %in% chess2plyrs::chesstools$alldiags[[j]] & mykingposition %in% chess2plyrs::chesstools$alldiags[[j]]) checkline <- chess2plyrs::chesstools$alldiags[[j]]
    }

    # rows/columns
    for (j in 1 : length(chess2plyrs::chesstools$alltravs)) {
      if (checking_tile %in% chess2plyrs::chesstools$alltravs[[j]] & mykingposition %in% chess2plyrs::chesstools$alltravs[[j]]) checkline <- chess2plyrs::chesstools$alltravs[[j]]
    }

    # eliminiamo caselle esterne alle caselle di attacco e del re, e la casella del re (in cui ovviamente non
    # possiamo interporre)
    checkline <- checkline[which(checkline == checking_tile):which(checkline == mykingposition)]
    checkline <- setdiff(checkline, c(mykingposition, checking_tile)) # If we manage to put a piece into the line of fire check is parred

    # Troviamo tutte le mosse che si frappongano nelle caselle trovate in checkline
    # Ovviamente escludiamo il re dai pezzi paratori :)

    for (j in 1:length(names(mymoves))) {
      if (length(intersect(mymoves[[j]], checkline)) > 0 &
          substr(names(mymoves)[[j]], 1,1) != "K") {
        checkparry[[names(mymoves)[[j]]]] <- intersect(mymoves[[j]], checkline)
      }
    }

  } else checkparry <- list()

  }
  return(checkparry)
}



escapecheck <- function(game, legalmoves) {

  currentboard = game$board
  turn = game$turn

  escapes <- list()

  myself <- ifelse(turn == 1, "w", "b")
  mykingposition <- chess2plyrs::chesstools$tilenames[which(currentboard == paste0("K", myself) )]
  #enemy <- ifelse(game$turn == 1, "b", "w")

  #enemy_moves = legalmoves[[enemy]]

  #available_squares <- defmoves(King, initialposition = mykingposition, turn)

  #escapes[[paste0("K", myself, "_", mykingposition)]] <-subset(available_squares, !available_squares %in% unique(Reduce(c, enemy_moves)))

  escapes[[paste0("K", myself, "_", mykingposition)]] <- as.character(legalmoves[[myself]][[paste0("K", myself, "_", mykingposition)]])

  return(escapes)
}


removeattacker <- function(game, legalmoves) {

  currentboard = game$board
  turn = game$turn

  eaters <- list()

    if (length(names(kingcheck(game, legalmoves = legalmoves))) == 1) {

    checking_item <- names(kingcheck(game, legalmoves = legalmoves))
    checking_tile <- substr(checking_item, 4,5)

    myself <- ifelse(turn == 1, "w", "b")
    mymoves = legalmoves[[myself]]

    for (j in names(mymoves)) {
      if (checking_tile %in% mymoves[[j]] &
          !(substr(j, 1,1) == "p" & substr(j, 4,4) == substr(checking_tile,1,1)) # necessario perche i pedoni non mangiano dritti!
      ) eaters[[j]] <-  checking_tile
    }

    return(eaters)
  }
}






pinned_piece2 <- function(game, legalmoves){

  currentboard = game$board
  turn = game$turn

  checkinglines <- list()
  myself <- ifelse(turn == 1, "w", "b")
  enemy <- ifelse(turn == 1, "b", "w")
  mykingposition <- chess2plyrs::chesstools$tilenames[which(currentboard == paste0("K", myself) )]
  #mymoves <- all_possibilities()[[myself]] # this will be the modified object, excluding unplayable moves due to pins
  mymoves <- legalmoves[[myself]]
  potential_checklines0 <- list()

  x <- 1
  # rows/columns
  for (j in 1 : length(chess2plyrs::chesstools$alltravs)) {
    if (mykingposition %in% chess2plyrs::chesstools$alltravs[[j]]) {

      full_checklines <- chess2plyrs::chesstools$alltravs[[j]]
      potential_checklines0[["trav"]][[x]] <- full_checklines[1:which(full_checklines == mykingposition)]
      potential_checklines0[["trav"]][[x+1]] <- full_checklines[which(full_checklines == mykingposition):length(full_checklines)]

      x <- x+2
    }
  }

  x<- 1

  # diagonals
  for (j in 1 : length(chess2plyrs::chesstools$alldiags)) {
    if (mykingposition %in% chess2plyrs::chesstools$alldiags[[j]]) {
      full_checklines <- chess2plyrs::chesstools$alldiags[[j]]
      potential_checklines0[["diag"]][[x]] <- full_checklines[1:which(full_checklines == mykingposition)]
      potential_checklines0[["diag"]][[x+1]] <- full_checklines[which(full_checklines == mykingposition):length(full_checklines)]

      x <- x+2
    }
  }

  # cancella eventuali semitraverse e semidiagonali con solo la casella del re
  potential_checklines0b_t <- setdiff(potential_checklines0$trav, mykingposition)

  #potential_checklines_t <- lapply(1: length(potential_checklines0b_t),
  #                               function(x) setdiff(potential_checklines0b_t[[x]], mykingposition))

  potential_checklines0b_diag <- setdiff(potential_checklines0$diag, mykingposition)

  #potential_checklines_diag <- lapply(1: length(potential_checklines0b_diag),
  #                                 function(x) setdiff(potential_checklines0b_diag[[x]], mykingposition))


  pc0 <- list(rowcol = potential_checklines0b_t,
              diags = potential_checklines0b_diag)

  # Mi assicuro che in pc ogni stringa abbia mykingposition in unltima casella, tornera utile per le regular expressions
  pc <- pc0
  for (k in names(pc0)) {
    for (w in 1:length(pc0[[k]])) {
      pc[[k]][[w]] <- if (pc0[[k]][[w]][1] == mykingposition) pc0[[k]][[w]][length(pc0[[k]][[w]]):1] else pc0[[k]][[w]]
    }
  }

  # Cerco inchiodature in riga
  for (j in 1:length(pc$rowcol)) {
    set <- character(length = length(pc$rowcol[[j]]))
    x <- 1
    for (tile in pc$rowcol[[j]]) {
      set[x] <- currentboard[which(tile == chess2plyrs::chesstools$tilenames)]
      x <- x+1
    }
    set_collapsed <- paste0(set, collapse = "")

    if (grepl(paste0("(Q|R)", enemy, "(p|N|B|R|Q)", myself, "K", myself), set_collapsed)) {

      matching <- regmatches(set_collapsed, gregexpr(paste0("(Q|R)", enemy, "(p|N|B|R|Q)", myself, "K", myself), set_collapsed))
      pinned_piece <- substr(matching,3,4)

      pinner <- substr(matching , 1, 2)
      pinner_tile <- pc$rowcol[[j]][max(which(pinner == set))]
      # ora devo ri mappare il pinned_piece per scoprire in che casella fosse

      pinned_tile <- pc$rowcol[[j]][max(which(pinned_piece == set))] # max gets the rightmost piece (the nearest to the king), utile se ci sono piu pezzi con lo stesso nome

      mymoves[[paste0(pinned_piece, "_", pinned_tile)]] <- intersect(mymoves[[paste0(pinned_piece, "_", pinned_tile)]],
                                                                     pc$rowcol[[j]][which(pc$rowcol[[j]] == pinner_tile):(length(pc$rowcol[[j]])-1)])
      # serve perche un alfiere inchiodato sulla diagonale può muoversi dalla casella del pezzo inchiodante alla casella prima del re
    }
  }

  # cerco inchiodature in colonna
  for (j in 1:length(pc$diags)) {

    set <- character(length = length(pc$diags[[j]]))
    x <- 1
    for (tile in pc$diags[[j]]) {
      set[x] <- currentboard[which(tile == chess2plyrs::chesstools$tilenames)]
      x <- x+1
    }
    set_collapsed <- paste0(set, collapse = "")

    if (grepl(paste0("(Q|B)", enemy, "(p|N|B|R|Q)", myself, "K", myself), set_collapsed)) {

      matching <- regmatches(set_collapsed, gregexpr(paste0("(Q|B)", enemy, "(p|N|B|R|Q)", myself, "K", myself), set_collapsed))
      pinned_piece <- substr(matching,3,4)

      pinner <- substr(matching , 1, 2)
      pinner_tile <- pc$diags[[j]][max(which(pinner == set))]
      # ora devo ri mappare il pinned_piece per scoprire in che casella fosse

      pinned_tile <- pc$diags[[j]][max(which(pinned_piece == set))] # max gets the rightmost piece (the nearest to the king), utile se ci sono piu pezzi con lo stesso nome

      mymoves[[paste0(pinned_piece, "_", pinned_tile)]] <- intersect(mymoves[[paste0(pinned_piece, "_", pinned_tile)]],
                                                                     pc$diags[[j]][which(pc$diags[[j]] == pinner_tile):(length(pc$diags[[j]])-1)])

    }
  }


  return(mymoves)

}


