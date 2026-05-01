/*
Mediator Pattern Implementation in Dart
Example: Chat Room

Without mediator: every User holds references to every other User — O(n²) dependencies.
With mediator: every User holds one reference to ChatRoom — O(n) dependencies.

Components:
  ChatMediator  -> mediator interface
  ChatRoom      -> concrete mediator, owns routing logic
  User          -> colleague, communicates only through the mediator
*/

abstract class ChatMediator {
  void register(User user);
  void sendMessage(String message, User sender);
  void sendPrivateMessage(String message, User sender, String recipientName);
}

class ChatRoom implements ChatMediator {
  final String name;
  final Map<String, User> _users = {};

  ChatRoom(this.name);

  @override
  void register(User user) {
    _users[user.name] = user;
    print('[${user.name} joined $name]');
  }

  @override
  void sendMessage(String message, User sender) {
    print('[${sender.name} -> everyone]: $message');
    for (final user in _users.values) {
      if (user != sender) user.receive(message, sender.name);
    }
  }

  @override
  void sendPrivateMessage(String message, User sender, String recipientName) {
    final recipient = _users[recipientName];
    if (recipient == null) {
      print('[System]: "$recipientName" not found in $name.');
      return;
    }
    print('[${sender.name} -> $recipientName (private)]: $message');
    recipient.receive(message, sender.name);
  }
}

class User {
  final String name;
  final ChatMediator _mediator;

  User(this.name, this._mediator) {
    _mediator.register(this);
  }

  void send(String message) => _mediator.sendMessage(message, this);

  void sendTo(String message, String recipientName) =>
      _mediator.sendPrivateMessage(message, this, recipientName);

  void receive(String message, String senderName) =>
      print('  ${name} received from $senderName: "$message"');
}

void main() {
  final room = ChatRoom('general');

  final alice = User('Alice', room);
  final bob = User('Bob', room);
  final charlie = User('Charlie', room);

  print('');
  alice.send('Hey everyone!');

  print('');
  bob.sendTo('Hey Alice, how are you?', 'Alice');

  print('');
  charlie.sendTo('Who are you?', 'Dave'); // user not in room
}
