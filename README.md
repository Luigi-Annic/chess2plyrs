
<!-- README.md is generated from README.Rmd. Please edit that file -->

# chess2plyrs

<!-- badges: start -->
<!-- badges: end -->

chess2plyrs is an Rpackage which allows to create a chess game and add
moves, verify the status of the game and list the legal moves, as well
as read and write FENs. It is also possible to plot the current board
position.

## Installation

You can install the development version of chess2plyrs from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("Luigi-Annic/chess2plyrs")
```

# Appendix

Known potential issues and future improvements:

1)  pawn promotion is automatically to Queen at the moment. In a future
    release, auto-promotion will be removed
2)  in some cases related to checks with pawns, potential legal en
    passant moves might be not detected as legal. This may happen in an
    extremely rare number of cases, but will be nonetheless fixed soon
3)  FEN are only considering the first two elements (position and turn),
    ignoring castle information. This will also be fixed soon

In case you find any additional bugs or if you have any suggestion, feel
free to post relevant information to GitHub!
