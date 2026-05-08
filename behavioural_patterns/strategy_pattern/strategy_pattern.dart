/*
Strategy Pattern Implementation in Dart
The Strategy Pattern is a behavioral design pattern that enables selecting an algorithm's behavior at runtime. It defines a family of algorithms, encapsulates each one, and makes them interchangeable. This allows the algorithm to vary independently from clients that use it.
*/

class PaymentService {
  PaymentMethod _paymentMethod;

  PaymentService(this._paymentMethod);

  void processPayment(double amount) {
    _paymentMethod.pay(amount);
  }

  set paymentMethod(PaymentMethod method) => _paymentMethod = method;
  PaymentMethod get paymentMethod => _paymentMethod;
}

// strategy interface
abstract class PaymentMethod {
  void pay(double amount);
}

class CreditCardPayment implements PaymentMethod {
  @override
  void pay(double amount) {
    print('Paying \$${amount.toStringAsFixed(2)} with Credit Card');
  }
}

class DebitCardPayment implements PaymentMethod {
  @override
  void pay(double amount) {
    print('Paying \$${amount.toStringAsFixed(2)} with Debit Card');
  }
}

class UPIpayment implements PaymentMethod {
  @override
  void pay(double amount) {
    print('Paying \$${amount.toStringAsFixed(2)} with UPI');
  }
}

void main() {
  final paymentService = PaymentService(CreditCardPayment());
  paymentService.processPayment(100.0);

  paymentService.paymentMethod = DebitCardPayment();
  paymentService.processPayment(200.0);

  paymentService.paymentMethod = UPIpayment();
  paymentService.processPayment(300.0);
}
