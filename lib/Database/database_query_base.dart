import 'package:hive/hive.dart';
import 'package:http/http.dart';
import 'package:medify/database/api_handler.dart';
import 'package:medify/database/model_base.dart';

/// Base Class for the Database Queries
abstract class DatabaseQueryBase<T> {
  String boxName;

  DatabaseQueryBase(this.boxName);

  // Retrieve All Items
  Future<List<T>> retrieveAll() async {
    var itemBox = await Hive.openBox<T>(boxName);
    return itemBox.values.toList();
  }

  Future<List<T>> retrieveAllFromApi();

  Future<T> retrieveOneFromApi(int id);
}
