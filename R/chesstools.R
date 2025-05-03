#' chesstools
#'
#' @description
#' All tools used for letting the chess program work.
#'
#'
#' @docType data
#'
#' @usage chesstools
#'
#' @format An object of class \code{list}
#' @keywords list
#'
"chesstools"

#init <- matrix(data = c("Rb", "Nb", "Bb", "Qb", "Kb", "Bb", "Nb", "Rb",
#                        rep("pb", 8),
#                        rep("", 32),
#                        rep("pw", 8),
#                        "Rw", "Nw", "Bw", "Qw", "Kw", "Bw", "Nw", "Rw"),
#               nrow = 8, ncol = 8, byrow = TRUE,
#               dimnames = list(c(8:1),c(letters[1:8])))

#tilenames <- matrix(data= c(
#  unlist(lapply(8:1, function(x) paste0("a",x))),
#  unlist(lapply(8:1, function(x) paste0("b",x))),
#  unlist(lapply(8:1, function(x) paste0("c",x))),
#  unlist(lapply(8:1, function(x) paste0("d",x))),
#  unlist(lapply(8:1, function(x) paste0("e",x))),
#  unlist(lapply(8:1, function(x) paste0("f",x))),
#  unlist(lapply(8:1, function(x) paste0("g",x))),
#  unlist(lapply(8:1, function(x) paste0("h",x)))),
#  nrow = 8, byrow = F)

#all traverses (Rook and queen)
#alltravs <- c(split(tilenames, row(tilenames)),
#              split(tilenames, col(tilenames)))
#names(alltravs) <- c(1:16)

#all diagonals (bishop and queen)
#alldiags <- c(split(tilenames, row(tilenames) - col(tilenames)),
#              split(tilenames, row(tilenames) + col(tilenames)))

#names(alldiags) <- c(1:30)

# remove diagonals with one element only
#alldiags<- alldiags[which(as.numeric(lapply(1:length(alldiags), function(i) length(alldiags[[i]])))!=1)]
# King moves for each tile

#mat.pad = rbind(NA, cbind(NA, tilenames, NA), NA)

#ind = 2:(ncol(tilenames) + 1) # row/column indices of the "middle"
#neigh = rbind(N  = as.vector(mat.pad[ind - 1, ind    ]),
#              NE = as.vector(mat.pad[ind - 1, ind + 1]),
#              E  = as.vector(mat.pad[ind    , ind + 1]),
#              SE = as.vector(mat.pad[ind + 1, ind + 1]),
#              S  = as.vector(mat.pad[ind + 1, ind    ]),
#              SW = as.vector(mat.pad[ind + 1, ind - 1]),
#              W  = as.vector(mat.pad[ind    , ind - 1]),
#              NW = as.vector(mat.pad[ind - 1, ind - 1]))


#colnames(neigh) <- as.character(tilenames)

#### Knight moves
#mat.pad2 = rbind(NA, NA, cbind(NA, NA, tilenames, NA, NA), NA, NA)

#ind2 = 3:(ncol(tilenames)+2)
#nighty= rbind(NNE = as.vector(mat.pad2[ind2 - 2, ind2 - 1]),
#              NEE = as.vector(mat.pad2[ind2 - 1, ind2 - 2]),
#              SEE = as.vector(mat.pad2[ind2 - 2, ind2 + 1]),
#              SSE = as.vector(mat.pad2[ind2 - 1, ind2 + 2]),
#              SSW = as.vector(mat.pad2[ind2 + 1, ind2 - 2]),
#              SWW = as.vector(mat.pad2[ind2 + 2, ind2 - 1]),
#              NWW = as.vector(mat.pad2[ind2 + 1, ind2 + 2]),
#              NNW = as.vector(mat.pad2[ind2 + 2, ind2 + 1]))

#colnames(nighty) <- as.character(tilenames)

#### pawn
#mat.pad3 = rbind(NA, NA, cbind(NA, NA, tilenames,NA, NA), NA, NA)

#ind = 3:(ncol(tilenames) + 2) # row/column indices of the "middle"
#whitepawns = rbind(
#  N  = as.vector(mat.pad3[ind - 1, ind    ]),
#  dN = as.vector(mat.pad3[ind - 2, ind    ]),
#  NE = as.vector(mat.pad3[ind - 1, ind + 1]),
#  NW = as.vector(mat.pad3[ind - 1, ind - 1]))

#colnames(whitepawns) <- as.character(tilenames)

#whitepawns["dN",] <- ifelse(colnames(whitepawns) %in% c("a2", "b2", "c2", "d2", "e2", "f2", "g2", "h2"),
#                            whitepawns["dN",], NA)

#wpmoves <- whitepawns[c("N", "dN"),]     # NOT NECESSARY I THINK
#wpcaptures <- whitepawns[c("NE", "NW"),] # NOT NECESSARY I THINK


#blackpawns = rbind(S  = as.vector(mat.pad3[ind + 1, ind    ]),
#                   dS = as.vector(mat.pad3[ind + 2, ind    ]),
#                   SE = as.vector(mat.pad3[ind + 1, ind + 1]),
#                   SW = as.vector(mat.pad3[ind + 1, ind - 1]))

#colnames(blackpawns) <- as.character(tilenames)

#blackpawns["dS",] <- ifelse(colnames(blackpawns) %in% c("a7", "b7", "c7", "d7", "e7", "f7", "g7", "h7"),
#                            blackpawns["dS",], NA)


#chesstools <- list(tilenames = tilenames,
#                   init = init,
#                   alldiags = alldiags,
#                   alltravs = alltravs,
#                   whitepawns = whitepawns,
#                   blackpawns = blackpawns,
#                   nighty = nighty,
#                   neigh = neigh)

#save(chesstools, file = "C:/Users/luigi/Desktop/CryptographyR/chess2plyrs/data/chesstools.RData",
#     compress = "xz")
