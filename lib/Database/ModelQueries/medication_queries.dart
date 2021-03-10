import 'package:medify/Database/Models/medication.dart';
import 'package:medify/Database/database_query_base.dart';

/// Class to Handle Medication Queries
class MedicationQueries extends DatabaseQueryBase<Medication> {
  MedicationQueries() : super("medications");
}