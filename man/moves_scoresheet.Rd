% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/moves_scoresheet.R
\name{moves_scoresheet}
\alias{moves_scoresheet}
\title{moves_scoresheet}
\usage{
moves_scoresheet(game, shortnotation = TRUE)
}
\arguments{
\item{game}{chess game object (i.e., a list with elements board, turn, history, and fen_history
as created by newgame function)}

\item{shortnotation}{Use short scientific notation? TRUE is the default}
}
\value{
moves scoresheet
}
\description{
Creates move scorelist, in scientific notation
}
\examples{

g <- newgame() |>
  chess_move("p", "e2", "e4") |>
  chess_move("p", "e7", "e5") |>
  chess_move("N", "g1", "f3") |>
  chess_move("N", "b8", "c6") |>
  chess_move("B", "f1", "b5") |>
  chess_move("N", "g8", "f6") |>
  chess_move("K", "e1", "0-0")|>
  chess_move("N", "f6", "e4")
moves_scoresheet(g)

}
