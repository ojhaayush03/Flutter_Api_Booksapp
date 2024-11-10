// services_repository.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'service_model.dart';

// Repository class responsible for handling API requests related to services
class ServicesRepository {

  // Asynchronously fetches a list of services from the remote API
  Future<List<ServiceModel>> fetchServices() async {
    try {
      // Make a POST request to the API endpoint to retrieve services data
      final response = await http.post(
        Uri.parse('https://api.thenotary.app/customer/login'),
        body: json.encode({'email': 'nandhakumar1411@gmail'}), // Request payload
        headers: {'Content-Type': 'application/json'}, // Header indicating JSON format
      );

      // Check if the request was successful (status code 200 indicates success)
      if (response.statusCode == 200) {
        // Decode the JSON response body into a Map
        final Map<String, dynamic> responseData = json.decode(response.body);

        // Verify that the 'data' and 'masterServices' fields are present in the response
        if (responseData['data'] == null || responseData['data']['masterServices'] == null) {
          print('No data or masterServices in response');
          return []; // Return an empty list if required data is missing
        }

        // Extract the 'masterServices' field, which is expected to be a map
        final masterServices = responseData['data']['masterServices'] as Map<String, dynamic>;
        List<ServiceModel> allServices = [];

        // Iterate over each service category (e.g., LSA_OFFLINE, LSA_ONLINE) in masterServices
        masterServices.forEach((category, servicesList) {
          // Check if the category contains a list of services
          if (servicesList is List) {
            // Convert each service entry in the list to a ServiceModel and add to allServices
            allServices.addAll(servicesList.map((service) => ServiceModel.fromJson(service)).toList());
          }
        });

        print('Total services found: ${allServices.length}');
        return allServices; // Return the populated list of services
      } else {
        // Handle cases where the request was unsuccessful by throwing an exception
        throw Exception('Failed to load services: ${response.statusCode}');
      }
    } catch (e, stackTrace) {
      // Print error details and stack trace to help with debugging
      print('Error fetching services: $e');
      print('Stack trace: $stackTrace');
      // Re-throw the exception to indicate failure in service fetching
      throw Exception('Error fetching services: $e');
    }
  }
}
