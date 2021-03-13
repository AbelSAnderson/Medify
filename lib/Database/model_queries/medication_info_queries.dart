import 'package:medify/database/models/medication_info.dart';
import '../database_query_base.dart';

/// Class to Handle Medication Info Queries
class MedicationInfoQueries extends DatabaseQueryBase<MedicationInfo> {
  MedicationInfoQueries() : super("medicationInfo");

}