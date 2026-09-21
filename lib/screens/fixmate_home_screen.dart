import 'package:api_tester/data/fixmate_dummy_data.dart';
import 'package:api_tester/screens/service_detail_screen.dart';
import 'package:api_tester/widgets/fixmate_header.dart';
import 'package:api_tester/widgets/service_card.dart';
import 'package:flutter/material.dart';

class FixMateHomeScreen extends StatelessWidget {
  const FixMateHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'FixMate',
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
        centerTitle: false,
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 26),
          children: [
            const FixMateHeader(),
            const SizedBox(height: 24),
            _buildHeroCard(),
            const SizedBox(height: 28),
            _sectionTitle('Layanan populer', 'Lihat detail'),
            const SizedBox(height: 14),
            ...services
                .take(3)
                .map(
                  (service) => Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: ServiceCard(
                      service: service,
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute<void>(
                          builder: (context) =>
                              ServiceDetailScreen(service: service),
                        ),
                      ),
                    ),
                  ),
                ),
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(String title, String action) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
          ),
        ),
        Text(
          action,
          style: const TextStyle(
            color: Color(0xFFD9671E),
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildHeroCard() {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          height: 198,
          padding: const EdgeInsets.fromLTRB(20, 22, 20, 18),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF211F1D), Color(0xFF3B3632)],
            ),
            borderRadius: BorderRadius.circular(24),
          ),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Butuh servis laptop?',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 19,
                  fontWeight: FontWeight.w800,
                ),
              ),
              SizedBox(height: 7),
              SizedBox(
                width: 200,
                child: Text(
                  'Pilih salah satu layanan dan lihat detailnya.',
                  style: TextStyle(
                    color: Color(0xFFE7DED7),
                    fontSize: 12,
                    height: 1.4,
                  ),
                ),
              ),
              Spacer(),
              _CatalogHint(),
            ],
          ),
        ),
        Positioned(
          right: 2,
          top: 16,
          child: Transform.rotate(
            angle: -.15,
            child: const Icon(
              Icons.laptop_mac_rounded,
              size: 112,
              color: Color(0xFFE78A47),
            ),
          ),
        ),
        Positioned(
          right: 18,
          bottom: -12,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x1A000000),
                  blurRadius: 12,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: const Text(
              '3 layanan tersedia',
              style: TextStyle(fontSize: 10, color: Color(0xFFB64C0A)),
            ),
          ),
        ),
      ],
    );
  }
}

class _CatalogHint extends StatelessWidget {
  const _CatalogHint();

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.touch_app_rounded, size: 18, color: Colors.white),
        SizedBox(width: 7),
        Text(
          'Ketuk kartu untuk detail',
          style: TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}
