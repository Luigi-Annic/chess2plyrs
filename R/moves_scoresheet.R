#' @title moves_scoresheet
#'
#' @description Creates move scorelist, in beautiful notation
#'
#' @param h game$hstory
#' @param shortnotation Use short scientific notation? TRUE is he default
#'
#' @return moves scoresheet
#' @export
#'

# Creates move scorelist, in beautiful notation
# Note that shortnotation might incur in lack of clarity when two moves are possible
# e.g. when Knight on b3, other Knight on f3, and short move listed as Nd4
# Anyway, the scorelist saved in history also has the starting square so you can look at it in case of doubt

moves_scoresheet <- function(h = game$history, shortnotation = TRUE){
  if (shortnotation == TRUE) {
    h_orig <- h_alt<- h
    substr(h, 2,4) <- "  "
    h <- gsub(" ", "", h)
    h <- gsub("p|_|-", "", h)
    h <- gsub("000", "0-0-0", h)
    h <- gsub("00", "0-0", h)
    h <- gsub("K0-0", "0-0", h)

    substr(h_alt, 1,1) <- substr(h_alt, 3,3) <- " "
    h_alt <- gsub(" ", "", h_alt)

    hfin <- ifelse(paste0(substr(h_orig,1,1), substr(h_orig,4,4)) == "px", h_alt ,h)
  } else hfin = h

  alt <- unlist(lapply(1:length(h), function(j) ifelse(j %%2 == 0, -1, 1)))

  data.frame(n = 1:ceiling(length(h)/2),
             white = hfin[alt == 1],
             black = if (length(h)%%2 == 0) hfin[alt == -1] else c(hfin[alt == -1], ""))
}
