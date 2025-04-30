# check obstacles for long range pieces (Rook, Bishop, Queen)
check_obstacles <- function(m0, initialposition, board = game$board) {
  occupied_tiles <- c()
  tile_index <- c()
  for (tile in m0){
    if (tile != initialposition & board[which(tilenames == tile)] != "") {
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
    if (unlist(strsplit(board[which(tilenames==initialposition)], ""))[2] == unlist(strsplit(board[which(tilenames==great_tile)], ""))[2] &
        board[which(tilenames==great_tile)] != "") {
      m1 <- m1[! m1 ==great_tile]
    }
    if (unlist(strsplit(board[which(tilenames==initialposition)], ""))[2] == unlist(strsplit(board[which(tilenames==small_tile)], ""))[2] &
        board[which(tilenames==small_tile)] != "") {
      m1 <- m1[! m1 ==small_tile]
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
    if (unlist(strsplit(board[which(tilenames==initialposition)], ""))[2] == unlist(strsplit(board[which(tilenames==tile)], ""))[2] &
        board[which(tilenames==tile)] != "") {
      m1 <- m1[! m1 == tile]
    }
  }
  return(m1)
}

# Allow for pawn capture in diagonal if enemy piece stands there
check_pawn_capture <- function(initialposition, board = game$board, turn = game$turn) {
  if (turn == 1) pawnmoves <- whitepawns else pawnmoves <- blackpawns

  capturecandidates <- as.character(na.omit(pawnmoves[c(3,4), initialposition]))
  c1 <- capturecandidates

  for (tile in capturecandidates) {
    if (unlist(strsplit(board[which(tilenames==initialposition)], ""))[2] == unlist(strsplit(board[which(tilenames==tile)], ""))[2] |
        board[which(tilenames==tile)] == "") {
      c1 <- c1[!c1 == tile]
    }
  }

  return(c1)
}

# turn tells if it is white turn(1) or black turn (-1)
defmoves <- function(piece, initialposition, turn = 1) {
  moves0 <- c()

  # Rook and Queen move
  if ("l" %in% piece$movedirection) {
    for (l in names(alltravs)) {
      if (initialposition %in% alltravs[[l]]){
        m0 <- alltravs[[l]]
        m1 <- check_obstacles(m0, initialposition)
        moves0 <- c(moves0, m1)
      }
    }
  }

  # Bishop and Queen move
  if ("d" %in% piece$movedirection) {
    for (d in names(alldiags)) {
      if (initialposition %in% alldiags[[d]]){
        m0 <- alldiags[[d]]
        m1 <- check_obstacles(m0, initialposition)
        moves0 <- c(moves0, m1)
      }
    }
  }

  # King move
  if ("k" %in% piece$movedirection) {
    m0 <- as.character(na.omit(neigh[, initialposition]))
    moves0 <- check_occupied_tile(m0, initialposition)
  }

  # Knight move
  if ("n" %in% piece$movedirection) {
    m0 <- as.character(na.omit(nighty[, initialposition]))
    moves0 <- check_occupied_tile(m0, initialposition)
  }

  # Pawn move
  if ("p" %in% piece$movedirection) {
    if (turn == 1) pawnmoves <- whitepawns else pawnmoves <- blackpawns
    m0moves <- as.character(na.omit(pawnmoves[c(1,2), initialposition]))
    moves0a <- check_occupied_tile(m0moves, initialposition)

    c1 <- check_pawn_capture(initialposition)

    moves0 <- c(moves0a, c1)
  }

  return(moves0)
}
