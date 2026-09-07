import 'package:flutter/material.dart';

class FixMateHeader extends StatelessWidget {
  const FixMateHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 46,
          height: 46,
          decoration: BoxDecoration(
            color: const Color(0xFFD9671E),
            borderRadius: BorderRadius.circular(15),
          ),
          child: const Icon(Icons.build_rounded, color: Colors.white),
        ),
        const SizedBox(width: 12),
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Halo, Timothy!',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
              ),
              SizedBox(height: 3),
              Text(
                'Laptop sehat, kerja jadi hebat.',
                style: TextStyle(color: Color(0xFF756E69), fontSize: 12),
              ),
            ],
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: const Badge(
            smallSize: 8,
            child: Icon(Icons.notifications_none_rounded),
          ),
        ),
      ],
    );
  }
}
