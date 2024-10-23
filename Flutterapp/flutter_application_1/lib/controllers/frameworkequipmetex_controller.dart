import 'package:get/get.dart';
import '../database/db_helper.dart';
import '../models/frameworkequipmentex_model.dart';
import '../services/apiservices.dart';

class FrameworkEquipmentExController extends GetxController {
  var equipmentExList = <FrameworkEquipmentExModel>[]
      .obs; // Observable list for equipment explosion proof details
  final DBHelper dbHelper = DBHelper(); // Database helper instance
  var isLoading = false.obs; // Loading state

  final ApiService apiService =
      ApiService(); // Create an instance of ApiService

  Future<void> fetchFrameworkEquipmentEx() async {
    isLoading.value = true; // Set loading to true

    try {
      // Call the fetchFrameworkEquipmentEx method from ApiService
      final List<dynamic>? fetchedExList =
          await apiService.fetchFrameworkEquipmentEx();

      if (fetchedExList != null) {
        equipmentExList.value = fetchedExList
            .map((json) => FrameworkEquipmentExModel.fromJson(json))
            .toList();

        // Insert fetched equipment explosion proof details into the database
        for (var equipmentEx in equipmentExList) {
          await dbHelper.insertFrameworkEquipmentEx(
              equipmentEx); // Assuming you have this method in your DBHelper
        }
      } else {
        throw Exception('No equipment explosion proof details fetched');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to load equipment explosion proof details');
    } finally {
      isLoading.value = false; // Set loading to false
    }
  }
}
