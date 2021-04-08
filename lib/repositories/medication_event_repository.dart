import 'dart:async';

import 'package:medify/database/model_queries/medication_event_queries.dart';
import 'package:medify/database/models/medication_event.dart';

class MedicationEventRepository {
  final StreamController<List<MedicationEvent>> streamController = StreamController();
  final List<MedicationEvent> medicationEvents = [];
  final MedicationEventQueries medicationEventQueries = MedicationEventQueries();

  Future<List<MedicationEvent>> getMedicationEvents() async {
    var medicationEventsFromAPI = await medicationEventQueries.retrieveAllFromApi(0);
    medicationEvents.addAll(medicationEventsFromAPI);
    streamController.add(medicationEvents);
    return medicationEvents;
  }

  void addMedicationEvents(List<MedicationEvent> events) async {
    // var medicationEventsFromAPI = await medicationEventQueries.insertToAPI();
    medicationEvents.addAll(events);
    streamController.add(medicationEvents);
  }
}
