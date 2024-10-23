import 'package:get/get.dart';
import '../models/frameworkorganisation_model.dart';
import '../database/db_helper.dart';
import '../services/apiservices.dart';

class FrameworkOrganisationController extends GetxController {
  var frameworkOrganisations = <FrameworkOrganisationModel>[].obs;
  final DBHelper dbHelper = DBHelper();
  var isLoading = false.obs; // Add this line to define the loading state

  final ApiService apiService =
      ApiService(); // Create an instance of ApiService

  Future<void> fetchFrameworkOrganisations() async {
    isLoading.value = true; // Set loading to true when fetching starts

    try {
      // Call the fetchFrameworkOrganisations method from ApiService
      final List<dynamic>? fetchedOrganisations =
          await apiService.fetchFrameworkOrganisations();

      if (fetchedOrganisations != null) {
        frameworkOrganisations.value = fetchedOrganisations
            .map((json) => FrameworkOrganisationModel.fromJson(json))
            .toList();

        // Insert fetched framework organisations into the database
        for (var organisation in frameworkOrganisations) {
          await dbHelper.insertFrameworkOrganisation(organisation);
        }

        // Optionally print organisations
        //  printFrameworkOrganisations();
      } else {
        throw Exception('No framework organisations fetched');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to load framework organisations');
    } finally {
      isLoading.value = false; // Set loading to false after fetching is done
    }
  }

  void printFrameworkOrganisations() {
    if (frameworkOrganisations.isEmpty) {
      print('No framework organisations found.');
    } else {
      print(
          "Length #############################: ${frameworkOrganisations.length}");
      for (var organisation in frameworkOrganisations) {
        print('''
Organisation ID: ${organisation.organisationId}
Parent ID: ${organisation.parentId}
Location Key: ${organisation.locationKey}
Title: ${organisation.title}
Drop Zone: ${organisation.dropZone}
Ex Zone: ${organisation.exZone}
RFID: ${organisation.rfid}
Latitude: ${organisation.latitude}
Longitude: ${organisation.longitude}
Hazards: ${organisation.hazards}
Location Notes: ${organisation.locationNotes}
Confined Space: ${organisation.confinedSpace}
Drops: ${organisation.drops}
Ex: ${organisation.ex}
System Email Users: ${organisation.systemEmailUsers}
Primary Node: ${organisation.primaryNode}
Node Code: ${organisation.nodeCode}
Country: ${organisation.country}
City: ${organisation.city}
GPS: ${organisation.gps}
PIC: ${organisation.pic}
PIC No: ${organisation.picNo}
PIC Email: ${organisation.picEmail}
Created By: ${organisation.createdBy}
Created On: ${organisation.createdOn}
Updated By: ${organisation.updatedBy}
Updated On: ${organisation.updatedOn}
Status: ${organisation.status}
Sync Date: ${organisation.syncDate}
''');
        print("**************************");
      }
    }
  }
}
