open Connectx
open OUnit2
open Connectai

(** TEST PLAN:

    This Ounit Test Suite tests functions in connectx.ml. It mainly checks whether
    a ConnectX game has been won by checking if the indicated number of chips are 
    in a row (vertically, horizontally and diagonally). The ConnectX game is 
    created using init_game_test. And then is populated with chips using the 
    function update_grid. This function uses a lot of other helper function that 
    are also automatically tested. Besides these manually tested functions, 
    fucntions like connect_vertical are tested using glass box testing. Our 
    testing approach demonstrates correctness of our system because we built 
    various ConnectX games with different board sizes, dropping chips in them and 
    tested to see if a win (certain number of chips aligning) was recognized.  

*)

(** [connect_vertical_test name connectx chip expected_output] tests to see
    if there is connect 'x' of chip [chip] in the grid, vertically. *)
let connect_vertical_test name connectx chip expected_output=
  name >:: (fun _ ->
      assert_equal expected_output (connect_vertical connectx chip))

(** [connect_horizontal_test name connectx chip expected_output] tests to see
    if there is connect 'x' of chip [chip] in the grid, horizontally. *)
let connect_horizontal_test name connectx chip expected_output=
  name >:: (fun _ ->
      assert_equal expected_output (connect_horizontal connectx chip))

(** [connect_left_diag_test name connectx chip expected_output] tests to see
    if there is connect 'x' of chip [chip] in the grid, left-diagonally (\) *)
let connect_left_diag_test name connectx chip expected_output=
  name >:: (fun _ ->
      assert_equal expected_output (connect_left_diag connectx chip))

(** [connect_right_diag_test name connectx chip expected_output] tests to see
    if there is connect 'x' of chip [chip] in the grid, right-diagonally (/) *)
let connect_right_diag_test name connectx chip expected_output=
  name >:: (fun _ ->
      assert_equal expected_output (connect_right_diag connectx chip))

(* Making a new custom grid for the first few cases *)
let c1 = init_game_test 5 7 5 ("John", "Mike")
    [|[|Red; Blue; Blue; Empty; Empty; Empty; Blue;|];
      [|Red; Blue; Empty; Blue; Empty; Blue; Empty|];
      [|Red; Blue; Empty; Empty; Blue; Empty; Empty|];
      [|Red; Blue; Empty; Blue; Empty; Blue; Empty|];
      [|Red; Blue; Blue; Blue; Blue; Blue; Blue;|]|]

(* Using update_grid to make sure it works for the first few test cases. *)
let c2 = init_game_test 6 7 4 ("John", "Mike")
    [|[|Empty; Empty; Empty; Empty; Empty; Empty; Empty|];
      [|Empty; Empty; Empty; Empty; Empty; Empty; Empty|];
      [|Empty; Empty; Empty; Empty; Empty; Empty; Empty|];
      [|Empty; Empty; Empty; Empty; Empty; Empty; Empty|];
      [|Empty; Empty; Empty; Empty; Empty; Empty; Empty|];
      [|Empty; Empty; Empty; Empty; Empty; Empty; Empty|]|]

(* Making a new custom grid for the first few cases *)
let c3 = init_game_test 6 7 5 ("Alex", "Jake")
    [|[|Empty; Blue; Empty; Empty; Empty; Empty; Empty|];
      [|Red; Blue; Blue; Empty; Empty; Empty; Empty|];
      [|Red; Blue; Empty; Blue; Empty; Empty; Empty|];
      [|Red; Blue; Empty; Empty; Blue; Empty; Empty|];
      [|Red; Blue; Empty; Empty; Empty; Blue; Empty|];
      [|Red; Blue; Red; Red; Red; Red; Red|]|]

(* Making a new custom grid for the first few cases *)
let c4 = init_game_test 6 7 4 ("Jay", "Ally")
    [|[|Empty; Empty; Empty; Empty; Empty; Empty; Empty|];
      [|Empty; Empty; Empty; Empty; Empty; Empty; Empty|];
      [|Empty; Empty; Empty; Empty; Empty; Empty; Empty|];
      [|Empty; Empty; Empty; Empty; Empty; Empty; Empty|];
      [|Empty; Empty; Empty; Empty; Empty; Empty; Empty|];
      [|Empty; Empty; Empty; Empty; Empty; Empty; Empty|]|]

(* Making a new custom grid for the first few cases *)
let c5 = init_game_test 5 5 4 ("X", "Y")
    [|[|Empty; Empty; Empty; Empty; Empty|];
      [|Empty; Empty; Empty; Empty; Empty|];
      [|Empty; Empty; Empty; Empty; Empty|];
      [|Empty; Empty; Empty; Empty; Empty|];
      [|Empty; Empty; Empty; Empty; Empty|]|]

(* Making a new custom grid for the first few cases *)
let c6 = init_game_test 6 7 6 ("A", "B")
    [|[|Empty; Empty; Empty; Empty; Empty; Empty; Empty|];
      [|Empty; Empty; Empty; Empty; Empty; Empty; Empty|];
      [|Empty; Empty; Empty; Empty; Empty; Empty; Empty|];
      [|Empty; Empty; Empty; Empty; Empty; Empty; Empty|];
      [|Empty; Empty; Empty; Empty; Empty; Empty; Empty|];
      [|Empty; Empty; Empty; Empty; Empty; Empty; Empty|]|]

(* Making a new custom grid for the first few cases *)
let c7 = init_game_test 2 2 2 ("C", "D")
    [|[|Empty; Empty|];
      [|Empty; Empty|]|]

let edit1 = update_grid c2 0 Red
let edit2 = update_grid c2 0 Blue
let edit3 = update_grid c2 0 Red
let edit4 = update_grid c2 0 Blue
let edit5 = update_grid c2 1 Red
let edit6 = update_grid c2 2 Red
let edit7 = update_grid c2 3 Red
let edit8 = update_grid c2 1 Red
let edit9 = update_grid c2 2 Blue
let edit10 = update_grid c2 3 Blue
let edit11 = update_grid c2 2 Red
let edit12 = update_grid c2 3 Blue
let edit13 = update_grid c2 3 Red
let edit14 = update_grid c2 4 Red
let edit15 = update_grid c2 4 Red
let edit16 = update_grid c2 4 Red
let edit17 = update_grid c2 4 Red
let edit18 = update_grid c2 5 Red
let edit19 = update_grid c2 5 Red
let edit20 = update_grid c2 6 Red

let c4edit1 = update_grid c4 0 Blue
let c4edit2 = update_grid c4 0 Red
let c4edit3 = update_grid c4 0 Blue
let c4edit4 = update_grid c4 0 Red
let c4edit5 = update_grid c4 1 Blue
let c4edit6 = update_grid c4 2 Blue
let c4edit7 = update_grid c4 3 Blue
let c4edit8 = update_grid c4 1 Blue
let c4edit9 = update_grid c4 2 Red
let c4edit10 = update_grid c4 3 Red
let c4edit11 = update_grid c4 2 Blue
let c4edit12 = update_grid c4 3 Red
let c4edit13 = update_grid c4 3 Blue
let c4edit14 = update_grid c4 4 Blue
let c4edit15 = update_grid c4 4 Blue
let c4edit16 = update_grid c4 4 Blue
let c4edit17 = update_grid c4 4 Blue
let c4edit18 = update_grid c4 5 Blue
let c4edit19 = update_grid c4 5 Blue
let c4edit20 = update_grid c4 6 Blue

let c5edit1 = update_grid c5 0 Blue
let c5edit2 = update_grid c5 0 Blue
let c5edit3 = update_grid c5 0 Blue
let c5edit4 = update_grid c5 0 Blue
let c5edit5 = update_grid c5 1 Blue
let c5edit6 = update_grid c5 2 Blue
let c5edit7 = update_grid c5 3 Blue
let c5edit8 = update_grid c5 4 Red
let c5edit9 = update_grid c5 3 Red
let c5edit10 = update_grid c5 2 Red
let c5edit11 = update_grid c5 2 Red
let c5edit12 = update_grid c5 1 Red
let c5edit13 = update_grid c5 1 Red
let c5edit14 = update_grid c5 1 Red

let c6edit1 = update_grid c6 0 Blue
let c6edit2 = update_grid c6 0 Blue
let c6edit3 = update_grid c6 0 Blue
let c6edit4 = update_grid c6 0 Blue
let c6edit5 = update_grid c6 0 Blue
let c6edit6 = update_grid c6 0 Blue
let c6edit7 = update_grid c6 1 Red
let c6edit8 = update_grid c6 1 Red
let c6edit9 = update_grid c6 1 Red
let c6edit10 = update_grid c6 1 Red
let c6edit11 = update_grid c6 1 Red
let c6edit12 = update_grid c6 1 Red
let c6edit13 = update_grid c6 2 Red
let c6edit14 = update_grid c6 3 Red
let c6edit15 = update_grid c6 4 Red
let c6edit16 = update_grid c6 5 Red
let c6edit17 = update_grid c6 6 Red
let c6edit18 = update_grid c4 5 Blue
let c6edit19 = update_grid c4 5 Blue
let c6edit20 = update_grid c4 6 Blue

let c7edit1 = update_grid c7 0 Red
let c7edit2 = update_grid c7 0 Blue
let c7edit3 = update_grid c7 1 Blue
let c7edit4 = update_grid c7 1 Red

let grid_tests = [
  (** For c1 *)
  connect_vertical_test "A vertical connect 5 with Red" c1 Red true;
  connect_vertical_test "A vertical connect 5 with Red" c1 Blue true;
  connect_horizontal_test "A horizontal connect 5 with Blue" c1 Blue true;
  connect_horizontal_test "No horizontal connect 5s with Red" c1 Red false;
  connect_left_diag_test "A left-diagonal connect 5 with Blue" c1 Blue true;
  connect_left_diag_test "No left-diagonal connect 5 with Red" c1 Red false;
  connect_right_diag_test "No left-diagonal connect 5 with Red" c1 Red false;
  connect_right_diag_test "A connect 5 right-diagonally with Blue (c1)" c1 Blue true;

  (** For c2 *)
  connect_vertical_test "No vertical connect 4s with Red" c2 Red true;
  connect_vertical_test "A vertical connect 4 with Blue" c2 Blue false;
  connect_horizontal_test "A horizontal connect 4 with Red" c2 Red true;
  connect_horizontal_test "No horizontal connect 4s with Blue" c2 Blue false;
  connect_left_diag_test "A left-diagonal connect 4 with Red" c2 Red true;
  connect_left_diag_test "No left-diagonal connect 4s with Blue" c2 Blue false;
  connect_right_diag_test "No connect 4 right-diagonally with Blue" c2 Blue false;
  connect_right_diag_test "A connect 4 right-diagonally with Red" c2 Red true;

  (** For c3 *)
  connect_vertical_test "A vertical connect 5 with Red" c3 Red true;
  connect_vertical_test "A vertical connect 5 with Blue" c3 Blue true;
  connect_horizontal_test "A horizontal connect 5 with Red" c3 Red true;
  connect_horizontal_test "No horizontal connect 5s with Blue" c3 Blue false;
  connect_left_diag_test "A left-diagonal connect 5 with Blue" c3 Blue false;
  connect_left_diag_test "No left-diagonal connect 5 with Red" c3 Red false;
  connect_right_diag_test "No right-diagonal connect 5 with Red" c3 Red false;
  connect_right_diag_test "No connect 5 right-diagonally with Blue" c3 Blue true;

  (** For c4 *)
  connect_vertical_test "No vertical connect 4s with Red" c4 Blue true;
  connect_vertical_test "A vertical connect 4 with Blue" c4 Red false;
  connect_horizontal_test "A horizontal connect 4 with Red" c4 Blue true;
  connect_horizontal_test "No horizontal connect 4s with Blue" c4 Red false;
  connect_left_diag_test "A left-diagonal connect 4 with Red" c4 Blue true;
  connect_left_diag_test "No left-diagonal connect 4s with Blue" c4 Red false;
  connect_right_diag_test "No connect 4 right-diagonally with Blue" c4 Red false;
  connect_right_diag_test "A connect 4 right-diagonally with Red" c4 Blue true;

  (** For c5 *)
  connect_vertical_test "Vertical connect 4s with Blue" c5 Blue true;
  connect_vertical_test "No vertical connect 4 with Red" c5 Red false;
  connect_horizontal_test "A horizontal connect 4 with Blue" c5 Blue true;
  connect_horizontal_test "No horizontal connect 4s with Red" c5 Red false;
  connect_left_diag_test "A left-diagonal connect 4 with Red" c5 Red false;
  connect_left_diag_test "No left-diagonal connect 4s with Blue" c5 Blue false;
  connect_right_diag_test "No connect 4 right-diagonally with Blue" c5 Red true;
  connect_right_diag_test "A connect 4 right-diagonally with Red" c5 Blue false;

  (** For c6 *)
  connect_vertical_test "Vertical connect 6s with Blue" c6 Blue true;
  connect_vertical_test "vertical connect 6 with Red" c6 Red true;
  connect_horizontal_test "A horizontal connect 6 with red" c6 Red true;
  connect_horizontal_test "No horizontal connect 6s with Blue" c6 Blue false;
  connect_left_diag_test "No left-diagonal connect 6 with Red" c6 Red false;
  connect_left_diag_test "No left-diagonal connect 6s with Blue" c6 Blue false;
  connect_right_diag_test "No connect 6 right-diagonally with Blue" c6 Blue false;
  connect_right_diag_test "No connect 6 right-diagonally with Red" c6 Red false;

  (** For c7 *)
  connect_vertical_test "No vertical connect 2s with Blue" c7 Blue false;
  connect_vertical_test "No vertical connect 2 with Red" c7 Red false;
  connect_horizontal_test "No horizontal connect 2 with red" c7 Red false;
  connect_horizontal_test "No horizontal connect 2s with blue" c7 Blue false;
  connect_left_diag_test "left-diagonal connect 6 with Red" c7 Red true;
  connect_left_diag_test "No left-diagonal connect 6s with Blue" c7 Blue false;
  connect_right_diag_test "Connect 2 right-diagonally with Blue" c7 Blue true;
  connect_right_diag_test "No connect 2 right-diagonally with Red" c7 Red false;
]

let suite =
  "test suite for connectx"  >::: List.flatten [
    grid_tests;
  ]

let _ = run_test_tt_main suite