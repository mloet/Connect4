open Printf

module T = ANSITerminal

type command = 
  | Drop of int
  | Quit

exception Empty
exception Invalid

let detect_command h t =
  if h = "drop" then Drop t else
  if h = "quit" then Quit else raise Invalid 

let parse str = 
  match (String.split_on_char ' ' str) with
  | [] -> raise Empty
  | h::t -> detect_command h (int_of_string (Array.of_list t).(0))

let trim_command str : string= String.trim (String.lowercase_ascii (str))

let read_command () =
  match String.trim (read_line ()) with
  | "quit" -> exit 0
  | str -> str

