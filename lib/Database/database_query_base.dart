import 'package:hive/hive.dart';

/// Base Class for the Database Queries
abstract class DatabaseQueryBase<T> {

  String boxName;

  DatabaseQueryBase(this.boxName);

  // Retrieve All Items
  Future<List<T>> retrieveAll() async {
    var itemBox = await Hive.openBox<T>(boxName);
    return itemBox.values.toList();
  }
}