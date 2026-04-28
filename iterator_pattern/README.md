# Iterator Pattern

### Iterable

An Iterable is a collection of elements that can be accessed sequentially. It represents a sequence of items and provides a way to get an Iterator.

Examples: List, Set, Map.keys, Map.values, etc.
You can use for-in loops directly on an Iterable.

### Iterator

An Iterator is an object that allows you to traverse (step through) the elements of an Iterable one by one.

It has two main members:

* moveNext(): Moves to the next element and returns true if there is one.
* current: Returns the current element.

You get an Iterator from an Iterable by calling its iterator getter.