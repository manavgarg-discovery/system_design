/*
This pattern is mostly used when we want to save the state of an object and restore it later without violating encapsulation. It allows us to capture and externalize an object's internal state so that it can be restored later, without exposing the details of the object's implementation.

Assume you're building a notes application, and you want to implement an undo feature that allows users to revert to a previous state of their notes. The Memento pattern can help you achieve this by allowing you to save the state of the notes at different points in time and restore it when needed.
*/

class Note {
  final String title;
  final String content;

  const Note({required this.title, required this.content});
}

class Editor {
  Note _note;

  Editor(this._note);

  void edit(String title, String content) {
    _note = Note(title: title, content: content);
  }

  Note get note => _note;

  Note save() {
    return _note;
  }

  void restore(Note note) {
    _note = note;
  }
}

class NoteHistory {
  final List<Note> _history = [];

  void save(Note note) {
    _history.add(note);
  }

  Note undo() {
    if (_history.isNotEmpty) {
      _history.removeLast();
      return _history.last;
    }
    throw Exception('No history to undo');
  }
}

void main() {
  final editor = Editor(
    Note(title: 'First Note', content: 'This is the first note.'),
  );
  final history = NoteHistory();

  // Save the initial state
  history.save(editor.note);
  // Edit the note
  editor.edit('Second Note', 'This is the second note.');
  // Save the new state
  history.save(editor.note);

  print('Current Note: ${editor.note.title} - ${editor.note.content}');
  // Undo the last edit
  editor.restore(history.undo());
  print('After Undo: ${editor.note.title} - ${editor.note.content}');
}
