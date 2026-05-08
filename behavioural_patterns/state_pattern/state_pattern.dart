/*
State Pattern Implementation in Dart
Example: Vending Machine

States:
  IdleState      -> waiting for money
  HasMoneyState  -> money inserted, waiting for item selection
  OutOfStockState -> no items left

Transitions are driven by events (insertMoney, selectItem, refund),
not by the client manually setting state.

Flutter Stateful widgets can be seen as a practical application of the State pattern, where the widget's state determines its behavior and appearance.
*/

abstract class VendingMachineState {
  void insertMoney(VendingMachine machine, int amount);
  void selectItem(VendingMachine machine);
  void refund(VendingMachine machine);
}

class VendingMachine {
  VendingMachineState _state;
  int _stock;
  int _balance = 0;

  VendingMachine({required int stock})
    : _stock = stock,
      _state = stock > 0 ? IdleState() : OutOfStockState();

  void setState(VendingMachineState state) => _state = state;

  int get stock => _stock;
  int get balance => _balance;

  void addBalance(int amount) => _balance += amount;
  void resetBalance() => _balance = 0;
  void decrementStock() => _stock--;

  void insertMoney(int amount) => _state.insertMoney(this, amount);
  void selectItem() => _state.selectItem(this);
  void refund() => _state.refund(this);
}

class IdleState implements VendingMachineState {
  @override
  void insertMoney(VendingMachine machine, int amount) {
    machine.addBalance(amount);
    print('Inserted \$$amount. Balance: \$${machine.balance}');
    machine.setState(HasMoneyState());
  }

  @override
  void selectItem(VendingMachine machine) =>
      print('Please insert money first.');

  @override
  void refund(VendingMachine machine) => print('No money to refund.');
}

class HasMoneyState implements VendingMachineState {
  @override
  void insertMoney(VendingMachine machine, int amount) {
    machine.addBalance(amount);
    print('Added \$$amount. Total balance: \$${machine.balance}');
  }

  @override
  void selectItem(VendingMachine machine) {
    print('Dispensing item... Balance \$${machine.balance} consumed.');
    machine.resetBalance();
    machine.decrementStock();
    machine.setState(machine.stock > 0 ? IdleState() : OutOfStockState());
    print('Items remaining: ${machine.stock}');
  }

  @override
  void refund(VendingMachine machine) {
    print('Refunding \$${machine.balance}.');
    machine.resetBalance();
    machine.setState(IdleState());
  }
}

class OutOfStockState implements VendingMachineState {
  @override
  void insertMoney(VendingMachine machine, int amount) {
    print('Out of stock. Returning \$$amount immediately.');
  }

  @override
  void selectItem(VendingMachine machine) => print('Out of stock.');

  @override
  void refund(VendingMachine machine) => print('Nothing to refund.');
}

void main() {
  final machine = VendingMachine(stock: 2);

  machine.selectItem(); // no money yet
  machine.insertMoney(5);
  machine.insertMoney(3); // top up
  machine.selectItem(); // dispenses, 1 item left

  machine.insertMoney(5);
  machine.refund(); // refund before selecting

  machine.insertMoney(5);
  machine.selectItem(); // dispenses, 0 items left

  machine.insertMoney(5); // out of stock, returns money
  machine.selectItem(); // out of stock
}
