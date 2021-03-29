import 'package:hive/hive.dart';
import 'package:medify/database/model_base.dart';

import 'medication_info.dart';

part 'medication_event.g.dart';

@HiveType(typeId: 3)
class MedicationEvent extends ModelBase {
  @HiveField(0)
  int id;

  @HiveField(1)
  DateTime datetime;

  @HiveField(2)
  MedicationInfo medicationInfo;

  @HiveField(3)
  bool medTaken;

  @HiveField(4)
  int amountTaken;

  MedicationEvent(this.id, this.datetime, this.medicationInfo, this.medTaken,
      this.amountTaken);

  // Decode the Medication Event from a json file
  MedicationEvent.fromJson(Map<String, dynamic> json)
      : this.id = json["id"],
        this.datetime = json["date_time"],
        this.medicationInfo = null,
        this.medTaken = json["med_taken"] == 1,
        this.amountTaken = json["amount_taken"];
}

/// MedicationEvent List Class used to decode a list of MedicationEvents
class MedicationEventList {
  final List<MedicationEvent> medicationEvents;

  MedicationEventList(this.medicationEvents);

  MedicationEventList.from(List<dynamic> medicationEventJson)
      : medicationEvents = medicationEventJson.map((e) => MedicationEvent.fromJson(e)).toList();
}
