import 'package:api_tester/data/fixmate_dummy_data.dart';
import 'package:api_tester/widgets/fixmate_header.dart';
import 'package:api_tester/widgets/order_status_card.dart';
import 'package:api_tester/widgets/service_card.dart';
import 'package:flutter/material.dart';

class FixMateHomeScreen extends StatefulWidget {
  const FixMateHomeScreen({super.key});

  @override
  State<FixMateHomeScreen> createState() => _FixMateHomeScreenState();
}

class _FixMateHomeScreenState extends State<FixMateHomeScreen> {
  int _selectedNav = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        backgroundColor: Colors.white,
        indicatorColor: const Color(0xFFFFE2CC),
        selectedIndex: _selectedNav,
        onDestinationSelected: (index) => setState(() => _selectedNav = index),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home_rounded),
            label: 'Beranda',
          ),
          NavigationDestination(
            icon: Icon(Icons.laptop_outlined),
            selectedIcon: Icon(Icons.laptop_rounded),
            label: 'Perangkat',
          ),
          NavigationDestination(
            icon: Icon(Icons.receipt_long_outlined),
            selectedIcon: Icon(Icons.receipt_long_rounded),
            label: 'Pesanan',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline_rounded),
            selectedIcon: Icon(Icons.person_rounded),
            label: 'Profil',
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 26),
          children: [
            const FixMateHeader(),
            const SizedBox(height: 24),
            _buildHeroCard(),
            const SizedBox(height: 28),
            _sectionTitle('Layanan populer', 'Lihat semua'),
            const SizedBox(height: 14),
            SizedBox(
              height: 178,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: services.length,
                itemBuilder: (context, index) => Padding(
                  padding: EdgeInsets.only(
                    right: index == services.length - 1 ? 0 : 12,
                  ),
                  child: ServiceCard(service: services[index]),
                ),
              ),
            ),
            const SizedBox(height: 28),
            _sectionTitle('Status servis kamu', 'Semua pesanan'),
            const SizedBox(height: 14),
            ListView.builder(
              itemCount: orders.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) =>
                  OrderStatusCard(order: orders[index]),
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
                style: TextStyle(fontSize: 19, fontWeight: FontWeight.w800),
              ),
              SizedBox(height: 7),
              SizedBox(
                width: 200,
                child: Text(
                  'Pesan teknisi tepercaya dan pantau prosesnya dari sini.',
                  style: TextStyle(
                    color: Color(0xFFE7DED7),
                    fontSize: 12,
                    height: 1.4,
                  ),
                ),
              ),
              Spacer(),
              _BookServiceButton(),
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
            ),
            child: const Text(
              'Respons < 15 menit',
              style: TextStyle(fontSize: 10, color: Color(0xFFB64C0A)),
            ),
          ),
        ),
      ],
    );
  }
}

class _BookServiceButton extends StatelessWidget {
  const _BookServiceButton();

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: () {},
      style: FilledButton.styleFrom(
        backgroundColor: const Color(0xFFD9671E),
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 9),
        textStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.w800),
      ),
      child: const Text('Pesan Servis'),
    );
  }
}
