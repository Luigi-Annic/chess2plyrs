# Score position via minimax strategy
minimax_scoring2 <- function(game, depth, alpha, beta) {

  turn = game$turn
  # If the game is already over or the depth limit is reached
  # then return the heuristic evaluation of the position
  if (depth == 0 | suppressMessages(game_result(game)) ==1) {
    return(chess_score1(game))
  }

  next_moves <- legalmoves(game)
  next_move_scores <- vector(length = length(next_moves))

  if (turn == 1) {

    best <- -1000

    for (i in 1:length(next_moves)) {

      print(next_moves[i])

      piece <- substr(next_moves[i], 1, 1)
      initialposition <-  substr(next_moves[i], 2, 3)
      finalposition <- if (grepl("0-0-0", next_moves[i])) "0-0-0" else if (grepl("0-0", next_moves[i])) "0-0" else substr(next_moves[i], 4, 5)

      game2 <- make_move4(game, piece, initialposition, finalposition)

      next_move_scores[i] <- minimax_scoring2(game2, depth - 1, alpha, beta)

      best <- max(best, next_move_scores[i])
      alpha <- max(alpha, best)

      if (beta <= alpha) {
        print ("beta < alpha")
        break
      }

    }
    } else {

      best <- 1000

      for (i in 1:length(next_moves)) {

        print(next_moves[i])

        piece <- substr(next_moves[i], 1, 1)
        initialposition <-  substr(next_moves[i], 2, 3)
        finalposition <- if (grepl("0-0-0", next_moves[i])) "0-0-0" else if (grepl("0-0", next_moves[i])) "0-0" else substr(next_moves[i], 4, 5)

        game2 <- make_move4(game, piece, initialposition, finalposition)

        next_move_scores[i] <- minimax_scoring2(game2, depth - 1, alpha, beta)

        best <- min(best, next_move_scores[i])
        beta <- min(beta, best)

        if (beta <= alpha) {

          print("beta < alpha")
          break

        }

       }
    }

  # White will select the move that maximizes the position score
  # Black will select the move that minimizes the position score
  if (turn == 1) {
    return(max(next_move_scores))
  } else {
    return(min(next_move_scores))
  }
}


  #############


  get_minimax_move2 <- function(game, depth, alpha = -1000, beta = 1000) {
    turn = game$turn

    # Score all next moves via minimax
    next_moves <- legalmoves(game)
    next_move_scores <- vector(length = length(next_moves))
    for (i in 1:length(next_moves)) {
      piece <- substr(next_moves[i], 1, 1)
      initialposition <-  substr(next_moves[i], 2, 3)
      finalposition <- if (grepl("0-0-0", next_moves[i])) "0-0-0" else if (grepl("0-0", next_moves[i])) "0-0" else substr(next_moves[i], 4, 5)

      game2 <- make_move4(game, piece, initialposition, finalposition)

      next_move_scores[i] <- minimax_scoring2(game2, depth - 1, alpha, beta)

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
