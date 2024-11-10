// services_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'services_provider.dart';
import 'service_card.dart';

// The main screen widget displaying the list of services with search functionality
class ServicesScreen extends ConsumerStatefulWidget {
  const ServicesScreen({Key? key}) : super(key: key);

  @override
  _ServicesScreenState createState() => _ServicesScreenState();
}

class _ServicesScreenState extends ConsumerState<ServicesScreen> {
  String searchQuery = ''; // Holds the current search query for filtering services

  @override
  Widget build(BuildContext context) {
    // Watches the servicesProvider, which provides asynchronous service data
    final servicesAsync = ref.watch(servicesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Available Services'), // AppBar title
      ),
      body: Column(
        children: [
          // Search bar for filtering services by name
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search services...', // Placeholder text for search field
                prefixIcon: const Icon(Icons.search), // Search icon
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12), // Rounded border
                ),
                filled: true,
                fillColor: Colors.grey[100], // Light background color for search bar
              ),
              onChanged: (value) {
                // Update search query and refresh the UI when search text changes
                setState(() {
                  searchQuery = value;
                });
              },
            ),
          ),
          // Expanded widget to allow the list to take up remaining space
          Expanded(
            // Handle different states (loading, data, error) of the services provider
            child: servicesAsync.when(
              data: (services) {
                // If no services are available, show a message
                if (services.isEmpty) {
                  return const Center(
                    child: Text('No services available'),
                  );
                }

                // Filter services based on the search query
                final filteredServices = services.where((service) {
                  return service.name.toLowerCase().contains(searchQuery.toLowerCase());
                }).toList();

                // Display filtered services in a grid layout
                return GridView.builder(
                  padding: const EdgeInsets.all(16), // Padding around the grid
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // Number of columns
                    childAspectRatio: 0.75, // Aspect ratio for grid items
                    crossAxisSpacing: 16, // Space between columns
                    mainAxisSpacing: 16, // Space between rows
                  ),
                  itemCount: filteredServices.length,
                  itemBuilder: (context, index) {
                    final service = filteredServices[index];
                    // Creates a card for each filtered service
                    return ServiceCard(service: service);
                  },
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()), // Show loading indicator
              error: (error, stack) => Center(
                child: Text('Error: $error'), // Show error message if loading fails
              ),
            ),
          ),
        ],
      ),
    );
  }
}
