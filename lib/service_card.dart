// service_card.dart

import 'package:flutter/material.dart';
import 'service_model.dart';

// A stateless widget that displays details of a ServiceModel instance in a card format
class ServiceCard extends StatelessWidget {
  final ServiceModel service; // The service data to display

  // Constructor for ServiceCard widget, requiring a ServiceModel instance
  const ServiceCard({
    Key? key,
    required this.service,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4, // Provides shadow effect for the card
      child: Padding(
        padding: const EdgeInsets.all(16.0), // Inner padding within the card
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Displays the name of the service
            Text(
              service.name,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              maxLines: 2, // Limits text to two lines
              overflow: TextOverflow.ellipsis, // Adds ellipsis if the text overflows
            ),
            const SizedBox(height: 8), // Space between elements

            // Displays the cost of the service, formatted to two decimal places
            Text(
              '\$${service.cost.toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 16,
                color: Colors.green,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),

            // Displays the formatted service ID with custom labels for specific IDs
            Text(
              service.formattedServiceId,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
