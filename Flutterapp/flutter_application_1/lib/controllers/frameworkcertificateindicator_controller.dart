import 'package:get/get.dart';
import '../database/db_helper.dart';
import '../models/frameworkcertindicator_model.dart';
import '../services/apiservices.dart';

class FrameworkCertificateIndicatorController extends GetxController {
  var certificateIndicators = <FrameworkCertIndicatorModel>[].obs;
  final DBHelper dbHelper = DBHelper();
  var isLoading = false.obs;

  final ApiService apiService =
      ApiService(); // Create an instance of ApiService

  Future<void> fetchFrameworkCertificateIndicators() async {
    isLoading.value = true;

    try {
      // Call the fetchFrameworkCertificateIndicators method from ApiService
      final List<dynamic>? fetchedIndicators =
          await apiService.fetchFrameworkCertificateIndicators();

      if (fetchedIndicators != null && fetchedIndicators.isNotEmpty) {
        certificateIndicators.value = fetchedIndicators
            .map((json) => FrameworkCertIndicatorModel.fromJson(json))
            .toList();

        // Insert fetched certificate indicators into the database
        for (var indicator in certificateIndicators) {
          await dbHelper.insertCertificateIndicator(indicator);
        }

        // Optionally print certificate indicators
        //printCertificateIndicators();
      } else {
        throw Exception('No certificate indicators fetched');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to load certificate indicators');
    } finally {
      isLoading.value = false;
    }
  }

  void printCertificateIndicators() {
    if (certificateIndicators.isEmpty) {
      print('No certificate indicators found.');
    } else {
      print("Certificate Indicators Length: ${certificateIndicators.length}");

      for (var indicator in certificateIndicators) {
        print('''
Indicator ID: ${indicator.indicatorUniqueId}
Title: ${indicator.title}
Min Value: ${indicator.min}
Max Value: ${indicator.max}
Sort: ${indicator.sort ?? 'N/A'}
Set Limit: ${indicator.setLimit}
Is FH: ${indicator.isFh == 1 ? 'Yes' : 'No'}
CA Title: ${indicator.caTitle ?? 'N/A'}
Created By: ${indicator.createdBy}
Created On: ${indicator.createdOn ?? 'N/A'}
Updated By: ${indicator.updatedBy}
Updated On: ${indicator.updatedOn ?? 'N/A'}
Status: ${indicator.status == 1 ? 'Active' : 'Inactive'}
Sync Date: ${indicator.syncDate}
''');
        print("**************************");
      }
    }
  }
}
