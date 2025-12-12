import gleam/io
import gleam/list
import gleam/string

// Our restaunt only has these toppings. They are the best though :D .
pub type Topping {
  Pepperoni
  Cheese
}

// state is a phantom type; doesn't exist at runtime
// only for the type checker
pub type Pizza(state) {
  Pizza(toppings: List(Topping))
}

// Pizza states
pub type Dough

pub type Baked

// Start with an uncooked pizza
fn new() -> Pizza(Dough) {
  Pizza(toppings: [])
}

// We can only add toppings to an uncooked pizza.
fn add_topping(p: Pizza(Dough), t: Topping) -> Pizza(Dough) {
  Pizza(toppings: [t, ..p.toppings])
}

// We can only bake a uncooked Pizza, because baking a pizza twice is not good!
fn bake(p: Pizza(Dough)) -> Pizza(Baked) {
  Pizza(toppings: p.toppings)
}

fn topping_to_string(t: Topping) -> String {
  case t {
    Cheese -> "Cheese"
    Pepperoni -> "Pepperoni"
  }
}

// only only safe to eat baked pizzas not dough
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
