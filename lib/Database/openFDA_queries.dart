import 'Models/medication.dart';
import 'api_handler.dart';

class OpenFDAQueries {

  /// Retrieve multiple medications from the openFDA API
  Future<List<Medication>> retrieveMedications(String apiParameters) async {
    return MedicationList.from(await ApiHandler().getData("?$apiParameters")).medications;
  }

  /// Retrieve a single medication from the openFDA API
  Future<Medication> retrieveMedication(String apiParameters) async {
    return (await retrieveMedications(apiParameters)).first;
  }

  /// Retrieve a single medication by Id from the openFDA API
  Future<Medication> retrieveMedicationWhereId(String equals) async {
    return (await retrieveMedications("id=$equals")).first;
  }
}