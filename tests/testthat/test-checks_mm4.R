legalmoves(game = newgame())

newgame() |>
  legalmoves()

newgame() |>
  chess_move("p", "e2", "e4") |>
  chess_move("p", "d7", "d5") |>
  legalmoves()

newgame() |>
  chess_move("p", "e2", "e4") |>
  chess_move("p", "d7", "d5") |>
  chess_move("p", "e4", "d5")

newgame() |>
  chess_move("p", "e2", "e4") |>
  chess_move("p", "d7", "d5") |>
  chess_move("p", "e4", "d5") |>
  chess_move("p", "c7", "c6") |>
  chess_move("p", "d5", "c6") |>
  chess_move("N", "g8", "f6") |>
  chess_move("p", "c6", "b7") |>
  chess_move("N", "b8", "c6") |>
  chess_move("p", "b7", "c8") |>
  chess_move("R", "a8", "c8") |>


  chess_move("B", "f1", "b5") |>
  chess_move("Q", "d8", "d5") |>

  chess_move("B", "b5", "c6") |>
  chess_move("R", "c8", "c6") |>

  chess_move("N", "g1", "f3") |>
  chess_move("Q", "d5", "b5") |>
  #chessplot()
  #all_possibilities() #[["w"]][["Kw_e1"]] # The program spots that the "K" has no legal moves!
  chess_move("p", "d2", "d3") |>
  chess_move("Q", "b5", "b4") |>

#all_possibilities()[["w"]]

  chess_move("p", "c2", "c3") |>
  chess_move("Q", "b4", "e4") |>

  chess_move("p", "d3", "e4") |>
  chess_move("p", "g7", "g6") |>

#all_possibilities()[["w"]][["Kw_e1"]] # Now short castle is available! :)
  chess_move("K", "e1", "0-0") |>
  #chessplot()
  moves_scoresheet()
###


newgame() |>
chess_move("p", "e2", "e4") |>
chess_move("p", "a7", "a6") |>
chess_move("p", "d2", "d4") |>
chess_move("p", "e7", "e6") |>
chess_move("p", "f2", "f4") |>
chess_move("p", "d7", "d5") |>
chess_move("B", "f1", "b5") |>
  legalmoves()

g4 <- newgame() |>
  chess_move("p", "e2", "e4") |>
  chess_move("p", "a7", "a6") |>
  chess_move("p", "h2", "h3") |>
  chess_move("p", "e7", "e6") |>
  chess_move("p", "f2", "f4") |>
  chess_move("p", "d7", "d5") |>
  chess_move("B", "f1", "b5") |>
  chess_move("B", "c8", "d7") |>
  chess_move("N", "g1", "f3") |>
  chess_move("B", "d7", "b5") |>
  chess_move("p", "d2", "d3") |>
  chess_move("N", "b8", "c6") |>
  chess_move("K", "e1","0-0")

g4 |>
  chess_move("Q", "d8", "d7") |>
  chess_move("N", "b1", "c3") |>
  chess_move("K", "e8","0-0-0")  |>
  chessplot(style = 2)

chess_move(g4, "Q", "d8", "d7") # alternative without pipes
###

g <- newgame() |>
   chess_move("p", "e2", "e4") |>
   chess_move("p", "e7", "e6") |>
   chess_move("p", "d2", "d4") |>
   chess_move("p", "d7", "d5") |>
   chess_move("p", "e4", "d5") |>
   chess_move("p", "e6", "d5") |>

   chess_move("N", "g1", "f3") |>
   chess_move("N", "g8", "f6") |>

   chess_move("B", "f1", "b5") |>
   chess_move("N", "b8", "c6") |>

   chess_move("K", "e1" ,"0-0") |>
   chess_move("p", "a7" ,"a6") |>

   chess_move("R", "f1", "e1") |>
   chess_move("Q", "d8", "e7") |>

   chess_move("p", "h2", "h3")

all_possibilities(g)[["b"]] # Le inchiodature funzionano: il cavallo in c6 non ha caselle e la donna ha solo quelle sulla linea della torre

chessplot(g, style = 2)

g |>
  chess_move("Q", "e7", "e4") |>
  chess_move("p", "h3", "h4") |>
  legalmoves()  # FUnziona anche all'indietro, bene


###

newgame() |>
  chess_move("p", "e2", "e4") |>
  chess_move("p", "d7", "d5") |>
  chess_move("B", "f1", "b5") |>
  #chess_move("B", "c8", "f5") # The program spots that this move is not valid!! Yuppi
  chess_move("N", "b8", "c6") |>
  chess_move("Q", "d1", "e2") |>
  #chess_move("N", "c6", "e5") # The program spots that this move is not valid!! Yuppi
  chess_move("p", "e7", "e6") |>
  chess_move("p", "e4", "d5") |>
  chessplot(style = 2)

####

g2 <- newgame() |>

   chess_move("p", "e2", "e4") |>
   chess_move("p", "c7", "c6") |>

   chess_move("p", "d2", "d4") |>
   chess_move("p", "d7", "d5") |>

   chess_move("N", "b1", "c3") |>
   chess_move("p", "d5", "e4") |>

   chess_move("N", "c3", "e4") |>
   chess_move("N", "g8", "f6") |>

   chess_move("N", "e4", "f6")

legalmoves(g2)

 chess_move(g2, "Q", "d8", "c7") # Invalid!
 chess_move(g2, "K", "e8", "d7") # Invalid!

 chess_move(g2, "p", "e7", "f6") |>
   chessplot(style = 2)

 ###
g3 <- newgame() |>

  chess_move("p", "f2", "f4") |>
  chess_move("p", "e7", "e5") |>
  chess_move("p", "g2", "g3") |>
  chess_move("p", "e5", "f4") |>
  chess_move("p", "g3", "f4") |>

  chess_move("Q", "d8", "h4")


game_result(g3)
legalmoves(g3)

chessplot(g3, style = 2)
###

g4<- newgame() |>
  chess_move("p", "e2", "e4") |>
  chess_move("p", "c7", "c6") |>

  chess_move("p", "d2", "d4") |>
  chess_move("p", "d7", "d5") |>
  chess_move("N", "b1", "c3") |>
  chess_move("p", "d5", "e4") |>

  chess_move("N", "c3", "e4") |>
  chess_move("N", "g8", "f6") |>

  chess_move("Q", "d1", "e2") |>
  chess_move("N", "b8", "d7") |>

#  chess_move("N", "e4", "f6")
#game_result()

  chess_move("N", "e4", "d6")
game_result(g4)

chessplot(g4, style = 2)

####

g5 <- newgame() |>

  chess_move("p", "e2", "e4") |>
  chess_move("p", "c7", "c6") |>

  chess_move("p", "d2", "d4") |>
  chess_move("p", "d7", "d5") |>

  chess_move("p", "e4", "e5") |>
  chess_move("p", "f7", "f5")

all_possibilities(g5)[["w"]][["pw_e5"]] # en passant is an option now

chess_move(g5 ,"p", "e5", "f6") |>
 chessplot(style = 2)

chess_move(g5 ,"p", "e5", "f6") |>
  moves_scoresheet()

g6 <- g5 |>
  chess_move("p", "a2", "a4") |>
  chess_move("p", "b7", "b5")

all_possibilities(g6)[["w"]][["pw_e5"]] # not anymore

####

g7 <- newgame() |>
  chess_move("p", "e2", "e4") |>
  chess_move("p", "e7", "e6") |>

  chess_move("p", "d2", "d4") |>
  chess_move("p", "d7", "d5") |>

  chess_move("p", "e4", "e5") |>
  chess_move("K", "e8", "d7") |>

  chess_move("K", "e1", "e2") |>
  chess_move("N", "b8", "c6") |>

  chess_move("K", "e2", "f3") |>
  chess_move("p", "g7", "g5")

chessplot(g7, style = 2)
all_possibilities(g7)[["w"]][["Kw_f3"]]

g7 |>
  chess_move("K", "f3", "g4") |>
  chess_move("p", "h7", "h5") |>
  legalmoves()
 # chessplot()

### DOuble check

g8<-   newgame() |>

  chess_move("p", "e2", "e4") |>
  chess_move("p", "e7", "e6") |>

  chess_move("p", "d2", "d4") |>
  chess_move("p", "d7", "d5") |>

  chess_move("p", "e4", "d5") |>
  chess_move("p", "e6", "d5") |>

  chess_move("B", "c1", "e3") |>
  chess_move("K", "e8", "e7") |>

  chess_move("Q", "d1", "e2") |>
  chess_move("p", "h7", "h6") |>

  chess_move("B", "e3", "g5")

legalmoves(g8)
chessplot(g8, style = 2)

# Serve verificare se doppia inchiodatura funziona correttamente (ad es. se inchiodo un alfiere che sta
# inchiodando il cavallo, rimangono funzionanti le inchiodature? Credo di si ma verifica)

#####

randomgame <- newgame()
#game <- random_mover()
n <- 1
set.seed(382479)
while (game_result(randomgame) != 1 & n < 10) {
  n <- n+1
  randomgame <- random_mover(randomgame)

  #chessplot(randomgame)

}

####

set.seed(231)

newgame() |>
random_mover()

####

gm <- newgame() |>
  chess_move("p", "d2", "d4") |>
  chess_move("N", "g8", "h6") |>
  chess_move("Q", "d1", "d2") |>
  chess_move("p", "a7", "a5") |>
  chess_move("p", "e2", "e4") |>
  chess_move("p", "b7", "b5")

t0 <- Sys.time()
get_minimax_move(gm, depth = 1)
Sys.time() -t0 # 5 secs


#t0 <- Sys.time()
#get_minimax_move(gm, depth = 2)
#Sys.time() -t0 # 107 secs


#get_minimax_move(gm, depth = 3)

ck <- newgame() |>

  chess_move("p", "e2", "e4") |>
  chess_move("p", "c7", "c6") |>

  chess_move("p", "d2", "d4") |>
  chess_move("p", "d7", "d5")

t0 <- Sys.time()
get_minimax_move(ck, depth = 1)
Sys.time() -t0 # 5 secs


#t0 <- Sys.time()
#get_minimax_move(ck, depth = 2)
#Sys.time() -t0 # 107 secs


#t0 <- Sys.time()
#get_minimax_move(ck, depth = 3)
#Sys.time() -t0 # almost 2 hours -> alpha beta pruning needed


ck2 <- newgame() |>

  chess_move("p", "e2", "e4") |>
  chess_move("p", "c7", "c6") |>

  chess_move("p", "d2", "d4") |>
  chess_move("p", "d7", "d5") |>
  chess_move("N", "b1", "c3")

get_minimax_move(ck2, depth = 1)

#t0 <- Sys.time()
#get_minimax_move(ck2, depth = 2)
#Sys.time() -t0 # 107 secs


ck3 <- newgame() |>

  chess_move("N", "b1", "c3") |>
  chess_move("p", "e7", "e6") |>

  chess_move("p", "f2", "f4")

get_minimax_move(ck2, depth = 1)


ck4 <- newgame() |>

  chess_move("N", "b1", "a3") |>
  chess_move("p", "e7", "e6") |>

  chess_move("p", "f2", "f4") |>
  chess_move("p", "a7", "a6") |>
  chess_move("p", "h2", "h3") |>
  chess_move("p", "h7", "h6") |>
  chess_move("N", "a3", "b5")

#get_minimax_move(ck4, depth = 1) # "pa6b5"
#get_minimax_move(ck4, depth = 2) # "pa6b5"
#get_minimax_move(ck4, depth = 3) # "Qd8h4" at depth 3 the minimax algorithm sees the checkmate


########

testgame <- newgame()
n <- 0
set.seed(2345) #293847
while (game_result(testgame) != 1 & n < 40) {
  n <- n+1

  #testgame <- if (testgame$turn == 1) random_mover(testgame) else engine1(testgame, 1)

  #if (n%%2 == 0)  chessplot(testgame)

}

#moves_scoresheet(testgame)

#####

testgame2 <- newgame()
n <- 0
set.seed(43787)
while (game_result(testgame2) != 1 & n < 40) {
  n <- n+1

  #testgame2 <- if (testgame2$turn == 1) random_mover(testgame2) else engine1(testgame2, depth = 2)

  #if (n%%2 == 0)  chessplot(testgame2)

}

#moves_scoresheet(testgame2)

 newgame() |>
  chess_move("N", "g1", "f3") |>
  chess_move("N", "b8", "c6") |>
  chess_move("p", "e2", "e3") |>
  legalmoves()

 #####

 g9 <- newgame() |>
   chess_move("N", "g1", "f3") |>
   chess_move("N", "g8", "f6") |>
   chess_move("N", "f3", "g1") |>
   chess_move("N", "f6", "g8") |>
   chess_move("N", "g1", "f3") |>
   chess_move("N", "g8", "f6") |>
   chess_move("N", "f3", "g1") |>
   chess_move("N", "f6", "g8")
