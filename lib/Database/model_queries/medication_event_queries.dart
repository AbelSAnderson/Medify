import 'package:medify/Database/Models/medication_event.dart';
import 'package:medify/Database/database_query_base.dart';

/// Class to Handle Medication Event Queries
class MedicationEventQueries extends DatabaseQueryBase<MedicationEvent> {
  MedicationEventQueries() : super("medicationEvents");

}