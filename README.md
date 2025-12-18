# 🍕 Gleam in 15 Minutes: The Safe Pizza Builder
Thanks for watching the demo! Here is the code we wrote and a quick summary of why Gleam is exciting for us coming from TypeScript and Ruby.

## 🚀 Quick Start
* Install Gleam: [Installation Guide](https://gleam.run/getting-started/installing/#installing-gleam)
* Create a project:
```bash
    gleam new pizza_builder
    cd pizza_builder
    gleam run   # Runs on the Erlang VM
```

## 👨‍🍳 The "Safe Pizza" Code

This single file demonstrates Phantom Types, Immutability, Pattern Matching, and Syntactic Sugar for callbacks.
```gleam
import gleam/io
import gleam/list
import gleam/string

// 1. DOMAIN MODELING
pub type Topping {
  Pepperoni
  Pineapple
  Cheese
}

// 'state' is a Phantom Type.
// It doesn't exist at runtime, but it enforces logic at compile time.
pub type Pizza(state) {
  Pizza(toppings: List(Topping))
}

// The States
pub type Dough
pub type Baked

fn new() -> Pizza(Dough) {
  Pizza(toppings: [])
}

// 2. IMMUTABILITY & TRANSITIONS
fn add_topping(p: Pizza(Dough), t: Topping) -> Pizza(Dough) {
  // Prepends to list (O(1) operation). Returns a NEW record.
  Pizza(toppings: [t, ..p.toppings])
}

// This function acts as a Gatekeeper.
// The compiler guarantees we cannot bake a pizza that is already Baked.
fn bake(p: Pizza(Dough)) -> Pizza(Baked) {
  Pizza(toppings: p.toppings)
}

fn topping_to_string(t: Topping) -> String {
  case t {
    Cheese -> "Cheese"
    Pepperoni -> "Pepperoni"
    Pineapple -> "Pineapple"
  }
}

// We can only eat Baked pizza.
// Passing Pizza(Dough) here results in a build error!
fn eat(p: Pizza(Baked)) -> Nil {
  let list_str = 
    p.toppings 
    |> list.map(topping_to_string) 
    |> string.join(", ")
    
  io.println("Delicious pizza with: " <> list_str)
}

// 3. PATTERN MATCHING
// Accepts generic Pizza(a) so it works on Dough OR Baked
fn rate_pizza(p: Pizza(a)) -> String {
  // We can match on the structure of the list!
  case p.toppings {
    [] -> "This is just bread."
    [Pineapple, ..] -> "Pineapple on top? Bold choice! 1/10"
    [_, Pineapple] -> "Is that hidden Pineapple? Cheeky 0/10"
    [Pepperoni, Cheese] -> "The classic, love it! 10/10"
    _ -> "Looks fine. 4/10"
  }
}

// 4. THE 'USE' SYNTAX (Callback flattening)
fn with_music(song: String, task: fn() -> a) -> a {
  io.println("🎵 Now playing: " <> song)
  let result = task()
  io.println("🎵 " <> song <> " Finished")
  result
}

pub fn main() {
  // 'use' passes the rest of the function as a callback to with_music
  use <- with_music("O Sole Mio")
  
  let baked =
    new()
    |> add_topping(Cheese)
    |> add_topping(Pepperoni) 
    |> bake()

  baked
  |> rate_pizza()
  |> io.println()

  eat(baked)
}
```

🧠 Key Concepts for TS/Ruby Devs
| Feature | Description | Why it's cool |
|---|---|---|
| Phantom Types | Pizza(Dough) vs Pizza(Baked) | We created a "State Machine" in the type system. Illegal states are unrepresentable. |
| **The Pipe ` | >`** | `x |
| Pattern Matching | case list { [A, ..] -> ... } | Much more powerful than switch or if/else. It destructures data while checking conditions. |
| use | use <- wrapper() | Eliminates "Callback Hell" (Pyramid of Doom). Similar to Ruby yield but flatter. |
| JS Interop | gleam build --target javascript | Compiles to readable, human-friendly ES Modules. Zero runtime overhead. |

## 📚 Resources
 * [The Language Tour (Interactive)](https://tour.gleam.run/)
 * [Gleam Discord (Very friendly community)](https://gleam.run/community/)
 * [HexDocs (Standard Library Documentation)](https://hexdocs.pm/gleam_stdlib/)
 * [Gleam Packages](https://packages.gleam.run)
