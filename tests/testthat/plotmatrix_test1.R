currentboard <- newgame()[["board"]]

currentboard <- game$board
df <- expand.grid(xcoord = colnames(currentboard), ycoord = rownames(currentboard))

df$tilename <- paste0(df$xcoord, df$ycoord)
df$completepiece <- unlist(lapply(1:64, function(x) currentboard[which(chesstools$tilenames == df$tilename[x])])) 
df$color <- substr(df$completepiece, 2, 2)
df$piece <- substr(df$completepiece, 1, 1)

df$xpos <- unlist(lapply(1:64, function(x) which(letters == df$xcoord[x])))
df$ypos <- as.numeric(as.character(df$ycoord))
library(ggplot2)


ggplot(df,
       aes(x = xpos -0.5, y = ypos -0.5,
           label = piece, colour = color)) + 
  geom_text(size = 6) + 
  theme_bw() + 
  theme(legend.position = "none",
        panel.grid.major = element_blank(),
        panel.grid.minor = element_line(colour = "black",
                                        linewidth = .5)) +
  scale_x_continuous(limits = c(0,8), expand = c(0,0), breaks = seq(0.5,8,1), labels = letters[1:8]) +
  scale_y_continuous(limits = c(0,8), expand = c(0,0), breaks = seq(0.5,8,1), labels = c(1:8)) +
  coord_equal() +
  xlab("") + ylab("")

# Board is correctly oriented, pieces locations (xpos, ypos, need to be mirrored)
# dovuto al fatto che la posizione c(1,1) in ggplot  e in matrix è diversa!
####################

partyNumber <- sample(c(1:5), 16, replace = T)
xcoord <- sample(1:8, 16, replace = T) -0.5
ycoord <- sample(1:8, 16, replace = T) -0.5

partyName <- as.character(partyNumber)

dt <- data.frame(partyNumber = partyNumber,
                 xcoord = xcoord,
                 ycoord = ycoord,
                 partyName = partyName)

dt$partyInitial <- letters[dt$partyNumber]

zp2 <- ggplot(dt,
              aes(x = xcoord, y = ycoord,
                  label = partyInitial, colour = partyName)) + 
  geom_text(size = 6) + 
  scale_colour_brewer(palette = "Paired") + 
  theme_bw() + 
  theme(legend.position = "none",
        panel.grid.major = element_blank(),
        panel.grid.minor = element_line(colour = "black",
                                        linewidth = .5)) +
  scale_x_continuous(limits = c(0,8), expand = c(0,0), breaks = seq(0.5,8,1), labels = letters[1:8]) +
  scale_y_continuous(limits = c(0,8), expand = c(0,0), breaks = seq(0.5,8,1), labels = c(1:8)) +
  coord_equal() +
  xlab("") + ylab("")
print(zp2)  # Initials in the plot, but "a" in the legend


