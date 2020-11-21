import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

final String tableName = "achat";
final String database = "Historiques.db";
final String column_id = "id";

class HistoriqueCartModel{
  int id;
  int product_id;
  int buyer_id;
  int seller_id;
  int quantity;
  String url;
  int price;
  String name;

  HistoriqueCartModel({this.seller_id,this.buyer_id,this.product_id,this.quantity,this.url,this.price,this.name});

  Map<String,dynamic> toMap(){
    return {
      "seller_id": this.seller_id,
      "buyer_id": this.buyer_id,
      "product_id": this.product_id,
      "quantity": this.quantity,
      "url": this.url,
      "name": this.name,
      "price": this.price,
    };
  }

}





class HistoriqueCartHelper {
  Database db;

  HistoriqueartHelper(){
    initDatabase();
  }

  initDatabase() async {
    db = await openDatabase(
        join(await getDatabasesPath(), database),
        onCreate: (db, version) {
          return db.execute(
              "CREATE TABLE $tableName(id INTEGER PRIMARY KEY AUTOINCREMENT,seller_id INTEGER,buyer_id INTEGER,product_id INTEGER,quantity INTEGER,url TEXT,name TEXT,price INTEGER)");
        },
        version: 1
    );

    print("historique database open with success");
  }



  Future<void> deleteDog(int product_id) async {
    // Get a reference to the database.
    final db = await openDatabase(
        join(await getDatabasesPath(), database),
        onCreate: (db, version) {
          return db.execute(
              "CREATE TABLE $tableName(id INTEGER PRIMARY KEY AUTOINCREMENT,seller_id INTEGER,buyer_id INTEGER,product_id INTEGER,quantity INTEGER)");
        },
        version: 1
    );

    // Remove the Dog from the database.
    await db.delete(
      tableName,
      // Use a `where` clause to delete a specific dog.
      where: "product_id = ?",
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [product_id],
    );
  }



  Future<void> insertTask(HistoriqueCartModel cart) async {
    db = await openDatabase(
        join(await getDatabasesPath(), database),
        onCreate: (db, version) {
          return db.execute(
              "CREATE TABLE $tableName(id INTEGER PRIMARY KEY AUTOINCREMENT,seller_id INTEGER,buyer_id INTEGER,product_id INTEGER,quantity INTEGER,url TEXT,name TEXT,price INTEGER)");
        },
        version: 1
    );
    try {
      db.insert(tableName, cart.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace);
      print(" historique add with  success");
    } catch (_) {
      print(_);
    }
  }







  // A method that retrieves all the dogs from the dogs table.
  Future<List<HistoriqueCartModel>> getModels() async {
    // Get a reference to the database.
    final Database db = await openDatabase(
        join(await getDatabasesPath(), database),
        onCreate: (db, version) {
          return db.execute(
              "CREATE TABLE $tableName(id INTEGER PRIMARY KEY AUTOINCREMENT,seller_id INTEGER,buyer_id INTEGER,product_id INTEGER,quantity INTEGER)");
        },
        version: 1
    );

    // Query the table for all The Dogs.
    final List<Map<String, dynamic>> maps = await db.query(tableName);

    // Convert the List<Map<String, dynamic> into a List<Dog>.
    return List.generate(maps.length, (i) {
      return HistoriqueCartModel(
        seller_id: maps[i]['seller_id'],
        product_id: maps[i]['product_id'],
        quantity: maps[i]['quantity'],
        buyer_id: maps[i]['buyer_id'],
        name: maps[i]['name'],
        price: maps[i]['price'],
        url: maps[i]['url'],
      );
    });
  }




  Future<int> getTotal() async {
    // Get a reference to the database.
    final Database db = await openDatabase(
        join(await getDatabasesPath(), database),
        onCreate: (db, version) {
          return db.execute(
              "CREATE TABLE $tableName(id INTEGER PRIMARY KEY AUTOINCREMENT,seller_id INTEGER,buyer_id INTEGER,product_id INTEGER,quantity INTEGER)");
        },
        version: 1
    );
    int total = 0;
    // Query the table for all The Dogs.
    final List<Map<String, dynamic>> maps = await db.query(tableName);

    // Convert the List<Map<String, dynamic> into a List<Dog>.
    for(var i=0;i<= maps.length;i++) {
      total = total + maps[i]['price'] * int.parse(maps[i]['quantity']);
    }

    return total;

  }



}