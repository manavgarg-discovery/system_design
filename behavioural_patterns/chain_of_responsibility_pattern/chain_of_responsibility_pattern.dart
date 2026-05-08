// Chain of Responsibility Pattern Example in Dart

// Handler interface
abstract class Handler {
  Handler? next;
  void handle(String request);
}

// Concrete Handlers
class AuthHandler extends Handler {
  @override
  void handle(String request) {
    if (request == 'auth') {
      print('AuthHandler: Handled authentication.');
    } else {
      next?.handle(request);
    }
  }
}

class LoggingHandler extends Handler {
  @override
  void handle(String request) {
    if (request == 'log') {
      print('LoggingHandler: Handled logging.');
    } else {
      next?.handle(request);
    }
  }
}

class DefaultHandler extends Handler {
  @override
  void handle(String request) {
    print('DefaultHandler: No handler for $request.');
  }
}

void main() {
  final auth = AuthHandler();
  final logger = LoggingHandler();
  final defaultHandler = DefaultHandler();

  auth.next = logger;
  logger.next = defaultHandler;

  auth.handle('auth'); // Handled by AuthHandler
  auth.handle('log'); // Handled by LoggingHandler
  auth.handle('other'); // Handled by DefaultHandler
}
