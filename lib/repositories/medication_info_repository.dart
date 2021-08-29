import 'dart:async';

import 'package:medify/database1/model_queries/medication_info_queries.dart';
import 'package:medify/database1/models/medication_info.dart';

class MedicationInfoRepository {
  final StreamController<List<MedicationInfo>> streamController = StreamController();
  final List<MedicationInfo> medicationInfos = [];
  final MedicationInfoQueries medicationInfoQueries = MedicationInfoQueries();

  Future<void> getMedicationInfos(int userId) async {
    var medicationInfosFromAPI = await medicationInfoQueries.retrieveAllFromApi(userId);
    medicationInfos.addAll(medicationInfosFromAPI);
    streamController.add(medicationInfos);
  }

  Future<MedicationInfo> addMedicationInfo(MedicationInfo medicationInfo, int userId) async {
    var medicationInfoFromAPI = await medicationInfoQueries.insertToApi(medicationInfo, userId);
    medicationInfos.add(medicationInfoFromAPI);
    streamController.add(medicationInfos);
    return medicationInfoFromAPI;
  }

  Future<void> deleteMedicationInfo(MedicationInfo medicationInfo) async {
    await medicationInfoQueries.deleteFromApi(medicationInfo.id);
    medicationInfos.removeWhere((element) => element.id == medicationInfo.id);
    streamController.add(medicationInfos);
  }
}
