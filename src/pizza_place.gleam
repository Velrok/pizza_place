import gleam/io
import gleam/list
import gleam/string

pub type Topping {
  Pepperoni
  Cheese
}

pub type Pizza(state) {
  Pizza(toppings: List(Topping))
}

pub type Dough

pub type Baked

fn new() -> Pizza(Dough) {
  Pizza(toppings: [])
}

fn add_topping(p: Pizza(Dough), t: Topping) -> Pizza(Dough) {
  Pizza(toppings: [t, ..p.toppings])
}

fn bake(p: Pizza(Dough)) -> Pizza(Baked) {
  Pizza(toppings: p.toppings)
}

fn topping_to_string(t: Topping) -> String {
  case t {
    Cheese -> "Cheese"
    Pepperoni -> "Pepperoni"
  }
}

fn eat(p: Pizza(Baked)) -> Nil {
  io.println(
    "Delicious pizza with "
    <> p.toppings |> list.map(topping_to_string) |> string.join(", "),
  )
}

pub fn main() {
  new()
  |> add_topping(Cheese)
  |> add_topping(Pepperoni)
  |> bake()
  |> eat()
}
