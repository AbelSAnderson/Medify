import 'models/medication.dart';
import 'api_handler.dart';

class OpenFDAQueries {

  /// Retrieve multiple medications
  Future<List<Medication>> retrieveMedications(String apiParameters) async {
    return MedicationList.from(await ApiHandler().getData("?$apiParameters")).medications;
  }

  /// Retrieve a single medication
  Future<Medication> retrieveMedication(String apiParameters) async {
    return (await retrieveMedications(apiParameters)).first;
  }

  /// Retrieve a single medication by Id
  Future<Medication> retrieveMedicationWhereId(String equals) async {
    return (await retrieveMedication("id=$equals"));
  }

  /// Retrieve multiple Medications by Medication Name
  Future<List<Medication>> retrieveMedicationsWhereName(String equals) async {
    return (await retrieveMedications("search=_exists_:openfda.brand_name+AND+openfda.brand_name:$equals&limit=20"));
  }
}