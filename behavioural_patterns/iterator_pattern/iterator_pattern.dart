/*
Iterator Pattern is a behavioural design pattern that provides a way to access the elements of a collection sequentially without exposing its underlying representation.

Key points:
1. It separates the traversal logic from the collection itself.
2. It provides a standard interface for iterating over different types of collections.
3. It allows multiple iterators to traverse the same collection independently.

Usecase:
1. When you want to provide a way to access elements of a collection without exposing its internal structure, such as in a library or SDK.

*/

abstract class MyIterator<T> {
  bool hasNext();
  T getCurrent();
}

class Book {
  final String title;

  Book(this.title);
}

// dart does not have nested classes, so we define the iterator separately
class BookIterator implements MyIterator<Book> {
  final List<Book> _books;
  int _currentIndex = 0;

  BookIterator(this._books);

  @override
  bool hasNext() {
    return _currentIndex < _books.length;
  }

  @override
  Book getCurrent() {
    if (hasNext()) {
      return _books[_currentIndex++];
    }
    throw Exception('No more books to iterate.');
  }
}

class BookCollection {
  final List<Book> _books = [];

  BookIterator createIterator() {
    return BookIterator(_books);
  }

  void addBook(String book) {
    _books.add(Book(book));
  }

  List<Book> get books => _books;
}

void main() {
  final bookCollection = BookCollection();
  bookCollection.addBook('The Great Gatsby');
  bookCollection.addBook('To Kill a Mockingbird');
  bookCollection.addBook('1984');

  // this function saves us if/when we want to change the underlying collection type, e.g. from List to Set
  final iterator = bookCollection.createIterator();

  // here's a wrong way to do it. This way if we change the underlying collection type, we have to change this code as well, which violates the Open/Closed Principle.
  // for (int i = 0; i < bookCollection.books.length; i++) {
  //   print(bookCollection.books[i].title);
  // }

  while (iterator.hasNext()) {
    print(iterator.getCurrent().title);
  }
}
