import 'package:medify/database/models/medication.dart';
import 'package:medify/database/database_query_base.dart';

import '../api_handler.dart';

/// Class to Handle Medication Queries
class MedicationQueries extends DatabaseQueryBase<Medication> {
  MedicationQueries() : super("medications");

  @override
  Future<List<Medication>> retrieveAllFromApi() async {
    var jsonData = await ApiHandler.medifyAPI().getData("medications");
    return MedicationList.from(jsonData).medications;
  }

  @override
  Future<Medication> retrieveOneFromApi(int id) async {
    var jsonData = await ApiHandler.medifyAPI().getData("medications/$id");
    return Medication.fromJson(jsonData);
  }

  Future<Medication> insertToApi(Medication data) async {
    var jsonData = await ApiHandler.medifyAPI().getPostData("medications", data.toJson());
    return Medication.fromJsonMedifyAPI(jsonData);
  }
}
