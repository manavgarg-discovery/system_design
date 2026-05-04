// Two product interfaces
abstract class Button {
  void render();
}

abstract class Checkbox {
  void render();
}

// Windows family
class WindowsButton implements Button {
  void render() => print('Windows Button');
}

class WindowsCheckbox implements Checkbox {
  void render() => print('Windows Checkbox');
}

// Mac family
class MacButton implements Button {
  void render() => print('Mac Button');
}

class MacCheckbox implements Checkbox {
  void render() => print('Mac Checkbox');
}

// Abstract factory — guarantees the family stays consistent
abstract class UIFactory {
  Button createButton();
  Checkbox createCheckbox();
}

class WindowsFactory implements UIFactory {
  Button createButton() => WindowsButton();
  Checkbox createCheckbox() => WindowsCheckbox();
}

class MacFactory implements UIFactory {
  Button createButton() => MacButton();
  Checkbox createCheckbox() => MacCheckbox();
}

// Client — works with any factory, never touches concrete classes
class App {
  final UIFactory factory;
  App(this.factory);

  void render() {
    factory.createButton().render();
    factory.createCheckbox().render();
  }
}

void main() {
  final app = App(MacFactory());
  app.render();
  // Mac Button
  // Mac Checkbox
}
