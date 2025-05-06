# check obstacles for long range pieces (Rook, Bishop, Queen)
# nota che myself_movement e msf_chckobs sono elementi inseriti solo per calcolare la funzione
# enemy_attacks: tranne che per questa funzione, sono sempre settati su TRUE tramite defmoves.
# Con mysel_movement = TRUE la funzione esclude dalle mosse possibili le caselle dove e presente un
# pezzo amico. Tuttavia, in enemy_attacks vogliamo trovare tutte le caselle in cui il re non può andare,
# e una casella in cui ce un pezzo amico difeso e comunque da scartare dalle possibili caselle per il re
#
check_obstacles <- function(m0, initialposition, board = game$board, myself_movement = msf_chckobs) {

  if (myself_movement == FALSE) {board[which(game$board == paste0("K", ifelse(game$turn == 1, "w", "b")))] <- ""} # se Donna da scacco in e2, e re nemico in e7, cosi si accorge che non puo andare in e8.

  occupied_tiles <- c()
  tile_index <- c()
  for (tile in m0){
    if (tile != initialposition & board[which(chess2plyrs::chesstools$tilenames == tile)] != "") {
      occupied_tiles <- c(occupied_tiles, tile)
      tile_index <- c(tile_index, unlist(strsplit(tile, ""))[2])
    }
  }

  if (length(occupied_tiles) == 0) { # if no occupied tiles along the vector be happy
    m1 <- m0
  } else { # otherwise we need to calculate

    init_index <- unlist(strsplit(initialposition, ""))[2]

    #if (length(tile_index) > 1 & length(unique(tile_index)) ==1) {
    if (unlist(strsplit(m0, ""))[2] == unlist(strsplit(m0, ""))[4]) {
      #tile_index <- c(tile_index, unlist(strsplit(tile, ""))[1])
      tile_index <- unlist(strsplit(occupied_tiles, ""))[c(TRUE,FALSE)]
      init_index <- unlist(strsplit(initialposition, ""))[1]
    }

    # Find the two most proximate occupied squares (if existent)
    greater_than_index <- suppressWarnings(min(tile_index[tile_index>init_index]))
    smaller_than_index <- suppressWarnings(max(tile_index[tile_index<init_index]))
    great_tile <- ifelse(!greater_than_index %in% c(Inf, NA), occupied_tiles[which(tile_index == greater_than_index)],
                         ifelse(unlist(strsplit(m0, ""))[2]<=unlist(strsplit(m0, ""))[4], m0[length(m0)], m0[1]))
    small_tile <- ifelse(!smaller_than_index %in% c(-Inf, NA), occupied_tiles[which(tile_index == smaller_than_index)],
                         ifelse(unlist(strsplit(m0, ""))[2]<=unlist(strsplit(m0, ""))[4], m0[1], m0[length(m0)]))

    m1 <- m0[which(m0 == small_tile):which(m0==great_tile)]

    # remove tiles with pieces of the same colour if these are the great_tile and small_tile
    if (myself_movement == TRUE) {

    if (unlist(strsplit(board[which(chess2plyrs::chesstools$tilenames==initialposition)], ""))[2] == unlist(strsplit(board[which(chess2plyrs::chesstools$tilenames==great_tile)], ""))[2] &
        board[which(chess2plyrs::chesstools$tilenames==great_tile)] != "") {
      m1 <- m1[! m1 ==great_tile]
    }
    if (unlist(strsplit(board[which(chess2plyrs::chesstools$tilenames==initialposition)], ""))[2] == unlist(strsplit(board[which(chess2plyrs::chesstools$tilenames==small_tile)], ""))[2] &
        board[which(chess2plyrs::chesstools$tilenames==small_tile)] != "") {
      m1 <- m1[! m1 ==small_tile]
    }
    }

  }

  m1 <- m1[! m1 == initialposition] #remove the initial tile as a possible movement
  return(m1)
}


# remove tiles with pieces of the same colour (for King, Knight movement and maybe also pawn)
# King will require additional check for removing tiles where it is not legal to move (controlled by enemy pieces)

check_occupied_tile <- function(m0, initialposition, board = game$board) {
  m1 <- as.character(m0)
  for (tile in m0) {
    if (unlist(strsplit(board[which(chess2plyrs::chesstools$tilenames==initialposition)], ""))[2] == unlist(strsplit(board[which(chess2plyrs::chesstools$tilenames==tile)], ""))[2] &
        board[which(chess2plyrs::chesstools$tilenames==tile)] != "") {
      m1 <- m1[! m1 == tile]
    }
  }
  return(m1)
}

# Allow for pawn capture in diagonal if enemy piece stands there
check_pawn_capture <- function(initialposition, board = game$board, turn = game$turn) {
  if (turn == 1) pawnmoves <- chess2plyrs::chesstools$whitepawns else pawnmoves <- chess2plyrs::chesstools$blackpawns

  capturecandidates <- as.character(stats::na.omit(pawnmoves[c(3,4), initialposition]))
  c1 <- capturecandidates

  for (tile in capturecandidates) {
    if (unlist(strsplit(board[which(chess2plyrs::chesstools$tilenames==initialposition)], ""))[2] == unlist(strsplit(board[which(chess2plyrs::chesstools$tilenames==tile)], ""))[2] |
        board[which(chess2plyrs::chesstools$tilenames==tile)] == "") {
      c1 <- c1[!c1 == tile]
    }
  }

  return(c1)
}

# Check if pawn can move forward or if tile is occupied (this is the check_occupied_tile function
#  specifically designed for pawns, as they cannot move forward if they have something there, no matter the color)

pawn_forward <- function(m0, initialposition, board = game$board) {
  m1 <- as.character(m0)
  for (tile in m0) {
    if (board[which(chess2plyrs::chesstools$tilenames==tile)] != "") {
      m1 <- m1[! m1 == tile]
    }
  }
  return(m1)
}


# turn tells if it is white turn(1) or black turn (-1)
defmoves <- function(piece, initialposition, turn = 1, msf_chckobs = TRUE) {
  moves0 <- c()

  # Rook and Queen move
  if (piece %in% c("R", "Q")) {
    for (l in names(chess2plyrs::chesstools$alltravs)) {
      if (initialposition %in% chess2plyrs::chesstools$alltravs[[l]]){
        m0 <- chess2plyrs::chesstools$alltravs[[l]]
        m1 <- check_obstacles(m0, initialposition, myself_movement = msf_chckobs)
        moves0 <- c(moves0, m1)
      }
    }
  }

  # Bishop and Queen move
  if (piece %in% c("B", "Q")) {
    for (d in names(chess2plyrs::chesstools$alldiags)) {
      if (initialposition %in% chess2plyrs::chesstools$alldiags[[d]]){
        m0 <- chess2plyrs::chesstools$alldiags[[d]]
        m1 <- check_obstacles(m0, initialposition, myself_movement = msf_chckobs)
        moves0 <- c(moves0, m1)
      }
    }
  }

  # King move
  if (piece == "K") {
    m0 <- as.character(stats::na.omit(chess2plyrs::chesstools$neigh[, initialposition]))

    if (msf_chckobs == TRUE) moves0 <- check_occupied_tile(m0, initialposition) else moves <- m0
  }

  # Knight move
  if (piece == "N") {
    m0 <- as.character(stats::na.omit(chess2plyrs::chesstools$nighty[, initialposition]))
    if (msf_chckobs == TRUE) moves0 <- check_occupied_tile(m0, initialposition) else moves0 <- m0
  }

  # Pawn move
  if (piece == "p") {
    if (turn == 1) pawnmoves <- chess2plyrs::chesstools$whitepawns else pawnmoves <- chess2plyrs::chesstools$blackpawns

    if (msf_chckobs == TRUE) {
    m0moves <- as.character(stats::na.omit(pawnmoves[c(1,2), initialposition]))
    moves0a <- pawn_forward(m0moves, initialposition)

    c1 <- check_pawn_capture(initialposition)

    moves0 <- c(moves0a, c1)
    } else {

      moves0 <- as.character(stats::na.omit(pawnmoves[c(3,4), initialposition]))
    }
  }

  return(moves0)
}
