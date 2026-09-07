import 'package:api_tester/models/laptop_model.dart';
import 'package:api_tester/models/service_model.dart';
import 'package:api_tester/models/service_order_model.dart';

const List<ServiceModel> services = [
  ServiceModel(
    id: 'srv-01',
    name: 'Diagnosa Cepat',
    description: 'Cek masalah laptop secara menyeluruh.',
    price: 50000,
    duration: '30–45 mnt',
    iconName: 'search',
  ),
  ServiceModel(
    id: 'srv-02',
    name: 'Cleaning & Repaste',
    description: 'Bersihkan kipas dan ganti thermal paste.',
    price: 120000,
    duration: '1–2 jam',
    iconName: 'cleaning',
  ),
  ServiceModel(
    id: 'srv-03',
    name: 'Upgrade SSD',
    description: 'Buat laptop lebih responsif dan cepat.',
    price: 150000,
    duration: '1 jam',
    iconName: 'memory',
  ),
  ServiceModel(
    id: 'srv-04',
    name: 'Install Ulang',
    description: 'Instal OS dan aplikasi esensial.',
    price: 100000,
    duration: '2–3 jam',
    iconName: 'settings',
  ),
];

const List<LaptopModel> devices = [
  LaptopModel(
    id: 'lpt-01',
    brand: 'ASUS',
    model: 'VivoBook 14',
    problem: 'Mudah panas saat dipakai desain.',
    status: 'Dalam pengerjaan',
    estimatedCost: 120000,
  ),
  LaptopModel(
    id: 'lpt-02',
    brand: 'Lenovo',
    model: 'IdeaPad Slim 3',
    problem: 'Booting lambat dan ruang penyimpanan penuh.',
    status: 'Siap dijemput',
    estimatedCost: 150000,
  ),
];

const List<ServiceOrderModel> orders = [
  ServiceOrderModel(
    id: 'FM-2408',
    laptopName: 'ASUS VivoBook 14',
    serviceName: 'Cleaning & Repaste',
    status: 'Sedang dikerjakan',
    progress: .65,
    updatedAt: 'Diperbarui 20 mnt lalu',
  ),
  ServiceOrderModel(
    id: 'FM-2405',
    laptopName: 'Lenovo IdeaPad Slim 3',
    serviceName: 'Upgrade SSD',
    status: 'Siap dijemput',
    progress: 1,
    updatedAt: 'Diperbarui kemarin',
  ),
  ServiceOrderModel(
    id: 'FM-2397',
    laptopName: 'Acer Aspire 5',
    serviceName: 'Install Ulang',
    status: 'Selesai',
    progress: 1,
    updatedAt: 'Selesai 4 Sep',
  ),
];
