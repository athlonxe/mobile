import 'package:api_tester/models/service_model.dart';
import 'package:flutter/material.dart';

class ServiceCard extends StatelessWidget {
  const ServiceCard({super.key, required this.service, required this.onTap});

  final ServiceModel service;
  final VoidCallback onTap;

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
    return Card(
      margin: EdgeInsets.zero,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: const BorderSide(color: Color(0xFFE8E3DE)),
      ),
      clipBehavior: Clip.antiAlias,
      child: ListTile(
        onTap: onTap,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 9),
        leading: Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: const Color(0xFFFFE9D8),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Icon(_icon, color: const Color(0xFFD9671E)),
        ),
        title: Text(
          service.name,
          style: const TextStyle(fontWeight: FontWeight.w700),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 5),
          child: Text(
            'Mulai ${formatRupiah(service.price)} • ${service.duration}',
            style: const TextStyle(color: Color(0xFF756E69), fontSize: 12),
          ),
        ),
        trailing: const Icon(
          Icons.chevron_right_rounded,
          color: Color(0xFFD9671E),
        ),
      ),
    );
  }
}

String formatRupiah(int value) {
  final digits = value.toString();
  final buffer = StringBuffer();
  for (var index = 0; index < digits.length; index++) {
    if (index > 0 && (digits.length - index) % 3 == 0) {
      buffer.write('.');
    }
    buffer.write(digits[index]);
  }
  return 'Rp$buffer';
}
