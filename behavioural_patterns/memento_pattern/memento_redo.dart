/*
Assume you're building a notes application, and you want to implement an undo and redo feature that allows users to revert to a previous state of their notes or advance to a future state.
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

class NoteTimeline {
  final List<Note> _timeline = [];
  int _currentIndex = -1;

  void save(Note note) {
    // If we are not at the end of the history, remove all future states
    if (_currentIndex < _timeline.length - 1) {
      _timeline.removeRange(_currentIndex + 1, _timeline.length);
    }
    _timeline.add(note);
    _currentIndex++;
  }

  Note undo() {
    if (_currentIndex > 0) {
      _currentIndex--;
      return _timeline[_currentIndex];
    }
    throw Exception('No history to undo');
  }

  Note redo() {
    if (_currentIndex < _timeline.length - 1) {
      _currentIndex++;
      return _timeline[_currentIndex];
    }
    throw Exception('No history to redo');
  }
}

void main() {
  final editor = Editor(
    Note(title: 'First Note', content: 'This is the first note.'),
  );
  final timeline = NoteTimeline();

  // Save the initial state
  timeline.save(editor.note);
  // Edit the note
  editor.edit('Second Note', 'This is the second note.');
  // Save the new state
  timeline.save(editor.note);

  print('Current Note: ${editor.note.title} - ${editor.note.content}');

  // Undo to the previous state
  editor.restore(timeline.undo());
  print('After undo: ${editor.note.title} - ${editor.note.content}');

  // Redo to the next state
  editor.restore(timeline.redo());
  print('After redo: ${editor.note.title} - ${editor.note.content}');
}
