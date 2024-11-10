// services_repository.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'service_model.dart';

class ServicesRepository {
  Future<List<ServiceModel>> fetchServices() async {
  try {
    final response = await http.post(
      Uri.parse('https://api.thenotary.app/customer/login'),
      body: json.encode({'email': 'nandhakumar1411@gmail'}),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);

      if (responseData['data'] == null || responseData['data']['masterServices'] == null) {
        print('No data or masterServices in response');
        return [];
      }

      final masterServices = responseData['data']['masterServices'] as Map<String, dynamic>;
      List<ServiceModel> allServices = [];

      // Iterate over each service category (LSA_OFFLINE, LSA_ONLINE, etc.)
      masterServices.forEach((category, servicesList) {
        if (servicesList is List) {
          allServices.addAll(servicesList.map((service) => ServiceModel.fromJson(service)).toList());
        }
      });

      print('Total services found: ${allServices.length}');
      return allServices;
    } else {
      throw Exception('Failed to load services: ${response.statusCode}');
    }
  } catch (e, stackTrace) {
    print('Error fetching services: $e');
    print('Stack trace: $stackTrace');
    throw Exception('Error fetching services: $e');
  }
}

}