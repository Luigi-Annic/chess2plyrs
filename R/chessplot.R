#' @title chessplot
#'
#' @description chess plot
#'
#' @param currentboard curentboard
#'
#'
#' @return plot
#' @export
#'

chessplot <- function(currentboard = game$board) {

  unicode <- c(
    ` ` = '',
    P='\u2659', R='\u2656', N='\u2658', B='\u2657', Q='\u2655', K='\u2654', # White
    p='\u265F', r='\u265C', n='\u265E', b='\u265D', q='\u265B', k='\u265A'  # Black
  )

  df <- expand.grid(xcoord = colnames(currentboard), ycoord = rownames(currentboard))

  df$tilename <- paste0(df$xcoord, df$ycoord)
  df$completepiece <- unlist(lapply(1:64, function(x) currentboard[which(chesstools$tilenames == df$tilename[x])]))
  df$color <- substr(df$completepiece, 2, 2)
  df$piece <- substr(df$completepiece, 1, 1)

  df$xpos <- unlist(lapply(1:64, function(x) which(letters == df$xcoord[x])))
  df$ypos <- as.numeric(as.character(df$ycoord))

  df$unicodepiece <- ifelse(df$color == "w", toupper(df$piece), toupper(df$piece))
  df$chessunicode <- unlist(lapply(1:64, function(x) unicode[df$unicodepiece[x]]))

  df$id <- 1:64
  #df$tilecol <-  (substr(df$tilename,1,1) %in% c("a", "c", "e", "g") & substr(df$tilename, 2, 2) %in% c(1,3,5,7)) |
  #  (substr(df$tilename,1,1) %in% c("b", "d", "f", "h") & substr(df$tilename, 2, 2) %in% c(2,4,6,8))

  #df$tilecol2 <- ifelse((substr(df$tilename,1,1) %in% c("a", "c", "e", "g") & substr(df$tilename, 2, 2) %in% c(1,3,5,7)) |
  #                        (substr(df$tilename,1,1) %in% c("b", "d", "f", "h") & substr(df$tilename, 2, 2) %in% c(2,4,6,8)),
  #                      "gray30", "gray90")


  print(
    ggplot(df,
           aes(x = xpos -0.5, y = ypos -0.5,
               label = chessunicode, colour = color)) +
      #geom_tile(aes(fill = tilecol), show.legend = FALSE) +
      geom_text(size = 10, na.rm = T) +
      theme(legend.position = "none",
            panel.grid.major = element_blank(),
            panel.grid.minor = element_line(colour = "black",
                                            linewidth = .5)) +
      scale_x_continuous(limits = c(0,8), expand = c(0,0), breaks = seq(0.5,8,1), labels = letters[1:8]) +
      scale_y_continuous(limits = c(0,8), expand = c(0,0), breaks = seq(0.5,8,1), labels = c(1:8)) +
      coord_equal() +
      xlab("") + ylab("") +
      scale_color_manual(values = c(NA, "blue", "darkgreen"))
  )

}
