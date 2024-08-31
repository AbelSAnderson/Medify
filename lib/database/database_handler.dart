import 'package:medify/database/models/medication.dart';
import 'package:medify/database/models/medication_event.dart';
import 'package:medify/database/models/medication_info.dart';
import 'package:medify/database/models/user.dart';
import 'package:path_provider/path_provider.dart' as PathProvider;
import 'package:hive/hive.dart';

/// Handles Database Setup and Additional Operations
class DatabaseHandler {
  initializeHive() async {
    // Grab the File path & use it to initialize Hive
    var filePath = await PathProvider.getApplicationDocumentsDirectory();
    Hive.init(filePath.path);

    // Register Hive Adapters
    Hive.registerAdapter(MedicationAdapter());
    Hive.registerAdapter(MedicationInfoAdapter());
    Hive.registerAdapter(MedicationEventAdapter());
    Hive.registerAdapter(UserAdapter());
  }
}
