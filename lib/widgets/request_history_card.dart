import 'package:api_tester/models/request_log.dart';
import 'package:flutter/material.dart';

class RequestHistoryCard extends StatelessWidget {
  const RequestHistoryCard({required this.log, super.key});
  final RequestLog log;

  @override
  Widget build(BuildContext context) {
    final statusColor = log.isSuccess
        ? const Color(0xFF15803D)
        : const Color(0xFFB91C1C);
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
            decoration: BoxDecoration(
              color: const Color(0xFFDBEAFE),
              borderRadius: BorderRadius.circular(7),
            ),
            child: Text(
              log.method,
              style: const TextStyle(
                color: Color(0xFF1D4ED8),
                fontWeight: FontWeight.w800,
                fontSize: 11,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  log.endpoint,
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 2),
                Text(
                  log.timeLabel,
                  style: const TextStyle(
                    color: Color(0xFF64748B),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Text(
            '${log.statusCode}',
            style: TextStyle(color: statusColor, fontWeight: FontWeight.w800),
          ),
        ],
      ),
    );
  }
}
