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

pub fn main() {
  new()
  |> add_topping(Cheese)
  |> add_topping(Pepperoni)
  |> echo
}
