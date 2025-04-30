#' @title all_possibilities
#'
#' @description finds all legal moves
#'
#' @param currentboard game$board
#'
#' @return all chess possiblities
#' @export
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
      mv0 <- defmoves(piece, initialposition = tilenames[j], turn)

      legalmoves[[unlist(strsplit(game$board[j], ""))[2]]][[paste0(game$board[j], "_", tilenames[j])]] <- mv0
    }
  }

  # Now implement pinned piece restriction
  myself <- ifelse(game$turn == 1, "w", "b")
  enemy <- ifelse(game$turn == 1, "b", "w")
  legalmoves[[myself]] <- pinned_piece2(legalmoves = legalmoves)

  # Our king can only go in squares which are not controlled by the enemy!
  mykingposition <- tilenames[which(currentboard == paste0("K", myself) )]

  available_K_squares <- legalmoves[[myself]][[paste0("K", myself, "_", mykingposition)]]
  legalmoves[[myself]][[paste0("K", myself, "_", mykingposition)]] <- subset(available_K_squares, !available_K_squares %in% unique(Reduce(c, legalmoves[[enemy]])))

  # If castle is available, add it as a legal move:
  castlingrow <- ifelse(game$turn == 1, "1", "8")

  # short castle
  if (!grepl(paste0("e", castlingrow), paste0(game$history, collapse = "_"), fixed = T) &
      !grepl(paste0("h", castlingrow), paste0(game$history, collapse = "_"), fixed = T) &
      !(paste0("e", castlingrow) %in% unique(Reduce(c, legalmoves[[enemy]]))) &
      !(paste0("f", castlingrow) %in% unique(Reduce(c, legalmoves[[enemy]]))) &
      !(paste0("g", castlingrow) %in% unique(Reduce(c, legalmoves[[enemy]]))) &
      currentboard[tilenames == paste0("f", castlingrow)] == "" &
      currentboard[tilenames == paste0("g", castlingrow)] == "") {

    legalmoves[[myself]][[paste0("K", myself, "_", mykingposition)]] <- append(legalmoves[[myself]][[paste0("K", myself, "_", mykingposition)]], "0-0")
  }

  #long castle
  if (!grepl(paste0("e", castlingrow), paste0(game$history, collapse = "_"), fixed = T) &
      !grepl(paste0("a", castlingrow), paste0(game$history, collapse = "_"), fixed = T) &
      !(paste0("c", castlingrow) %in% unique(Reduce(c, legalmoves[[enemy]]))) &
      !(paste0("d", castlingrow) %in% unique(Reduce(c, legalmoves[[enemy]]))) &
      !(paste0("e", castlingrow) %in% unique(Reduce(c, legalmoves[[enemy]]))) &
      currentboard[tilenames == paste0("b", castlingrow)] == "" &
      currentboard[tilenames == paste0("c", castlingrow)] == "" &
      currentboard[tilenames == paste0("d", castlingrow)] == "") {

    legalmoves[[myself]][[paste0("K", myself, "_", mykingposition)]] <- append(legalmoves[[myself]][[paste0("K", myself, "_", mykingposition)]], "0-0-0")
  }


  # If we are in check, legalomves[[myself]] is overwritten, and this finds the available moves:
  if (length(names(kingcheck(legalmoves = legalmoves))) >0) { # what you need to do if you are in check
    parries <- parrycheck(legalmoves = legalmoves)
    escapes <- escapecheck(legalmoves = legalmoves)
    eaters  <- removeattacker(legalmoves = legalmoves)


    keys <- unique(c(names(escapes), names(eaters), names(parries)))
    legalmoves[[myself]] <- as.list(stats::setNames(mapply(c, escapes[keys], eaters[keys], parries[keys]), keys))
  }
  return(legalmoves)
}

