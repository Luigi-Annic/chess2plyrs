% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/chessplot.R
\name{chessplot}
\alias{chessplot}
\title{chessplot}
\usage{
chessplot(game, style = 1)
}
\arguments{
\item{game}{chess game object (i.e., a list with elements board, turn, history, and fen_history
as created by newgame function)}

\item{style}{font style. 1: chess pieces according to unicode; 2: chess labels}
}
\value{
plot
}
\description{
plots the current position
}
