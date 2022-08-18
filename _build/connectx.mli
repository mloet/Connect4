(** Abstract type for values representing Connect X games. *)
type t

(** The type of values that can populate a Connect X game board.*)
type chips = White | Black | Green | Purple | Yellow | Orange | Blue | Red | 
             USA | Moai | Ogre | Skull |
             Pup | Frog | Uni | Dragon |
             Peach | Pineapple | Coconut |
             Heart | Diamond |
             Empty
(** [board_row c] is the number of rows that the Connect X board has in the 
    Connect X game [c]. *)
val board_row : t -> int

(** [board_col c] is the number of colums that the Connect X board has in the 
    Connect X game [c]. *)
val board_col : t -> int

(** [connect_type c] is the number of consecutive chips a player or A.I. needs 
    to have in order to win the Connect X game. 
    Examples:
    - If [connect_type c] evaluates to 4 then the Connect X game is carried out 
      as a normal Connect 4 game where a player would need 4 of the same chips 
      going vertically and horizontally to win. 
    - If [connect_type c] evaluates to 6 then the Connect X game is carried out
      as a Connect 6 game where a player would need 6 of the same chips going 
      vertically and horizontally to win.
    - Etc. 
      Requires: [connect_type c] < [board_row] and [board_col]. *)
val connect_type : t -> int

(** [player_names c] is a list of the names of the players in the Connect X 
    game [c]. 
    Examples: 
    - If two human players, "Alex" and "John," are playing then [player_names c] 
      would evaluate to ["Alex"; "John"] 
    - If a human player, "Alex" and the "A.I." are playing then [player_names c] 
      would evaluate to ["Alex"; "A.I."]*)
val player_names : t -> string * string


(** [empty_board c] is a chips array array representing an empty Connect X game 
    board for the Connect X game [c]. Orginally all the values in this matrix 
    are [Empty] but are mutable to [Yellow] or [Red] if a player places their 
    chip anywhere.
    Requires: The length of this array is equal to [board_row c] and the length 
              of each element in this array is equal to [board_col c]*)
val empty_board : t -> chips array array

(** [init_game_test rows cols ctype names grid] creates a connectx game with 
    given grid. (Used for testing) *)
val init_game_test : int -> int -> int -> string * string 
  -> chips array array -> t

(** [init_game rows cols ctype names chips] initiates a connectx game. *)
val init_game : int -> int -> int -> string * string -> string * string -> t

(** [match_chip_to_string chip] matches chips [chip] to a string 
    representation.*)
val match_chip_to_string : chips -> string

(** [clear_screen unit] clears the terminal. *)
val clear_screen : unit -> unit

(** [match_chip_to_emoji] [chip] matches the type of to an actual emoji
    representation, helpful for printing the grid of emojis.  *)
val match_chip_to_emoji : chips -> string

(** [print_grid_init grid] prints the empty grid with dimensions specified 
    by [grid]. Each entry is [🔳]. *)
val print_grid_init : t -> unit

(** [check_col connectx move] takes in a move as an integer and declares whether
    or not that move is legal. If it is illegal, it fails. If it is legal,
    a chip list is returned of the nonempty chips in that move index's column, 
    from top to bottom. For  example, for connectx.grid = 
    [|[|Red; Blue|]; [|Blue; Empty|]; [|Red; Blue|]|],
    this function will return [Red; Blue; Red] with move=0, and [Blue; Blue] 
    with move=1. *)
val check_col : t -> int -> chips list

(** [legal_move_space connectx move] determines if the move in connectx is
    legal or illegal in terms of whether or not a that specific column
    has space for another chip. If legal, it returns "Legal" and if illegal, 
    it returns "Illegal". *)
val legal_move_space : t -> int -> string

(** [full_board connectx] determines if a board is full, with no further
    legal moves. If the board [connectx] is full it returns true, otherwise
    it returns false *)
val full_board : t -> bool

(** [print_current_grid connectx] prints the current form of connectx.grid *)
val print_current_grid : t -> unit

(** [make_move_player connectx move chip] executes the move if the move is 
    legal. If it is not legal, it will fail with a proper error message. *)
val make_move_player : t -> int -> chips -> unit

(** [make_move_ai connectx move chip] executes the move if the move is legal 
    for the ai. If it is not legal, it will fail with a proper error message. *)
val make_move_ai : t -> int -> chips -> unit

(** [update_grid connectx move playerchip] updates connectx.grid with the
    specified move and chip according to playerchip, and then prints the new
    grid *)
val update_grid : t -> int -> chips -> t

(** [connect_horizontal connectx] checks if the board has "x" in a
    row horizontally of chip [chip], with x corresponding to the connect type 
    specified in the connectx game. Returns true if there is x in a row 
    false otherwise. *)
val connect_horizontal : t -> chips -> bool

(** [connect_vertical connectx] checks if the board has "x" in a
    row vertically, with x corresponding to the connect type specified in
    the connectx game. Returns true if there is x in a row 
    (of either Red or Blue chips), false otherwise. *)
val connect_vertical : t -> chips -> bool

(** [find_different_chip lst chip] is a helper for [left_diagonal_aux], and 
    determines if [chip] is in a given [lst]. If it is, it returns "Found". If 
    not, it returns "DNE". *)
val find_different_chip : 'a list -> 'a -> string 

(** [left_diagonal_aux connectx startrow startcol chip] is a helper. It 
    creates a list of a certain leftward sloping diagonal specified by starting 
    position at row startrow and col startcol in the grid. If the list has 
    length of connect type and is composed of only [chip] chips, it returns 
    true. False otherwise. *)
val left_diagonal_aux : t -> int -> int -> chips -> bool

(** [connect_left_diag connectx chip] returns true if there is a rightward
    sloping diagonal consisting solely of type [chip]. This diagonal must have 
    connectx.connect_type chips of type [chip]. If not, this returns false *)
val connect_left_diag : t -> chips -> bool

(** [right_diagonal_aux connectx startrow startcol chip] is a helper.
    It creates a list of a certain rightward sloping diagonal specified by 
    starting position at row startrow and col startcol in the grid. If the list
     has length of connect type and is composed of only [chip] chips, it 
     returns true. False otherwise. *)
val right_diagonal_aux : t -> int -> int -> chips -> bool

(** [connect_left_diag connectx chip] returns true if there is a leftward
    sloping diagonal consisting solely of type [chip]. This diagonal must have 
    connectx.connect_type chips of type [chip]. If not, this returns false *)
val connect_right_diag : t -> chips -> bool

(** [winning_move connectx move chip] makes a move with [chip], and
    uses the connect checking functions, but instead of returning true or false,
     it returns the chip type of the x-in-a-row chips, and if it is not a 
     winning move, then it returns Empty. *)
val winning_move : t -> int -> chips -> chips

(** [player_chips c] is the chips of the Connect X [c]. *)
val player_chips : t -> string*string

(** [match_string_to_chip chip] matches a string 
    representation of chips [chip] to a chips. *)
val match_string_to_chip : string -> chips

(** [match_num_to_emoji num] matches a int 
    to its emoji representation. *)
val match_num_to_emoji : int -> string

(** [set_terrain connectx] sets the black emoji terrain for a connectx
    game, as long as the rows are greater than or equal to 3. *)
val set_terrain : t -> unit