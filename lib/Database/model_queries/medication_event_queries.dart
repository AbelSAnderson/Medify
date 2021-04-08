import 'package:medify/database/models/medication_event.dart';
import 'package:medify/database/database_query_base.dart';

import '../api_handler.dart';

/// Class to Handle Medication Event Queries
class MedicationEventQueries extends DatabaseQueryBase<MedicationEvent> {
  MedicationEventQueries() : super("medicationEvents");

  @override
  Future<List<MedicationEvent>> retrieveAllFromApi(int userId) async {
    var jsonData = await ApiHandler.medifyAPI().getData("events");
    return MedicationEventList.from(jsonData).medicationEvents;
  }

  @override
  Future<MedicationEvent> retrieveOneFromApi(int id) async {
    var jsonData = await ApiHandler.medifyAPI().getData("events/$id");
    return MedicationEvent.fromJson(jsonData);
  }

  Future<MedicationEvent> updateToApi(MedicationEvent medicationEvent) async {
    var jsonData = await ApiHandler.medifyAPI().getPutData("events/${medicationEvent.id}", medicationEvent.toJson());
    return MedicationEvent.fromJson(jsonData);
  }
}
