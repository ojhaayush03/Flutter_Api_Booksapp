import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'service_model.dart';
import 'services_repository.dart';

final servicesProvider = StateNotifierProvider<ServicesNotifier, AsyncValue<List<ServiceModel>>>((ref) {
  return ServicesNotifier();
});

class ServicesNotifier extends StateNotifier<AsyncValue<List<ServiceModel>>> {
  ServicesNotifier() : super(const AsyncValue.loading()) {
    loadServices();
  }

  final _repository = ServicesRepository();

  Future<void> loadServices() async {
    try {
      state = const AsyncValue.loading();
      final services = await _repository.fetchServices();
      state = AsyncValue.data(services);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }
}