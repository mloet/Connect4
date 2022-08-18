open ANSITerminal

type chips = White | Black | Green | Purple | Yellow | Orange | Blue | Red | 
             USA | Moai | Ogre | Skull |
             Pup | Frog | Uni | Dragon |
             Peach | Pineapple | Coconut |
             Heart | Diamond |
             Empty

type t = {
  board_row : int;
  board_col : int;
  connect_type : int;
  player_names : string * string;
  pchips : string * string;
  mutable grid : chips array array;
}

let board_row connectx =
  connectx.board_row

let board_col connectx =
  connectx.board_col

let connect_type connectx =
  connectx.connect_type

let player_names connectx =
  connectx.player_names

let player_chips connectx =
  connectx.pchips

let empty_board connectx =
  Array.make_matrix (board_row connectx) (board_col connectx) Empty

type difficulty = 
  | Easy
  | Medium
  | Hard

let init_game_test rows cols ctype names grid = {
  board_row = rows;
  board_col = cols;
  connect_type = ctype;
  player_names =  names;
  grid = grid;
  pchips = ("red", "blue")
}

let init_game rows cols ctype names chips = {
  board_row = rows;
  board_col = cols;
  connect_type = ctype;
  player_names = names;
  pchips = chips;
  grid = Array.make_matrix rows cols Empty
}

let match_string_to_chip chip = 
  match chip with
  | "red" -> Red
  | "blue" -> Blue
  | "white" -> White
  | "black" -> Black
  | "yellow" -> Yellow
  | "orange" -> Orange
  | "purple" -> Purple
  | "green" -> Green
  | "usa" -> USA
  | "moai" -> Moai
  | "ogre" -> Ogre
  | "skull" -> Skull
  | "pup" -> Pup
  | "frog" -> Frog
  | "uni" -> Uni
  | "dragon" -> Dragon
  | "peach" -> Peach
  | "coconut" -> Coconut
  | "pineapple" -> Pineapple
  | "heart" -> Heart
  | "diamond" -> Diamond
  | _ -> Empty

let match_chip_to_string chip = 
  match chip with
  | Empty -> "empty"
  | Red -> "red"
  | Blue -> "blue"
  | White -> "white"
  | Black -> "black"
  | Yellow -> "yellow"
  | Orange -> "orange"
  | Purple -> "purple"
  | Green -> "green"
  | USA -> "usa"
  | Moai -> "moai"
  | Ogre -> "ogre"
  | Skull -> "skull"
  | Pup -> "pup"
  | Frog -> "frog"
  | Uni -> "uni"
  | Dragon -> "dragon"
  | Peach -> "peach"
  | Coconut -> "coconut"
  | Pineapple -> "pineapple"
  | Heart -> "heart"
  | Diamond -> "diamond"

let clear_screen () = 
  ANSITerminal.(erase Screen);
  Sys.command("clear") |> ignore

let match_chip_to_emoji chip = 
  match chip with
  | Empty -> "🔳"
  | Red -> "🔴"
  | Blue -> "🔵"
  | White -> "⚪"
  | Black -> "⚫"
  | Yellow -> "🟡"
  | Orange -> "🟠"
  | Purple -> "🟣"
  | Green -> "🟢"
  | USA -> "🗽"
  | Moai -> "🗿"
  | Ogre -> "👹"
  | Skull -> "💀"
  | Pup -> "🐶"
  | Frog -> "🐸"
  | Uni -> "🦄"
  | Dragon -> "🐲"
  | Peach -> "🍑"
  | Coconut -> "🥥"
  | Pineapple -> "🍍"
  | Heart -> "❤️"
  | Diamond -> "🔶"

let print_grid_init connectx= 
  ANSITerminal.(
    for i = 0 to board_row connectx-1 do
      for k = 0 to board_col connectx-1 do 
        print_string [white] (" 🟨" ^ ((empty_board connectx).(i).(k) |> match_chip_to_emoji) ^ "🟨 ");
      done;
      print_string [white] "\n"
    done
  )

let check_col connectx move= 
  if move > (board_col connectx-1) then failwith "You cant place a chip here, this is not a valid column!"
  else
    let x = ref [] in
    let rows = board_row connectx in
    for i=0 to (board_row connectx -1) do
      if connectx.grid.(rows-1-i).(move) != Empty then 
        x := (connectx.grid.(rows-1-i).(move)) :: !x
    done;
    !x

let legal_move_space connectx move=
  let column = check_col connectx move in
  if List.length column < board_row connectx then "Legal" else "Illegal"

let full_board connectx = 
  let x = ref true in
  for i=0 to (board_col connectx -1) do
    if (legal_move_space connectx i) = "Legal" then x:= false
  done;
  !x

let match_num_to_emoji num = 
  match num with 
  | 1 -> "1️⃣ "
  | 2 -> "2️⃣ "
  | 3 -> "3️⃣ "
  | 4 -> "4️⃣ "
  | 5 -> "5️⃣ "
  | 6 -> "6️⃣ "
  | 7 -> "7️⃣ "
  | 8 -> "8️⃣ "
  | 9 -> "9️⃣ "
  | 10 -> "🔟"
  | _ -> "0️⃣ "

let print_current_grid connectx= 
  ANSITerminal.(
    for i = 0 to board_row connectx-1 do
      print_string [white] " 🟨";
      for k = 0 to board_col connectx-1 do 
        print_string [white] ((connectx.grid).(i).(k) |> match_chip_to_emoji);
      done;
      print_string [white] "🟨 \n";
    done;
    print_string [white] " 🟨";
    for k = 0 to board_col connectx-1 do 
      print_string [white] (match_num_to_emoji(k+1));
    done;
    print_string [white] "🟨 \n 🟨";
    for k = 0 to board_col connectx-1 do 
      print_string [white] ("  ");
    done;
    print_string [white] "🟨 \n"
  )

let make_move_player connectx move chip= 
  if legal_move_space connectx move = "Legal" then
    let col_length_unempty = List.length (check_col connectx move )in
    connectx.grid.(board_row connectx-1 - col_length_unempty).(move) <- chip
  else failwith "You cant place a chip here, this column is full!";
  clear_screen ();
  print_current_grid connectx

let make_move_ai connectx move chip= 
  if legal_move_space connectx move = "Legal" then
    let col_length_unempty = List.length (check_col connectx move )in
    connectx.grid.(board_row connectx-1 - col_length_unempty).(move) <- chip
  else failwith "You cant place a chip here, this column is full!";
  print_current_grid connectx

let update_grid connectx move playerchip= 
  if legal_move_space connectx move = "Legal" 
  then make_move_player connectx move playerchip
  (* begin 
     if playerchip = Red then make_move_player connectx move Red else begin
      if playerchip = Blue then make_move_player connectx move Blue 
     end
     end *)
  else failwith("Illegal move, column is full!"); 
  print_current_grid connectx;
  connectx

let connect_horizontal connectx chip = 
  let winner = ref false in
  let in_a_row = ref 0 in
  for i = 0 to board_row connectx-1 do
    in_a_row:=0;
    for k = 0 to board_col connectx-2 do 
      if connectx.grid.(i).(k) = connectx.grid.(i).(k+1) && 
         connectx.grid.(i).(k) = chip then in_a_row:=!in_a_row+1 else begin
        if (connectx.grid.(i).(k) <> connectx.grid.(i).(k+1)) && 
           !in_a_row < connectx.connect_type-1 then in_a_row:=0
      end
    done;
    if !in_a_row>= connectx.connect_type-1 then winner:=true
  done;
  !winner

let connect_vertical connectx chip = 
  let winner = ref false in
  let in_a_row = ref 0 in
  for i = 0 to board_col connectx-1 do
    in_a_row:=0;
    for k = 0 to board_row connectx-2 do 
      if connectx.grid.(k).(i) = connectx.grid.(k+1).(i) && 
         connectx.grid.(k).(i) = chip then in_a_row:=!in_a_row+1 else begin
        if connectx.grid.(k).(i) <> connectx.grid.(k+1).(i) && 
           !in_a_row < connectx.connect_type-1 then in_a_row:=0 
      end
    done;
    if !in_a_row>= connectx.connect_type-1 then winner:=true
  done;
  !winner

let rec find_different_chip lst chip = match lst with
  | [] -> "DNE"
  | h::t -> if h <> chip then "Found" else find_different_chip t chip

let left_diagonal_aux connectx startrow startcol chip = 
  let lst = ref [] in
  for i = 0 to connectx.connect_type-1 do
    lst:=!lst@[connectx.grid.(startrow+i).(startcol-i)]
  done;
  if find_different_chip !lst chip = "DNE" then true else false

let connect_left_diag connectx chip = 
  let winner = ref false in
  for i = 0 to board_row connectx-1-(connectx.connect_type-1) do
    for k = board_col connectx-1 downto connectx.connect_type-1 do
      if left_diagonal_aux connectx i k chip = true then winner:=true
    done
  done;
  !winner

let right_diagonal_aux connectx startrow startcol chip = 
  let lst = ref [] in
  for i = 0 to connectx.connect_type-1 do
    lst:=!lst@[connectx.grid.(startrow+i).(startcol+i)]
  done;
  if find_different_chip !lst chip = "DNE" then true else false

let connect_right_diag connectx chip = 
  let winner = ref false in
  for i = 0 to board_row connectx-1-(connectx.connect_type-1) do
    for k = 0 to board_col connectx - connectx.connect_type do
      if right_diagonal_aux connectx i k chip = true then winner:=true;
    done
  done;
  !winner

let winning_move connectx move chip = 
  if connect_horizontal connectx chip = true || 
     connect_vertical connectx chip = true ||
     connect_left_diag connectx chip = true || 
     connect_right_diag connectx chip = true
  then chip else Empty

let place_terrain_individual connectx pos = 
  Random.self_init ();
  let rand3 = Random.int 3 in
  if rand3 = 0 then make_move_player connectx pos Black
  else if rand3 = 1 then 
    (make_move_player connectx pos Black;
     make_move_player connectx pos Black;)
  else if rand3 = 2 then 
    (make_move_player connectx pos Black;
     make_move_player connectx pos Black;
     make_move_player connectx pos Black;)


let set_terrain connectx = 
  if connectx.grid = empty_board connectx then
    for i = 0 to board_col connectx-1 do
      place_terrain_individual connectx i
    done;

