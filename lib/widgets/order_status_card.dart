import 'package:api_tester/models/service_order_model.dart';
import 'package:flutter/material.dart';

class OrderStatusCard extends StatelessWidget {
  const OrderStatusCard({super.key, required this.order});

  final ServiceOrderModel order;

  Color get _statusColor =>
      order.progress == 1 ? const Color(0xFF2F8A69) : const Color(0xFFD9671E);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE8E3DE)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: _statusColor.withValues(alpha: .14),
                  borderRadius: BorderRadius.circular(13),
                ),
                child: Icon(Icons.laptop_mac_rounded, color: _statusColor),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      order.laptopName,
                      style: const TextStyle(fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      order.serviceName,
                      style: const TextStyle(
                        color: Color(0xFF756E69),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                order.id,
                style: const TextStyle(color: Color(0xFF756E69), fontSize: 11),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: order.progress,
                    minHeight: 7,
                    color: _statusColor,
                    backgroundColor: const Color(0xFFF0ECE8),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Text(
                order.status,
                style: TextStyle(color: _statusColor, fontSize: 12),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
