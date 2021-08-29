import 'package:medify/database1/models/medication_info.dart';
import '../api_handler.dart';
import '../database_query_base.dart';

/// Class to Handle Medication Info Queries
class MedicationInfoQueries extends DatabaseQueryBase<MedicationInfo> {
  MedicationInfoQueries() : super("medicationInfo");

  @override
  Future<List<MedicationInfo>> retrieveAllFromApi(int userId) async {
    var jsonData = await ApiHandler.medifyAPI().getData("medicationInfo?user=$userId");
    return MedicationInfoList.from(jsonData).medicationInfo;
  }

  @override
  Future<MedicationInfo> retrieveOneFromApi(int id) async {
    var jsonData = await ApiHandler.medifyAPI().getData("medicationInfo/$id");
    return MedicationInfo.fromJson(jsonData);
  }

  Future<MedicationInfo> insertToApi(MedicationInfo medicationInfo, int userId) async {
    var jsonData = await ApiHandler.medifyAPI().getPostData("medicationInfo", medicationInfo.toJson(userId));
    return MedicationInfo.fromJson(jsonData);
  }

  Future<void> deleteFromApi(int id) async {
    await ApiHandler.medifyAPI().getDeleteData("medicationInfo/$id", filterResponse: false);
  }
}
