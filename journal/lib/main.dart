import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:journal/app.dart';

void main() async {
  
  const String schemaPath = 'assets/schema.sql';
  const String dbName = 'journal.db';

  WidgetsFlutterBinding.ensureInitialized();

  await deleteDatabase(dbName);

  final String schema = await rootBundle.loadString(schemaPath);

  final bool skipWelcomePage =  await databaseExists(dbName); 

  final SharedPreferences prefs = await SharedPreferences.getInstance();
  
  Database db = await openDatabase(
    dbName, version: 1, onCreate: (Database db, int version) async {
      await db.execute(schema);
    }
  );
  
  await db.close();
  
  runApp(App(prefs, skipWelcomePage));
}