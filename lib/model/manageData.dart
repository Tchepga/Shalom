import 'dart:io';
import 'clients.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class ManageData {
  ManageData._();
  static final ManageData db = ManageData._();
  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;

    // if _database is null we instantiate it
    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "shalom.db");
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE if not exists Clients ("
          "immatriculation varchar(10) PRIMARY KEY,"
          "name,"
          "adress TEXT,"
          "model varchar(50),"
          "montant real,"
          "othermontant1 real,"
          "othermontant2 real,"
          "othermontant3 real,"
          "note text,"
          "isSuspect boolean,"
          "status boolean"
          ")");
    });
  }

  Future<void> insertClient(Clients client) async {
    // Get a reference to the database
    final Database db = await database;
    // Insert the Clients into the correct table. You may also specify the
    // `conflictAlgorithm` to use in case the same Clients is inserted twice.
    //
    // await db.execute("drop table Clients");
    // In this case, replace any previous data.
    await db.insert(
      'Clients',
      client.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // A method that will retrieve all the client from the client table
  Future<List<Clients>> getClients() async {
    // Get a reference to the database
    final Database db = await database;

    //db.execute("drop table Clients");

    // Query the table for All The Clients.
    final List<Map<String, dynamic>> maps = await db.query('Clients',orderBy: 'immatriculation');

    // Convert the List<Map<String, dynamic> into a List<Clients>.
    return List.generate(maps.length, (i) {
      return Clients(
        immatriculation: maps[i]['immatriculation'],
        adress: maps[i]['adress'],
        model: maps[i]['model'],
        name: maps[i]['name'],
        montant: maps[i]['montant'],
        othermontant1:maps[i]['othermontant1'],
        othermontant2:maps[i]['othermontant2'],
        othermontant3:maps[i]['othermontant3'],
        note: maps[i]['note'],
        isSuspect: maps[i]['isSuspect'] == 1 ? true : false,
        status: maps[i]['status'] == 1 ? true : false
      );
    });
  }

  Future<void> updateClient(Clients client) async {
  // Get a reference to the database
  final db = await database;

  // Update the given Clients
  await db.update(
    'Clients',
    client.toMap(),
    // Ensure we only update the Clients with a matching id
    where: "immatriculation = ?",
    // Pass the Clients's immatriculation through as a whereArg to prevent SQL injection
    whereArgs: [client.immatriculation],
  );
}

Future<void> deleteClient(String immatriculation) async {
  // Get a reference to the database
  final db = await database;

  // Remove the Client from the Database
  await db.delete(
    'Clients',
    // Use a `where` clause to delete a specific dog
    where: "immatriculation = ?",
    // Pass the Client's immatriculation through as a whereArg to prevent SQL injection
    whereArgs: [immatriculation],
  );
}
}