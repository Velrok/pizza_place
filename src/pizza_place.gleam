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

pub fn main() {
  new()
  |> echo
}
