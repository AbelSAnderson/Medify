import 'dart:async';

import 'package:medify/database/model_queries/medication_info_queries.dart';
import 'package:medify/database/models/medication_info.dart';

class MedicationInfoRepository {
  final StreamController<List<MedicationInfo>> streamController = StreamController();
  final List<MedicationInfo> medicationInfos = [];
  final MedicationInfoQueries medicationInfoQueries = MedicationInfoQueries();

  Future<void> getMedicationInfos() async {
    var medicationInfosFromAPI = await medicationInfoQueries.retrieveAllFromApi();
    medicationInfos.addAll(medicationInfosFromAPI);
    streamController.add(medicationInfos);
  }

  Future<void> addMedicationInfo(MedicationInfo medicationInfo) async {
    var medicationInfoFromAPI = await medicationInfoQueries.insertToApi(medicationInfo);
    medicationInfos.add(medicationInfoFromAPI);
    streamController.add(medicationInfos);
  }

  Future<void> deleteMedicationInfo(MedicationInfo medicationInfo) async {
    await medicationInfoQueries.deleteFromApi(medicationInfo.id);
    medicationInfos.removeWhere((element) => element.id == medicationInfo.id);
    streamController.add(medicationInfos);
  }
}
