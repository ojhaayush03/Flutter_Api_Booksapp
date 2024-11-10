// services_provider.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'service_model.dart';
import 'services_repository.dart';

// Define a provider for the list of services, which uses the ServicesNotifier to manage state
final servicesProvider = StateNotifierProvider<ServicesNotifier, AsyncValue<List<ServiceModel>>>((ref) {
  return ServicesNotifier(); // Initializes the notifier
});

// ServicesNotifier is a state notifier that manages the state of the list of services
class ServicesNotifier extends StateNotifier<AsyncValue<List<ServiceModel>>> {
  
  // Initialize the state as loading initially, and start loading services
  ServicesNotifier() : super(const AsyncValue.loading()) {
    loadServices(); // Automatically load services upon instantiation
  }

  // An instance of ServicesRepository to handle API requests
  final _repository = ServicesRepository();

  // Asynchronously loads services from the repository and updates the state accordingly
  Future<void> loadServices() async {
    try {
      // Set the state to loading before starting the API request
      state = const AsyncValue.loading();
      
      // Fetch services data from the repository
      final services = await _repository.fetchServices();
      
      // Update the state with the fetched data on successful retrieval
      state = AsyncValue.data(services);
    } catch (error, stackTrace) {
      // If an error occurs, set the state to error and provide error details and stack trace
      state = AsyncValue.error(error, stackTrace);
    }
  }
}
