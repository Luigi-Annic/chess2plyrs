# Position evaluation function
chess_score1 <- function(game) {
  currentboard = game$board
  turn = game$turn


  # Test if black won
  if (suppressMessages(game_result(game)) ==1 & turn == 1 & length(kingcheck(game, legalmoves = all_possibilities(game))) > 0) {
    return(-1000)
  }
  # Test if white won
  if (suppressMessages(game_result(game)) ==1 & turn == -1 & length(kingcheck(game, legalmoves = all_possibilities(game))) > 0) {
    return(1000)
  }
  # Test if game ended in a draw
   if (suppressMessages(game_result(game)) ==1 & length(kingcheck(game, legalmoves = all_possibilities(game))) == 0) {
     return(0)
  }

  # Compute material advantage
  position_fen <- unlist(strsplit(strsplit(writefen(game, currentboard, turn, cb_tb_insteadof_game = TRUE), " ")[[1]][1], ""))
  white_score <- length(which(position_fen == "Q")) * 9 + length(which(position_fen == "R")) * 4.5 + length(which(position_fen == "B")) * 3 + length(which(position_fen == "N")) * 3 + length(which(position_fen == "P"))
  black_score <- length(which(position_fen == "q")) * 9 + length(which(position_fen == "r")) * 4.5 + length(which(position_fen == "b")) * 3 + length(which(position_fen == "n")) * 3 + length(which(position_fen == "p"))

  # Evaluate king safety
  check_score <- 0
  if (length(kingcheck(game, legalmoves = all_possibilities(game))) > 0 & turn == 1) check_score <- -1
  if (length(kingcheck(game, legalmoves = all_possibilities(game))) > 0 & turn == -1) check_score <- 1

  # pawns e, d

  pscore <- sum(currentboard["2", "e"] == "pw", currentboard["2", "d"] == "pw")* -0.25 +
            sum(currentboard["7", "e"] == "pb", currentboard["7", "d"] == "pb")* 0.25

  # piece development
  development <- sum(currentboard["1",] %in% c("Nw", "Bw")) * (-0.25) + sum(currentboard["8",] %in% c("Nb", "Bb")) * (+0.25)

  # knight on the rim is dim
  rimknight <- sum(currentboard[,c("a", "h")] %in% "Nw") * (-0.15) + sum(currentboard[,c("a", "h")] %in% "Nb") * (0.15)

  # piece activity
  #activity <- length(legalmoves(game))*0.01 * turn

  # Return final position score
  return(white_score - black_score + check_score + pscore + development + rimknight) #+activity)
}


##########

# Score position via minimax strategy
minimax_scoring <- function(game, depth) {

  turn = game$turn
  # If the game is already over or the depth limit is reached
  # then return the heuristic evaluation of the position
  if (depth == 0 | suppressMessages(game_result(game)) ==1) {
    return(chess_score1(game))
  }

  # Run the minimax scoring recursively on every legal next move, making sure the search depth is not exceeded
  next_moves <- legalmoves(game)
  next_move_scores <- vector(length = length(next_moves))
  for (i in 1:length(next_moves)) {

    piece <- substr(next_moves[i], 1, 1)
    initialposition <-  substr(next_moves[i], 2, 3)
    finalposition <- if (grepl("0-0-0", next_moves[i])) "0-0-0" else if (grepl("0-0", next_moves[i])) "0-0" else substr(next_moves[i], 4, 5)

    game2 <- make_move4(game, piece, initialposition, finalposition)

    next_move_scores[i] <- minimax_scoring(game2, depth - 1)

    #game <- takeback(game)
  }

  # White will select the move that maximizes the position score
  # Black will select the move that minimizes the position score
  if (turn == 1) {
    return(max(next_move_scores))
  } else {
    return(min(next_move_scores))
  }
}

########

# Select the next move based on the minimax scoring
get_minimax_move <- function(game, depth) {
  turn = game$turn

  # Score all next moves via minimax
  next_moves <- legalmoves(game)
  next_move_scores <- vector(length = length(next_moves))
  for (i in 1:length(next_moves)) {
    piece <- substr(next_moves[i], 1, 1)
    initialposition <-  substr(next_moves[i], 2, 3)
    finalposition <- if (grepl("0-0-0", next_moves[i])) "0-0-0" else if (grepl("0-0", next_moves[i])) "0-0" else substr(next_moves[i], 4, 5)

    game2 <- make_move4(game, piece, initialposition, finalposition)

    next_move_scores[i] <- minimax_scoring(game2, depth - 1)

    #game <- takeback(game)
  }

  # For white return the move with maximum score
  # For black return the move with minimum score
  # If the optimal score is achieved by multiple moves, select one at random

  if (turn == 1) {
    return(sample(next_moves[which(next_move_scores == max(next_move_scores))], size = 1))
  } else {
    return(sample(next_moves[which(next_move_scores == min(next_move_scores))], size = 1))
  }
}
