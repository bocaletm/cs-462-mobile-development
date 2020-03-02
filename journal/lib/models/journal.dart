import 'package:journal/models/journal_entry.dart';
import 'package:sqflite/sqflite.dart';

class Journal {

  static const String _insertQuery = 'INSERT INTO journal_entries(title,body,rating,date_string) VALUES(?, ?, ?, ?)';
  
  static const String _deleteQuery = 'DELETE FROM journal_entries WHERE id = ?';

  static const String _getAllQuery = 'SELECT * FROM journal_entries ORDER BY id';

  final String _dbName;

  List<JournalEntry> _journal = [];

  Journal(this._dbName);

  get entries => _journal;

  Future<int> getEntries() async {
    JournalEntry entry;
    Database db = await openDatabase(_dbName, version: 1);
    List<JournalEntry> journal = [];
    var table = await db.rawQuery(_getAllQuery);
    table.forEach((ent) {
      entry = JournalEntry();
      entry.title = ent['title'];
      entry.body = ent['body'];
      entry.rating = ent['rating'];
      entry.dateString = ent['date_string'];
      journal.add(entry);
    });
    _journal = journal;
    return 0;
  }

  Future<int> addEntry(JournalEntry entry) async {
    Database db = await openDatabase(_dbName, version: 1);
    Future<int> id;
    await db.transaction ((action) async {
      id = action.rawInsert(
        _insertQuery, 
        [ entry.title, entry.body, entry.rating, entry.dateString ]
      );
    });
    await db.close();
    return id;
  }

  Future<int> deleteEntryByID(int id) async {
    Database db = await openDatabase(_dbName, version: 1);
    Future<int> count;
    await db.transaction ((action) async {
      count = action.rawDelete(
        _deleteQuery, 
        [ id ]
      );
    });
    await db.close();
    return count;
  }
}