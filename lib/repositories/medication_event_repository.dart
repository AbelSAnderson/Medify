import 'dart:async';

import 'package:medify/database1/model_queries/medication_event_queries.dart';
import 'package:medify/database1/models/medication_event.dart';
import 'package:medify/database1/models/medication_info.dart';

class MedicationEventRepository {
  final StreamController<List<MedicationEvent>> streamController = StreamController();
  final List<MedicationEvent> medicationEvents = [];
  final MedicationEventQueries medicationEventQueries = MedicationEventQueries();

  Future<List<MedicationEvent>> getMedicationEvents() async {
    var medicationEventsFromAPI = await medicationEventQueries.retrieveAllFromApi(0);
    // var medicationEventsFromAPI = DummyData.getMedications();
    medicationEvents.addAll(medicationEventsFromAPI);
    streamController.add(medicationEvents);
    return medicationEvents;
  }

  void addMedicationEvents(MedicationEvent medicationEvent) async {
    var medicationEventsFromAPI = await medicationEventQueries.insertToApi(medicationEvent);
    medicationEvents.addAll(medicationEventsFromAPI);
    streamController.add(medicationEvents);
  }

  void deleteMedicationEvents(MedicationInfo medicationInfo) async {
    medicationEvents.removeWhere((element) => element.medicationInfo.id == medicationInfo.id);
    streamController.add(medicationEvents);
  }
}
