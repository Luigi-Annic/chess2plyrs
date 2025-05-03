# Cosa manca:
#
# - UTILIZZARE CHESSTOOLS$name_of_the_tool CHE CONTIENE INIT, TILENAMES, NEIGH, NIGHTY, WHITEPAWNS, BLACKPAWN
#   in questo modo possiamo eliminare tutti questi elementi singoli sia da .data che da .R e pulire notevolmente
#   i folder
#
#  - Sempre per pulire i folder, eliminare Rook King, Bishop, Queen e Knight come oggetti e traformare piece sulla base
#    della prima lettera usata nella mossa o usando come argomento il noem del pezzo come character.
#    Ci saranno da eliminare
#
#  - Engine :) prima uno che faccia random moves, poi proviamo a implementare minimax algorithm
#
# - funzione che semplifichi l'iserimento della mossa giocata del tipo easymove("Bd5"),
#    sulla base della lunghezza della mossa (l=2 in caso di pedone che non mangia, l=3 in caso di pezzo che non mangia,
#    l = 4/5 in caso di omonimie o catture) e del contenuto (prima lettera minuscola o maiuscola?, ci sono x a indicare catture? arrocco?)
#    riscriviamo make_move5(Piece, startingposition, finalposition)
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


game <- newgame()

game <- make_move4(Pawn, "e2", "e4")
game <- make_move4(Pawn, "d7", "d5")
game <- make_move4(Pawn, "e4", "d5")
game <- make_move4(Pawn, "c7", "c6")
game <- make_move4(Pawn, "d5", "c6")
game <- make_move4(Knight, "g8", "f6")
game <- make_move4(Pawn, "c6", "b7")
game <- make_move4(Knight, "b8", "c6")
game <- make_move4(Pawn, "b7", "c8")
game <- make_move4(Rook, "a8", "c8")

game <- make_move4(Bishop, "f1", "b5")
game <- make_move4(Queen, "d8", "d5")

game <- make_move4(Bishop, "b5", "c6")
game <- make_move4(Rook, "c8", "c6")

game <- make_move4(Knight, "g1", "f3")
game <- make_move4(Queen, "d5", "b5")

all_possibilities()[["w"]][["Kw_e1"]] # The program spots that the king has no legal moves!
game <- make_move4(Pawn, "d2", "d3")
game <- make_move4(Queen, "b5", "b4")

all_possibilities()[["w"]]

game <- make_move4(Pawn, "c2", "c3")
game <- make_move4(Queen, "b4", "e4")

game <- make_move4(Pawn, "d3", "e4")
game <- make_move4(Pawn, "g7", "g6")

all_possibilities()[["w"]][["Kw_e1"]] # Now short castle is available! :)
game <- make_move4(King, "e1", "0-0")

moves_scoresheet()
###

game <- newgame()

game <- make_move4(Pawn, "e2", "e4")
game <- make_move4(Pawn, "d7", "d5")
game <- make_move4(Bishop, "f1", "b5")
game <- make_move4(Bishop, "c8", "d7")
game <- make_move4(Knight, "g1", "f3")
game <- make_move4(Bishop, "d7", "b5")
game <- make_move4(Pawn, "d2", "d3")
game <- make_move4(Knight, "b8", "c6")


game <- make_move4(King, "e1","0-0")

###

game <- newgame()

game<- make_move4(Pawn, "e2", "e4")
game <- make_move4(Pawn, "e7", "e6")
game<- make_move4(Pawn, "d2", "d4")
game <- make_move4(Pawn, "d7", "d5")
game<- make_move4(Pawn, "e4", "d5")
game <- make_move4(Pawn, "e6", "d5")

game <- make_move4(Knight, "g1", "f3")
game <- make_move4(Knight, "g8", "f6")

game <- make_move4(Bishop, "f1", "b5")
game <- make_move4(Knight, "b8", "c6")

game <- make_move4(King, "e1" ,"0-0")
game <- make_move4(Pawn, "a7" ,"a6")

game <- make_move4(Rook, "f1", "e1")
game <- make_move4(Queen, "d8", "e7")

game <- make_move4(Pawn, "h2", "h3")

all_possibilities()[["b"]] # Le inchiodature funzionano: il cavallo in c6 non ha caselle e la donna ha solo quelle sulla linea della torre

game <- make_move4(Queen, "e7", "e4")
game <- make_move4(Pawn, "h3", "h4")

all_possibilities()[["b"]] # FUnziona anche all'indietro, bene
###

game <- newgame()

game <- make_move4(Pawn, "e2", "e4")
game <- make_move4(Pawn, "d7", "d5")
game <- make_move4(Bishop, "f1", "b5")
game <- make_move4(Bishop, "c8", "f5") # The program spots that this move is not valid!! Yuppi
game <- make_move4(Knight, "b8", "c6")
game <- make_move4(Queen, "d1", "e2")

game <- make_move4(Pawn, "e7", "e6")
game <- make_move4(Pawn, "e4", "d5")


game

####

game <- newgame()

game <- make_move4(Pawn, "e2", "e4")
game <- make_move4(Pawn, "c7", "c6")

game <- make_move4(Pawn, "d2", "d4")
game <- make_move4(Pawn, "d7", "d5")

game <- make_move4(Knight, "b1", "c3")
game <- make_move4(Pawn, "d5", "e4")

game <- make_move4(Knight, "c3", "e4")
game <- make_move4(Knight, "g8", "f6")

game <- make_move4(Knight, "e4", "f6")
game <- make_move4(Queen, "d8", "c7") # Invalid!
game <- make_move4(King, "e8", "d7") # Invalid!
game <- make_move4(Pawn, "e7", "f6")

###
game <- newgame()

game <- make_move4(Pawn, "f2", "f4")
game <- make_move4(Pawn, "e7", "e5")
game <- make_move4(Pawn, "g2", "g3")
game <- make_move4(Pawn, "e5", "f4")
game <- make_move4(Pawn, "g3", "f4")

game <- make_move4(Queen, "d8", "h4")

game_result()

###

game <- newgame()

game <- make_move4(Pawn, "e2", "e4")
game <- make_move4(Pawn, "c7", "c6")

game <- make_move4(Pawn, "d2", "d4")
game <- make_move4(Pawn, "d7", "d5")

game <- make_move4(Knight, "b1", "c3")
game <- make_move4(Pawn, "d5", "e4")

game <- make_move4(Knight, "c3", "e4")
game <- make_move4(Knight, "g8", "f6")

game <- make_move4(Queen, "d1", "e2")
game <- make_move4(Knight, "b8", "d7")

#game <- make_move4(Knight, "e4", "f6")
#game_result()

game <- make_move4(Knight, "e4", "d6")
game_result()

####
game <- newgame()

game <- make_move4(Pawn, "e2", "e4")
game <- make_move4(Pawn, "c7", "c6")

game <- make_move4(Pawn, "d2", "d4")
game <- make_move4(Pawn, "d7", "d5")

game <- make_move4(Pawn, "e4", "e5")
game <- make_move4(Pawn, "f7", "f5")

all_possibilities()[["w"]][["pw_e5"]] # en passant is an option now
#game <- make_move4(Pawn, "e5", "f6")

game <- make_move4(Pawn, "a2", "a4")
game <- make_move4(Pawn, "b7", "b5")

all_possibilities()[["w"]][["pw_e5"]] # not anymore

####

game <- newgame()

game <- make_move4(Pawn, "e2", "e4")
game <- make_move4(Pawn, "e7", "e6")

game <- make_move4(Pawn, "d2", "d4")
game <- make_move4(Pawn, "d7", "d5")

game <- make_move4(Pawn, "e4", "e5")
game <- make_move4(King, "e8", "d7")

game <- make_move4(King, "e1", "e2")
game <- make_move4(Knight, "b8", "c6")

game <- make_move4(King, "e2", "f3")
game <- make_move4(Pawn, "g7", "g5")
all_possibilities()[["w"]][["Kw_f3"]]

game <- make_move4(King, "f3", "g4")
game <- make_move4(Pawn, "h7", "h5")

all_possibilities()[["w"]][["Kw_g4"]]


### DOuble check

game <- newgame()

game<- make_move4(Pawn, "e2", "e4")
game <- make_move4(Pawn, "e7", "e6")

game<- make_move4(Pawn, "d2", "d4")
game <- make_move4(Pawn, "d7", "d5")

game<- make_move4(Pawn, "e4", "d5")
game <- make_move4(Pawn, "e6", "d5")

game <- make_move4(Bishop, "c1", "e3")
game <- make_move4(King, "e8", "e7")

game <- make_move4(Queen, "d1", "e2")
game<- make_move4(Pawn, "h7", "h6")

game <- make_move4(Bishop, "e3", "g5")

all_possibilities()[["b"]]

# Serve verificare se doppia inchiodatura funziona correttamente (ad es. se inchiodo un alfiere che sta
# inchiodando il cavallo, rimangono funzionanti le inchiodature? Credo di si ma verifica)
