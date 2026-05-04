# Factory Pattern

Factory pattern is a 

### How is factory used in dart?

In Dart, factory is a keyword on a constructor that lets you control what gets returned — instead of always creating a new instance, you decide what to return:

* an existing instance (singleton)
* a subclass instance
* a cached instance

```dart
class Animal {
  final String type;
  Animal._(this.type); // private constructor

  factory Animal(String type) {
    return switch (type) {
      'dog' => Dog(),
      'cat' => Cat(),
      _ => Animal._(type),
    };
  }
}
```

### Difference between factory and abstract factory?

Factory creates one product. Abstract Factory creates a family of related products. Abstract factory is an abstract class for factory classes.
