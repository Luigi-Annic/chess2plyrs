% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/legalmoves.R
\name{legalmoves}
\alias{legalmoves}
\title{legalmoves}
\usage{
legalmoves(game)
}
\arguments{
\item{game}{chess game object (i.e., a list with elements board, turn, history, and fen_history
as created by newgame function)}
}
\value{
character vector
}
\description{
lists legal moves
}
\examples{
newgame() |>
legalmoves()

}
