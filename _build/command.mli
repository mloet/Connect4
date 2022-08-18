(** Abstract type for commands iin Connect X games. *)
type command =
  | Drop of int
  | Quit

(** [parse str] takes in a command from a player to drop their chip
    in a specific column, or to quit. If the command is empty, Empty is raised. *)
val parse : string -> command 