import 'package:medify/database/models/medication_event.dart';
import 'package:medify/database/database_query_base.dart';

/// Class to Handle Medication Event Queries
class MedicationEventQueries extends DatabaseQueryBase<MedicationEvent> {
  MedicationEventQueries() : super("medicationEvents");

}