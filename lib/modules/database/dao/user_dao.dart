import 'dart:async';
import 'package:managepassengercar/providers/database.dart';
import 'package:managepassengercar/src/models/api_model.dart';

class UserDao {
  final dbProvider = DatabaseProvider.dbProvider;

  Future<int> createUser(User user) async {
    final db = await dbProvider.database;

    var result = db.insert(userTable, user.toDatabaseJson());
    return result;
  }

  Future<int> deleteUser(int id) async {
    final db = await dbProvider.database;
    var result = await db.delete(userTable, where: "id = ?", whereArgs: [id]);
    return result;
  }

  Future<bool> checkUser(int id) async {
    final db = await dbProvider.database;
    try {
      List<Map> users =
          await db.query(userTable, where: 'id = ?', whereArgs: [id]);
      if (users.length > 0) {
        return true;
      } else {
        return false;
      }
    } catch (error) {
      return false;
    }
  }

  Future<bool> checkType(String id) async {
    final db = await dbProvider.database;
    try {
      List<Map> users =
          await db.query(userTable, where: 'type = ?', whereArgs: [id]);
      if (users.length > 0) {
        return true;
      } else {
        return false;
      }
    } catch (error) {
      return false;
    }
  }
}
