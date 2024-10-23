import 'package:get/get.dart';
import '../models/taskinspectiontype_model.dart';
import '../database/db_helper.dart';
import '../services/apiservices.dart';

class TaskInspectionTypeController extends GetxController {
  var taskInspectionTypes = <TaskInspectionTypeModel>[].obs;
  final DBHelper dbHelper = DBHelper();
  var isLoading = false.obs; // Add this line to define the loading state

  final ApiService apiService =
      ApiService(); // Create an instance of ApiService

  Future<void> fetchTaskInspectionTypes() async {
    isLoading.value = true; // Set loading to true when fetching starts

    try {
      // Call the fetchTaskInspectionTypes method from ApiService
      final List<dynamic>? fetchedInspectionTypes =
          await apiService.fetchTaskInspectionTypes();

      if (fetchedInspectionTypes != null) {
        taskInspectionTypes.value = fetchedInspectionTypes
            .map((json) => TaskInspectionTypeModel.fromJson(json))
            .toList();

        // Insert fetched task inspection types into the database
        for (var inspectionType in taskInspectionTypes) {
          await dbHelper.insertTaskInspectionType(inspectionType);
        }

        // Optionally print inspection types
        // printTaskInspectionTypes();
      } else {
        throw Exception('No task inspection types fetched');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to load task inspection types');
    } finally {
      isLoading.value = false; // Set loading to false after fetching is done
    }
  }

  void printTaskInspectionTypes() {
    if (taskInspectionTypes.isEmpty) {
      print('No task inspection types found.');
    } else {
      print(
          "Length #############################: ${taskInspectionTypes.length}");
      for (var inspectionType in taskInspectionTypes) {
        print('''
Inspection ID: ${inspectionType.inspectionId}
Inspection Title: ${inspectionType.inspectionTitle}
Inspection Type Image: ${inspectionType.inspectionTypeImage ?? 'N/A'}
Status: ${inspectionType.status}
Created At: ${inspectionType.createdAt ?? 'N/A'}
''');
        print("**************************");
      }
    }
  }
}
