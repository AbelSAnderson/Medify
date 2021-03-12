import 'package:medify/database/models/user.dart';
import 'package:medify/database/database_query_base.dart';

/// Class to Handle User Queries
class UserQueries extends DatabaseQueryBase<User> {
  UserQueries() : super("users");
}