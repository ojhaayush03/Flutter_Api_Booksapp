// service_model.dart

// Defines a model class for a service, encapsulating details like name, description, cost, etc.
class ServiceModel {
  final String name;
  final String description;
  final double cost;
  final String serviceId;
  final int timeToBlockinMins;
  final int timeBlockBeforeAfter;
  final bool manualPricingFlag;
  final String? paymentLink;

  // Constructor for initializing a ServiceModel instance
  ServiceModel({
    required this.name,
    required this.description,
    required this.cost,
    required this.serviceId,
    required this.timeToBlockinMins,
    required this.timeBlockBeforeAfter,
    required this.manualPricingFlag,
    this.paymentLink,
  });

  // Factory method to create a ServiceModel instance from a JSON map
  factory ServiceModel.fromJson(Map<String, dynamic> json) {
    try {
      // Parse and assign JSON values to properties, with fallbacks for null values or conversions
      return ServiceModel(
        name: json['serviceName'] ?? '',
        description: json['description'] ?? '',
        cost: (json['cost'] ?? 0).toDouble(),
        serviceId: json['serviceId'] ?? '',
        timeToBlockinMins: int.tryParse(json['timeToBlockinMins'].toString()) ?? 0,
        timeBlockBeforeAfter: int.tryParse(json['timeBlockBeforeAfter'].toString()) ?? 0,
        manualPricingFlag: json['manualPricingFlag'] ?? false,
        paymentLink: json['paymentLink'],
      );
    } catch (e) {
      // Logs any parsing errors and rethrows the exception for further handling
      print('Error parsing service JSON: $e');
      rethrow;
    }
  }

  // Provides a user-friendly label for certain service IDs
  String get formattedServiceId {
    switch (serviceId) {
      case 'LSA_ONLINE':
        return 'Real Estate Notarization';
      case 'LSA_OFFLINE':
        return 'Real Estate Offline Notarization';
      default:
        return serviceId;
    }
  }
}
