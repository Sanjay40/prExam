import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../model/Users.dart';

class DatabaseHelper{

  static DatabaseHelper instance = DatabaseHelper();



  static final tableName = "MyTable";

  static Database? _database;
  static final columnId = "id";
  static final columnName = "name";
  static final columnQua = "quantity";
  static final columnAdd = "addToCart";



  // static Future<Database?> get database async {
  //   final databasePath = await getDatabasesPath();
  //   final status  = await databaseExists(databasePath);
  //   if(!status || status != null){
  //     _database = await openDatabase(join(databasePath,_databaseName),
  //       onCreate: (database,version)  {
  //         return database.execute("CREATE TABLE $_tableName("
  //               "$columnId INTEGER PRIMARY KEY AUTOINCREMENT,"
  //               "$columnName TEXT,"
  //               "$columnQua TEXT , "
  //               "$columnAdd TEXT)");
  //       },version:_databaseVersion);
  //   }
  //   return _database;
  // }

  static Future<Database?> get database async {
    final path = await getDatabasesPath();
    final status = await databaseExists(path);
    if (!status || status != null) {
      print("Database");
      _database = await openDatabase(
        join(path, 'MyDatabase.db'),
        onCreate: (database, version) {
          return database.execute(
            "CREATE TABLE $tableName("
                "$columnId INTEGER PRIMARY KEY AUTOINCREMENT,"
                "$columnName TEXT,"
                "$columnQua TEXT,"
                "$columnAdd TEXT)",
          );
        },
        version: 1,
      );
    } else {
      print("Else");
    }
    return _database;
  }


    Future<bool> insert (User user) async {
      final db = await database;
      try{
        db!.insert(tableName, user.toMap());
      } catch(e){
        print("erroe :: ${e}");
        throw Error();
      }
      return true;
    }


  Future<List<User>> retrieveUsers() async {
    Database? db = await database;
    List<Map> list = await db!.rawQuery("SELECT * FROM $tableName");
    List<User> user = [];
    for (int i = 0; i < list.length; i++) {
      user.add(User(name: list[i]['name'], quantity: list[i]['quantity'], addToCart: list[i]['addToCart'],));
    }
    return user;
  }

  Future<int> updataStatic({required  Map<String,dynamic>? user , required String table,required , String? id}) async {
    Database? db = await database;
    return await db!.update(tableName, user!, where: '$columnId = ?' ,whereArgs: [id]);
  }

}