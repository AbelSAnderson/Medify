import 'package:http/http.dart';
import 'package:medify/database/models/medication_info.dart';
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

  Future<MedicationInfo> insertToApi(MedicationInfo data, int userId) async {
    var jsonData = await ApiHandler.medifyAPI().getPostData("medicationInfo", data.toJson(userId));
    return MedicationInfo.fromJson(jsonData);
  }

  Future<Response> deleteFromApi(int id) async {
    return await ApiHandler.medifyAPI().getDeleteData("medicationInfo/$id");
  }
}
