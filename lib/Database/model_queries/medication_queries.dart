import 'package:medify/database/models/medication.dart';
import 'package:medify/database/database_query_base.dart';

/// Class to Handle Medication Queries
class MedicationQueries extends DatabaseQueryBase<Medication> {
  MedicationQueries() : super("medications");
}