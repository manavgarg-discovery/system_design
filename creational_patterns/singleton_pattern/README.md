# Singleton Pattern

* [Why singletons are not thread safe](https://stackoverflow.com/questions/54036635/what-does-it-exactly-mean-if-a-singleton-is-not-thread-safe)

### How does dart address them?

Dart is single-threaded within an isolate. An isolate is Dart's unit of concurrency — each isolate has its own memory heap and its own thread. Critically, isolates don't share memory — they can only communicate by passing messages (copies of data).


Isolate 1: has its own _instance
Isolate 2: has its own _instance   ← completely separate memory

So a singleton in Dart is singleton within an isolate, not across all isolates. There's no shared memory to race over, so no locking is needed.

### How do you use a singleton across isolates?

You don't. You change the architecture. The closest thing possible is one isolate owning the singleton and others talking to it via messages.