import 'package:api_tester/models/service_model.dart';
import 'package:flutter/material.dart';

class ServiceCard extends StatelessWidget {
  const ServiceCard({super.key, required this.service});

  final ServiceModel service;

  IconData get _icon {
    switch (service.iconName) {
      case 'cleaning':
        return Icons.cleaning_services_rounded;
      case 'memory':
        return Icons.memory_rounded;
      case 'settings':
        return Icons.settings_suggest_rounded;
      default:
        return Icons.manage_search_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 154,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE8E3DE)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(9),
            decoration: BoxDecoration(
              color: const Color(0xFFFFE9D8),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(_icon, color: const Color(0xFFD9671E)),
          ),
          const Spacer(),
          Text(
            service.name,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 5),
          Text(
            'Mulai Rp${service.price ~/ 1000}k',
            style: const TextStyle(color: Color(0xFFD9671E), fontSize: 12),
          ),
        ],
      ),
    );
  }
}
