class Book {
  final String title;

  Book(this.title);
}

// dart already has a built-in Iterator interface, so we can simply implement Iterable in our collection class and use the built-in iterator. This way we don't have to define a separate iterator class, and we can take advantage of Dart's for-in loop and other iterable features.
class BookCollection extends Iterable<Book> {
  final List<Book> _books = [];

  void addBook(String book) {
    _books.add(Book(book));
  }

  @override
  Iterator<Book> get iterator => _books.iterator;
}

void main() {
  final bookCollection = BookCollection();
  bookCollection.addBook('The Great Gatsby');
  bookCollection.addBook('To Kill a Mockingbird');
  bookCollection.addBook('1984');

  // we can now use the built-in for-in loop to iterate over the collection, which is more concise and easier to read.
  final iterator = bookCollection.iterator;
  while (iterator.moveNext()) {
    print(iterator.current.title);
  }
  // also possible
  // for (var book in bookCollection) {
  //   print(book.title);
  // }
}
