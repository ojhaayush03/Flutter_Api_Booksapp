// services_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'services_provider.dart';
import 'service_card.dart';

class ServicesScreen extends ConsumerStatefulWidget {
  const ServicesScreen({Key? key}) : super(key: key);

  @override
  _ServicesScreenState createState() => _ServicesScreenState();
}

class _ServicesScreenState extends ConsumerState<ServicesScreen> {
  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final servicesAsync = ref.watch(servicesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Available Services'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search services...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: Colors.grey[100],
              ),
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
            ),
          ),
          Expanded(
            child: servicesAsync.when(
              data: (services) {
                if (services.isEmpty) {
                  return const Center(
                    child: Text('No services available'),
                  );
                }

                final filteredServices = services.where((service) {
                  return service.name.toLowerCase().contains(searchQuery.toLowerCase());
                }).toList();

                return GridView.builder(
                  padding: const EdgeInsets.all(16),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.75,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                  itemCount: filteredServices.length,
                  itemBuilder: (context, index) {
                    final service = filteredServices[index];
                    return ServiceCard(service: service);
                  },
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stack) => Center(
                child: Text('Error: $error'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}