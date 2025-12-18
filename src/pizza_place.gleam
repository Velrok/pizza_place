import gleam/io
import gleam/list
import gleam/string

// Our restaunt only has these toppings. They are the best though :D .
pub type Topping {
  Pepperoni
  Pineapple
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
    Pineapple -> "Pineapple"
  }
}

// only only safe to eat baked pizzas not dough
fn eat(p: Pizza(Baked)) -> Nil {
  io.println(
    "Delicious pizza with "
    <> p.toppings |> list.map(topping_to_string) |> string.join(", "),
  )
}

// We can judge the pizzas toppings raw or baked.
fn rate_pizza(p: Pizza(a)) -> String {
  case p.toppings {
    [] -> "This is just bread."
    [Pineapple, ..] -> "Pineapple first? Bold choice! 1/10"
    [_, Pineapple] -> "Is that hidden Pineapple? Cheeky 0/10"
    [Pepperoni, Cheese] -> "The classic, love it! 10/10"
    _ -> "Looks fine. 4/10"
  }
}

pub fn main() {
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
