import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

class ApiService {
  static const String _baseUrl = 'http://10.0.2.2:3000/api/v1';
  //static const String _baseUrl = 'http://192.168.1.37:3000/api/v1';

  // Directly use the provided Bearer token
  final String _apiToken =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjExMiwiZW1haWwiOiJzYXR5YW1yaWd0ZWFtQGdtYWlsLmNvbSIsImlhdCI6MTcyNjk0NzE3NX0.hW1XjBwuH8wGJLxBltB3Qi4tFBX_Jux6Y2ahoKKD5f4';

  Map<String, String> _getHeaders() {
    return {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $_apiToken',
    };
  }

//http://192.168.1.37:3000/api/v1/frameworks/getCertificates
  Future<List<dynamic>?> fetchCertificates() async {
    final url = Uri.parse(
        '$_baseUrl/frameworks/getCertificates'); // Updated endpoint for fetching certificates
//192.168.1.37
    // final url =
    //     Uri.parse('http://192.168.1.40:3000/api/v1/frameworks/getCertificates');
    try {
      final response = await http.get(url, headers: _getHeaders());
      if (response.statusCode == 200) {
        return jsonDecode(
            response.body); // Return the list of certificates if successful
      } else {
        log('Failed to load data from API: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      log('Error in API call: $e');
    }
    return null; // Return null if there was an error
  }

  // Fetching task inspection types from API
  //http://localhost:3000/api/v1/tasks/getInspectionTypes
  Future<List<dynamic>?> fetchTaskInspectionTypes() async {
    final url = Uri.parse('$_baseUrl/tasks/getInspectionTypes');
    // Updated endpoint for fetching task inspection

    // final url =
    //     Uri.parse('http://192.168.1.40:3000/api/v1/tasks/getInspectionTypes');
    try {
      final response = await http.get(url, headers: _getHeaders());
      if (response.statusCode == 200) {
        return jsonDecode(response
            .body); // Return the list of task inspection types if successful
      } else {
        log('Failed to load data from API: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      log('Error in API call: $e');
    }
    return null; // Return null if there was an error
  }

  // Fetching framework organisations from API
  // http://localhost:3000/api/v1/frameworks/getLocations

  Future<List<dynamic>?> fetchFrameworkOrganisations() async {
    final url = Uri.parse(
        '$_baseUrl/frameworks/getLocations'); // Updated endpoint for fetching framework organisations

    // final url =
    //     Uri.parse('http://192.168.1.40:3000/api/v1/frameworks/getLocations');
    try {
      final response = await http.get(url, headers: _getHeaders());
      if (response.statusCode == 200) {
        return jsonDecode(response
            .body); // Return the list of framework organisations if successful
      } else {
        log('Failed to load data from API: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      log('Error in API call: $e');
    }
    return null; // Return null if there was an error
  }

  // Fetching certificate indicators from API
  //http://localhost:3000/api/v1/frameworks/getIndicators/245
  Future<List<dynamic>?> fetchFrameworkCertificateIndicators() async {
    final url = Uri.parse(
        '$_baseUrl/frameworks/getIndicators'); // Endpoint for fetching certificate indicators

    // final url = Uri.parse(
    //     'http://192.168.1.40:3000/api/v1/frameworks/getIndicators/245');
    try {
      final response = await http.get(url, headers: _getHeaders());
      if (response.statusCode == 200) {
        return jsonDecode(response
            .body); // Return the list of certificate indicators if successful
      } else {
        log('Failed to load data from API: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      log('Error in API call: $e');
    }
    return null; // Return null if there was an error
  }

// Fetching corrective actions from API
//http://localhost:3000/api/v1/frameworks/getFrmCorrectiveActions
  Future<List<dynamic>?> fetchFrameworkCorrectiveActions() async {
    final url = Uri.parse(
        '$_baseUrl/frameworks/getFrmCorrectiveActions'); // Endpoint for fetching corrective actions

    // final url = Uri.parse(
    //     'http://192.168.1.40:3000/api/v1/frameworks/getFrmCorrectiveActions');
    try {
      final response = await http.get(url, headers: _getHeaders());
      if (response.statusCode == 200) {
        return jsonDecode(response
            .body); // Return the list of corrective actions if successful
      } else {
        log('Failed to load data from API: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      log('Error in API call: $e');
    }
    return null; // Return null if there was an error
  }

  // Fetching equipment certifications from API
// http://localhost:3000/api/v1/frameworks/getEquipmentCertifications
  Future<List<dynamic>?> fetchFrameworkEquipmentCert() async {
    final url = Uri.parse(
        '$_baseUrl/frameworks/getFrmEquipmentCerts'); // Updated endpoint for fetching equipment certifications

    try {
      final response = await http.get(url, headers: _getHeaders());
      if (response.statusCode == 200) {
        return jsonDecode(response
            .body); // Return the list of equipment certifications if successful
      } else {
        log('Failed to load data from API: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      log('Error in API call: $e');
    }
    return null; // Return null if there was an error
  }

  // Fetching equipment standards from API
  Future<List<dynamic>?> fetchFrameworkEquipmentStandards() async {
    final url = Uri.parse(
        '$_baseUrl/frameworks/getFrmEquipmentStandard'); // Updated endpoint for fetching equipment standards

    try {
      final response = await http.get(url, headers: _getHeaders());
      if (response.statusCode == 200) {
        return jsonDecode(response
            .body); // Return the list of equipment standards if successful
      } else {
        log('Failed to load data from API: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      log('Error in API call: $e');
    }
    return null; // Return null if there was an error
  }

  // Fetching equipment explosion proof details from API
  Future<List<dynamic>?> fetchFrameworkEquipmentEx() async {
    final url = Uri.parse(
        '$_baseUrl/frameworks/getFrmEquipmentEx'); // Updated endpoint for fetching equipment explosion proof details

    try {
      final response = await http.get(url, headers: _getHeaders());
      if (response.statusCode == 200) {
        return jsonDecode(response
            .body); // Return the list of equipment explosion proof details if successful
      } else {
        log('Failed to load data from API: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      log('Error in API call: $e');
    }
    return null; // Return null if there was an error
  }

  // Fetching framework equipment data from API
  // framework_equipment_basic=http://localhost:3000/api/v1/frameworks/getFrameworkEquipments

  Future<List<dynamic>?> fetchFrameworkEquipmentBasic() async {
    final url = Uri.parse(
        '$_baseUrl/frameworks/getFrameworkEquipments'); // Updated endpoint for fetching framework equipment

    try {
      final response = await http.get(url, headers: _getHeaders());
      if (response.statusCode == 200) {
        return jsonDecode(response
            .body); // Return the list of framework equipment if successful
      } else {
        log('Failed to load data from API: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      log('Error in API call: $e');
    }
    return null; // Return null if there was an error
  }
}
