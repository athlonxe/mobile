import 'package:api_tester/models/service_model.dart';
import 'package:api_tester/widgets/service_card.dart';
import 'package:flutter/material.dart';

class ServiceDetailScreen extends StatefulWidget {
  const ServiceDetailScreen({super.key, required this.service});

  final ServiceModel service;

  @override
  State<ServiceDetailScreen> createState() => _ServiceDetailScreenState();
}

class _ServiceDetailScreenState extends State<ServiceDetailScreen> {
  bool _isBooked = false;

  IconData get _serviceIcon {
    switch (widget.service.iconName) {
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

  void _toggleBooking() {
    setState(() => _isBooked = !_isBooked);
  }

  @override
  Widget build(BuildContext context) {
    final service = widget.service;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Detail Layanan',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(24, 24, 24, 32),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 560),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  height: 156,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFE9D8),
                    borderRadius: BorderRadius.circular(28),
                  ),
                  child: Icon(
                    _serviceIcon,
                    size: 82,
                    color: const Color(0xFFD9671E),
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  service.name,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineSmall
                      ?.copyWith(fontWeight: FontWeight.w800),
                ),
                const SizedBox(height: 8),
                Text(
                  '${formatRupiah(service.price)} • ${service.duration}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Color(0xFFD9671E),
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 24),
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEAF4EE),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Tentang layanan',
                        style: TextStyle(fontWeight: FontWeight.w800),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        service.description,
                        style: const TextStyle(
                          color: Color(0xFF4F6256),
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                ElevatedButton.icon(
                  key: const Key('booking-button'),
                  onPressed: _toggleBooking,
                  icon: Icon(
                    _isBooked
                        ? Icons.event_available_rounded
                        : Icons.calendar_month_rounded,
                  ),
                  label: Text(
                    _isBooked ? 'Layanan Dibooking' : 'Booking Layanan',
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _isBooked
                        ? const Color(0xFF2E7D5B)
                        : const Color(0xFFD9671E),
                    foregroundColor: Colors.white,
                    minimumSize: const Size.fromHeight(52),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    textStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
