/*
Decorator Pattern Implementation in Dart
Example: Coffee Shop

Problem without decorator: every combination needs its own subclass.
  PlainCoffee, CoffeeWithMilk, CoffeeWithSugar, CoffeeWithMilkAndSugar...
  → combinatorial explosion as options grow.

Decorator wraps an existing object and adds behavior without modifying it.
Each decorator is itself a Coffee, so decorators can be stacked arbitrarily.
*/

// Component interface
abstract class Coffee {
  String get description;
  double get cost;
}

// Concrete component
class PlainCoffee implements Coffee {
  @override
  String get description => 'Plain Coffee';

  @override
  double get cost => 2.00;
}

// Base decorator — implements Coffee and wraps a Coffee
abstract class CoffeeDecorator implements Coffee {
  final Coffee _coffee;
  CoffeeDecorator(this._coffee);
}

// Concrete decorators
class MilkDecorator extends CoffeeDecorator {
  MilkDecorator(super.coffee);

  @override
  String get description => '${_coffee.description}, Milk';

  @override
  double get cost => _coffee.cost + 0.50;
}

class SugarDecorator extends CoffeeDecorator {
  SugarDecorator(super.coffee);

  @override
  String get description => '${_coffee.description}, Sugar';

  @override
  double get cost => _coffee.cost + 0.25;
}

class WhipDecorator extends CoffeeDecorator {
  WhipDecorator(super.coffee);

  @override
  String get description => '${_coffee.description}, Whip';

  @override
  double get cost => _coffee.cost + 0.75;
}

void main() {
  Coffee coffee = PlainCoffee();
  print('${coffee.description} — \$${coffee.cost}');
  // Plain Coffee — $2.0

  coffee = MilkDecorator(coffee);
  print('${coffee.description} — \$${coffee.cost}');
  // Plain Coffee, Milk — $2.5

  coffee = SugarDecorator(coffee);
  coffee = WhipDecorator(coffee);
  print('${coffee.description} — \$${coffee.cost}');
  // Plain Coffee, Milk, Sugar, Whip — $3.5

  // Same decorators, different order — stack them arbitrarily
  Coffee fancy = WhipDecorator(
    SugarDecorator(SugarDecorator(MilkDecorator(PlainCoffee()))),
  );
  print('${fancy.description} — \$${fancy.cost}');
  // Plain Coffee, Milk, Sugar, Sugar, Whip — $3.75
}
