import 'package:medify/Database/Models/user.dart';
import 'package:medify/Database/database_query_base.dart';

/// Class to Handle User Queries
class UserQueries extends DatabaseQueryBase<User> {
  UserQueries() : super("users");
}