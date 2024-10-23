import 'package:get/get.dart';
import '../database/db_helper.dart';
import '../models/frameworkcorrectiveaction_model.dart';
import '../services/apiservices.dart';

class FrameworkCorrectiveActionController extends GetxController {
  var correctiveActions = <FrameworkCorrectiveActionModel>[].obs;
  final DBHelper dbHelper = DBHelper();
  var isLoading = false.obs;

  final ApiService apiService =
      ApiService(); // Create an instance of ApiService

  Future<void> fetchFrameworkCorrectiveActions() async {
    isLoading.value = true;

    try {
      // Call the fetchCorrectiveActions method from ApiService
      final List<dynamic>? fetchedActions =
          await apiService.fetchFrameworkCorrectiveActions();

      if (fetchedActions != null) {
        correctiveActions.value = fetchedActions
            .map((json) => FrameworkCorrectiveActionModel.fromJson(json))
            .toList();

        // Insert fetched corrective actions into the database
        for (var action in correctiveActions) {
          await dbHelper.insertCorrectiveAction(action);
        }

        // Optionally print corrective actions
        //  printCorrectiveActions();
      } else {
        throw Exception('No corrective actions fetched');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to load corrective actions');
    } finally {
      isLoading.value = false;
    }
  }

  void printCorrectiveActions() {
    if (correctiveActions.isEmpty) {
      print('No corrective actions found.');
    } else {
      print("Corrective Actions Length: ${correctiveActions.length}");
      for (var action in correctiveActions) {
        print('''
Corrective Action ID: ${action.correctiveActionId ?? 'N/A'}
Parent ID: ${action.parentId}
Title: ${action.title}
CA Code: ${action.caCode}
CA Class: ${action.caClass}
CA Type: ${action.caType ?? 'N/A'}
Standard Reference: ${action.standardRef ?? 'N/A'}
Suggested Remedial: ${action.suggestedRemedial ?? 'N/A'}
Close-out Duration: ${action.closeOutDuration ?? 'N/A'}
Notes: ${action.notes ?? 'N/A'}
CA Status: ${action.caStatus == 1 ? 'Active' : 'Inactive'}
Created By: ${action.createdBy}
Created On: ${action.createdOn}
Updated By: ${action.updatedBy}
Updated On: ${action.updatedOn}
Sync Date: ${action.syncDate}
''');
        print("**************************");
      }
    }
  }
}
