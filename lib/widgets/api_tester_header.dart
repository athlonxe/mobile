import 'package:flutter/material.dart';

class ApiTesterHeader extends StatelessWidget {
  const ApiTesterHeader({super.key});

  @override
  Widget build(BuildContext context) => SizedBox(
    height: 184,
    child: Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          height: 144,
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(24, 24, 24, 44),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF1D4ED8), Color(0xFF60A5FA)],
            ),
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(28)),
          ),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'REST API Tester',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.w800,
                ),
              ),
              SizedBox(height: 5),
              Text(
                'Uji endpoint Express dari perangkatmu',
                style: TextStyle(color: Color(0xFFDDEAFE), fontSize: 14),
              ),
            ],
          ),
        ),
        const Positioned(
          left: 24,
          right: 24,
          top: 104,
          child: _ConnectionHint(),
        ),
      ],
    ),
  );
}

class _ConnectionHint extends StatelessWidget {
  const _ConnectionHint();

  @override
  Widget build(BuildContext context) => Material(
    color: Colors.white,
    elevation: 4,
    shadowColor: const Color(0x330F172A),
    borderRadius: BorderRadius.circular(16),
    child: Padding(
      padding: const EdgeInsets.all(14),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFFDBEAFE),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.phonelink_setup, color: Color(0xFF2563EB)),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Text(
              'Emulator Android: gunakan 10.0.2.2\nPerangkat fisik: gunakan IP komputer.',
              style: TextStyle(fontSize: 12.5, height: 1.35),
            ),
          ),
        ],
      ),
    ),
  );
}
