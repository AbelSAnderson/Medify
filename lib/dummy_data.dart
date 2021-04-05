import 'package:medify/database/models/medication_event.dart';
import 'package:medify/database/models/user_connection.dart';

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
  User user1 = User(0, "A", "B", "pharmacyNumber", "doctorNumber", "fake@email.com");
  User user2 = User(1, "C", "D", "pharmacyNumber", "doctorNumber", "fake@email.com");

  return [user1, user2];
}

List<User> getConnectedUsers() {
  User user1 = User(0, "E", "F", "pharmacyNumber", "doctorNumber", "fake@email.com");
  User user2 = User(1, "G", "H", "pharmacyNumber", "doctorNumber", "fake@email.com");
  User user3 = User(2, "I", "J", "pharmacyNumber", "doctorNumber", "fake@email.com");
  User user4 = User(6, "K", "L", "pharmacyNumber", "doctorNumber", "fake@email.com");
  User user5 = User(7, "M", "N", "pharmacyNumber", "doctorNumber", "fake@email.com");

  return [user1, user2, user3, user4, user5];
}

List<MedicationEvent> getMedications() {
  Medication med = Medication(null, "Advil", "Usage", "Precautions", "Dosage", "Ingredients");
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

  return list;
}

List<MedicationInfo> getMedicationInfos() {
  Medication med = Medication(null, "Advil", "Usage", "Precautions", "Dosage", "Ingredients");
  var medInfo = MedicationInfo(null, 1, 100, DateTime.now(), 1, med);
  List<MedicationInfo> medsList = [];
  for (int i = 0; i < 10; i++) {
    medsList.add(medInfo);
  }
  return medsList;
}

List<UserConnection> getUserConnections() {
  User user1 = User(0, "E", "F", "pharmacyNumber", "doctorNumber", "fake@email.com");
  User user2 = User(1, "G", "H", "pharmacyNumber", "doctorNumber", "fake@email.com");
  User user3 = User(2, "I", "J", "pharmacyNumber", "doctorNumber", "fake@email.com");
  User user4 = User(3, "K", "L", "pharmacyNumber", "doctorNumber", "fake@email.com");
  User user5 = User(4, "M", "N", "pharmacyNumber", "doctorNumber", "fake@email.com");
  UserConnection userConnection1 = UserConnection(user1, Status.requested);
  UserConnection userConnection2 = UserConnection(user2, Status.connected);
  UserConnection userConnection3 = UserConnection(user3, Status.requested);
  UserConnection userConnection4 = UserConnection(user4, Status.connected);
  UserConnection userConnection5 = UserConnection(user5, Status.connected);

  var userConnections = [userConnection1, userConnection2, userConnection3, userConnection4, userConnection5];

  return userConnections;
}
