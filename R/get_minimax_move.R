#' @title get_minimax_move
#'
#' @description minimax engine
#'
#' @param game chess game object (i.e., a list with elements board, turn, history, and fen_history
#'              as created by newgame function)
#' @param depth algorithm depth
#'
#' @return minimax engine
#' @export
#'

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
