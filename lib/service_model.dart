// service_model.dart
class ServiceModel {
  final String name;
  final String description;
  final double cost;
  final String serviceId;
  final int timeToBlockinMins;
  final int timeBlockBeforeAfter;
  final bool manualPricingFlag;
  final String? paymentLink;

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

  factory ServiceModel.fromJson(Map<String, dynamic> json) {
    try {
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
      print('Error parsing service JSON: $e');
      rethrow;
    }
  }

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
