#game |>
#  _[["history"]]

#newgame() |>
#  writefen()

#game %>%
# moves_scoresheet()

# Cosa manca:
#
#
#
#  - Engine :) prima uno che faccia random moves, poi proviamo a implementare minimax algorithm
#
#
# - implementazione en passant in situazioni speciali (se il pedone che da scacco e catturabile en passant in questo momento
#    l'en passant non viene vista come mossa che elimina il pezzo attaccante e per cui non viene identificata)
#    simili problemi potrebbero esserci se l'en passant non puo essere giocata per inchiodatura forse (da verificare)
#
# - opening_name() function che dice quale e il nome dell'apertura in game
#
# - Funzione che in caso di "not valid move" vada a cercare di diagnosticare perche la mossa non e valida (
#   re sotto scacco? non corretto il pezzo in startingposition? non puo arrivare dove dice finalposition? inchiodatura?)
#

legalmoves(game = newgame())

newgame() |>
  legalmoves()

newgame() |>
  make_move4("p", "e2", "e4") |>
  make_move4("p", "d7", "d5") |>
  legalmoves()

newgame() |>
  make_move4("p", "e2", "e4") |>
  make_move4("p", "d7", "d5") |>
  make_move4("p", "e4", "d5")

newgame() |>
  make_move4("p", "e2", "e4") |>
  make_move4("p", "d7", "d5") |>
  make_move4("p", "e4", "d5") |>
  make_move4("p", "c7", "c6") |>
  make_move4("p", "d5", "c6") |>
  make_move4("N", "g8", "f6") |>
  make_move4("p", "c6", "b7") |>
  make_move4("N", "b8", "c6") |>
  make_move4("p", "b7", "c8") |>
  make_move4("R", "a8", "c8") |>


  make_move4("B", "f1", "b5") |>
  make_move4("Q", "d8", "d5") |>

  make_move4("B", "b5", "c6") |>
  make_move4("R", "c8", "c6") |>

  make_move4("N", "g1", "f3") |>
  make_move4("Q", "d5", "b5") |>
  #chessplot()
  #all_possibilities() #[["w"]][["Kw_e1"]] # The program spots that the "K" has no legal moves!
  make_move4("p", "d2", "d3") |>
  make_move4("Q", "b5", "b4") |>

#all_possibilities()[["w"]]

  make_move4("p", "c2", "c3") |>
  make_move4("Q", "b4", "e4") |>

  make_move4("p", "d3", "e4") |>
  make_move4("p", "g7", "g6") |>

#all_possibilities()[["w"]][["Kw_e1"]] # Now short castle is available! :)
  make_move4("K", "e1", "0-0") |>
  #chessplot()
  moves_scoresheet()
###


newgame() |>
make_move4("p", "e2", "e4") |>
make_move4("p", "a7", "a6") |>
make_move4("p", "d2", "d4") |>
make_move4("p", "e7", "e6") |>
make_move4("p", "f2", "f4") |>
make_move4("p", "d7", "d5") |>
make_move4("B", "f1", "b5") |>
  legalmoves()

g4 <- newgame() |>
  make_move4("p", "e2", "e4") |>
  make_move4("p", "a7", "a6") |>
  make_move4("p", "h2", "h3") |>
  make_move4("p", "e7", "e6") |>
  make_move4("p", "f2", "f4") |>
  make_move4("p", "d7", "d5") |>
  make_move4("B", "f1", "b5") |>
  make_move4("B", "c8", "d7") |>
  make_move4("N", "g1", "f3") |>
  make_move4("B", "d7", "b5") |>
  make_move4("p", "d2", "d3") |>
  make_move4("N", "b8", "c6") |>
  make_move4("K", "e1","0-0")

g4 |>
  make_move4("Q", "d8", "d7") |>
  make_move4("N", "b1", "c3") |>
  make_move4("K", "e8","0-0-0") |>
  chessplot()

make_move4(g4, "Q", "d8", "d7") # alternative without pipes
###

game <- newgame()

game<- make_move4("p", "e2", "e4")
game <- make_move4("p", "e7", "e6")
game<- make_move4("p", "d2", "d4")
game <- make_move4("p", "d7", "d5")
game<- make_move4("p", "e4", "d5")
game <- make_move4("p", "e6", "d5")

game <- make_move4("N", "g1", "f3")
game <- make_move4("N", "g8", "f6")

game <- make_move4("B", "f1", "b5")
game <- make_move4("N", "b8", "c6")

game <- make_move4("K", "e1" ,"0-0")
game <- make_move4("p", "a7" ,"a6")

game <- make_move4("R", "f1", "e1")
game <- make_move4("Q", "d8", "e7")

game <- make_move4("p", "h2", "h3")

all_possibilities()[["b"]] # Le inchiodature funzionano: il cavallo in c6 non ha caselle e la donna ha solo quelle sulla linea della torre

game <- make_move4("Q", "e7", "e4")
game <- make_move4("p", "h3", "h4")

all_possibilities()[["b"]] # FUnziona anche all'indietro, bene

chessplot()
###

newgame() |>
  make_move4("p", "e2", "e4") |>
  make_move4("p", "d7", "d5") |>
  make_move4("B", "f1", "b5") |>
  #make_move4("B", "c8", "f5") # The program spots that this move is not valid!! Yuppi
  make_move4("N", "b8", "c6") |>
  make_move4("Q", "d1", "e2") |>
  #make_move4("N", "c6", "e5") # The program spots that this move is not valid!! Yuppi
  make_move4("p", "e7", "e6") |>
  make_move4("p", "e4", "d5") |>
  chessplot()

####

game <- newgame()

game <- make_move4("p", "e2", "e4")
game <- make_move4("p", "c7", "c6")

game <- make_move4("p", "d2", "d4")
game <- make_move4("p", "d7", "d5")

game <- make_move4("N", "b1", "c3")
game <- make_move4("p", "d5", "e4")

game <- make_move4("N", "c3", "e4")
game <- make_move4("N", "g8", "f6")

game <- make_move4("N", "e4", "f6")
game <- make_move4("Q", "d8", "c7") # Invalid!
game <- make_move4("K", "e8", "d7") # Invalid!
game <- make_move4("p", "e7", "f6")

chessplot()
###
game <- newgame()

game <- make_move4("p", "f2", "f4")
game <- make_move4("p", "e7", "e5")
game <- make_move4("p", "g2", "g3")
game <- make_move4("p", "e5", "f4")
game <- make_move4("p", "g3", "f4")

game <- make_move4("Q", "d8", "h4")

game_result()
chessplot()
###

game <- newgame()

game <- make_move4("p", "e2", "e4")
game <- make_move4("p", "c7", "c6")

game <- make_move4("p", "d2", "d4")
game <- make_move4("p", "d7", "d5")

game <- make_move4("N", "b1", "c3")
game <- make_move4("p", "d5", "e4")

game <- make_move4("N", "c3", "e4")
game <- make_move4("N", "g8", "f6")

game <- make_move4("Q", "d1", "e2")
game <- make_move4("N", "b8", "d7")

#game <- make_move4("N", "e4", "f6")
#game_result()

game <- make_move4("N", "e4", "d6")
game_result()

chessplot()

####
game <- newgame()

game <- make_move4("p", "e2", "e4")
game <- make_move4("p", "c7", "c6")

game <- make_move4("p", "d2", "d4")
game <- make_move4("p", "d7", "d5")

game <- make_move4("p", "e4", "e5")
game <- make_move4("p", "f7", "f5")

all_possibilities()[["w"]][["pw_e5"]] # en passant is an option now
#game <- make_move4("p", "e5", "f6")
#chessplot()

game <- make_move4("p", "a2", "a4")
game <- make_move4("p", "b7", "b5")

all_possibilities()[["w"]][["pw_e5"]] # not anymore

####

game <- newgame()

game <- make_move4("p", "e2", "e4")
game <- make_move4("p", "e7", "e6")

game <- make_move4("p", "d2", "d4")
game <- make_move4("p", "d7", "d5")

game <- make_move4("p", "e4", "e5")
game <- make_move4("K", "e8", "d7")

game <- make_move4("K", "e1", "e2")
game <- make_move4("N", "b8", "c6")

game <- make_move4("K", "e2", "f3")
game <- make_move4("p", "g7", "g5")
all_possibilities()[["w"]][["Kw_f3"]]

game <- make_move4("K", "f3", "g4")
game <- make_move4("p", "h7", "h5")

all_possibilities()[["w"]][["Kw_g4"]]
chessplot()

### DOuble check

game <- newgame()

game<- make_move4("p", "e2", "e4")
game <- make_move4("p", "e7", "e6")

game<- make_move4("p", "d2", "d4")
game <- make_move4("p", "d7", "d5")

game<- make_move4("p", "e4", "d5")
game <- make_move4("p", "e6", "d5")

game <- make_move4("B", "c1", "e3")
game <- make_move4("K", "e8", "e7")

game <- make_move4("Q", "d1", "e2")
game<- make_move4("p", "h7", "h6")

game <- make_move4("B", "e3", "g5")

all_possibilities()[["b"]]
chessplot()
# Serve verificare se doppia inchiodatura funziona correttamente (ad es. se inchiodo un alfiere che sta
# inchiodando il cavallo, rimangono funzionanti le inchiodature? Credo di si ma verifica)

#####

game <- newgame()
#game <- random_mover()
n <- 1
set.seed(382479)
while (game_result() != 1 & n < 10) {
  n <- n+1
  game <- random_mover()

  chessplot()

}
