import 'package:medify/database/models/medication_event.dart';

import 'database/models/medication.dart';
import 'database/models/medication_info.dart';
import 'database/models/user.dart';

Map<DateTime, List<MedicationEvent>> getMedicationEvents(Map<DateTime, List<MedicationEvent>> events) {
  Medication med = Medication(null, "Medicine", null, null, null, null);
  var medInfo = MedicationInfo(null, 1, 100, null, null, med);

  List<MedicationEvent> list = [
    MedicationEvent(null, DateTime.now(), medInfo, true, null),
    MedicationEvent(null, DateTime.now(), medInfo, true, null),
    MedicationEvent(null, DateTime.now(), medInfo, true, null),
    MedicationEvent(null, DateTime.now().add(Duration(seconds: 2)), medInfo, false, null),
    MedicationEvent(null, DateTime.utc(2021, 03, 19), medInfo, true, null),
    MedicationEvent(null, DateTime.utc(2021, 03, 18), medInfo, true, null),
    MedicationEvent(null, DateTime.utc(2021, 03, 15), medInfo, false, null),
    MedicationEvent(null, DateTime.utc(2021, 03, 16), medInfo, false, null),
    MedicationEvent(null, DateTime.utc(2021, 03, 16), medInfo, false, null),
    MedicationEvent(null, DateTime.utc(2021, 03, 16), medInfo, false, null),
    MedicationEvent(null, DateTime.utc(2021, 03, 16), medInfo, false, null),
    MedicationEvent(null, DateTime.utc(2021, 03, 16), medInfo, false, null),
    MedicationEvent(null, DateTime.utc(2021, 03, 16), medInfo, false, null),
    MedicationEvent(null, DateTime.utc(2021, 03, 16), medInfo, false, null),
    MedicationEvent(null, DateTime.utc(2021, 03, 16), medInfo, false, null),
    MedicationEvent(null, DateTime.utc(2021, 03, 16), medInfo, false, null),
    MedicationEvent(null, DateTime.utc(2021, 03, 16), medInfo, false, null),
  ];

  for (int i = 0; i < list.length; i++) {
    var dateTime = list[i].datetime;
    var date = DateTime(dateTime.year, dateTime.month, dateTime.day);

    if (events[date] == null) {
      //create new list
      events[date] = [list[i]];
    } else {
      //clone the list and add the new value
      events[date] = List.from(events[date])..addAll([list[i]]);
    }
  }

  return events;
}

List<User> getRequestedUsers() {
  User user1 = User(0, "A", "B", "pharmacyNumber", "doctorNumber");
  User user2 = User(1, "C", "D", "pharmacyNumber", "doctorNumber");

  return [user1, user2];
}

List<User> getConnectedUsers() {
  User user1 = User(0, "E", "F", "pharmacyNumber", "doctorNumber");
  User user2 = User(1, "G", "H", "pharmacyNumber", "doctorNumber");
  User user3 = User(0, "I", "J", "pharmacyNumber", "doctorNumber");
  User user4 = User(1, "K", "L", "pharmacyNumber", "doctorNumber");
  User user5 = User(1, "M", "N", "pharmacyNumber", "doctorNumber");

  return [user1, user2, user3, user4, user5];
}
