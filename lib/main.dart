import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

void main() => runApp(const ApiTesterApp());

class ApiTesterApp extends StatelessWidget {
  const ApiTesterApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF2563EB)),
    ),
    home: const ApiTesterPage(),
  );
}

class ApiTesterPage extends StatefulWidget {
  const ApiTesterPage({super.key});
  @override
  State<ApiTesterPage> createState() => _ApiTesterPageState();
}

class _ApiTesterPageState extends State<ApiTesterPage> {
  final _url = TextEditingController(text: 'http://10.0.2.2:3000');
  final _body = TextEditingController(text: '{\n  nama: Hamim\n}');
  final _token = TextEditingController();
  final _endpoints = const <String, String>{
    '/get': 'GET',
    '/post': 'POST',
    '/post-with-header': 'POST',
    '/put': 'PUT',
    '/patch': 'PATCH',
    '/delete': 'DELETE',
  };
  String _method = 'GET';
  String _endpoint = '/get';
  String _response = 'Tekan Kirim Request untuk melihat respons server.';
  int? _status;
  bool _loading = false;

  @override
  void dispose() {
    _url.dispose();
    _body.dispose();
    _token.dispose();
    super.dispose();
  }

  Future<void> _send() async {
    final baseUrl = _url.text.trim().replaceFirst(RegExp(r'/+$'), '');
    if (baseUrl.isEmpty) return _notice('URL server wajib diisi.');
    String? requestBody;
    if (_method != 'GET' && _body.text.trim().isNotEmpty) {
      try {
        requestBody = jsonEncode(jsonDecode(_body.text));
      } on FormatException {
        return _notice('Request body harus berupa JSON yang valid.');
      }
    }
    setState(() {
      _loading = true;
      _status = null;
      _response = 'Menghubungkan ke server...';
    });
    final client = HttpClient()
      ..connectionTimeout = const Duration(seconds: 10);
    try {
      final request = await client.openUrl(
        _method,
        Uri.parse('$baseUrl$_endpoint'),
      );
      request.headers.contentType = ContentType.json;
      request.headers.set(HttpHeaders.acceptHeader, 'application/json');
      if (_endpoint == '/post-with-header' && _token.text.trim().isNotEmpty) {
        request.headers.set(
          HttpHeaders.authorizationHeader,
          _token.text.trim(),
        );
      }
      if (requestBody != null) request.write(requestBody);
      final result = await request.close();
      final text = await utf8.decoder.bind(result).join();
      if (!mounted) return;
      setState(() {
        _status = result.statusCode;
        _response = _prettyJson(text);
      });
    } on SocketException {
      if (mounted) {
        setState(
          () => _response =
              'Server tidak dapat dijangkau. Jalankan Express di port 3000.',
        );
      }
    } on FormatException {
      if (mounted) setState(() => _response = 'URL server tidak valid.');
    } catch (error) {
      if (mounted) setState(() => _response = 'Terjadi kesalahan: $error');
    } finally {
      client.close(force: true);
      if (mounted) setState(() => _loading = false);
    }
  }

  String _prettyJson(String value) {
    try {
      return const JsonEncoder.withIndent('  ').convert(jsonDecode(value));
    } on FormatException {
      return value.isEmpty ? '(Respons kosong)' : value;
    }
  }

  void _notice(String message) =>
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(message)));

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final success = _status != null && _status! < 400;
    return Scaffold(
      appBar: AppBar(title: const Text('REST API Tester'), centerTitle: true),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 720),
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                Text(
                  'Uji endpoint Express',
                  style: theme.textTheme.headlineSmall,
                ),
                const SizedBox(height: 6),
                const Text(
                  'Android emulator: gunakan 10.0.2.2. Perangkat fisik: gunakan IP komputer.',
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _url,
                  keyboardType: TextInputType.url,
                  decoration: const InputDecoration(
                    labelText: 'URL server',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.link),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        value: _method,
                        decoration: const InputDecoration(
                          labelText: 'Method',
                          border: OutlineInputBorder(),
                        ),
                        items: const ['GET', 'POST', 'PUT', 'PATCH', 'DELETE']
                            .map(
                              (x) => DropdownMenuItem(value: x, child: Text(x)),
                            )
                            .toList(),
                        onChanged: (value) => setState(() => _method = value!),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      flex: 2,
                      child: DropdownButtonFormField<String>(
                        value: _endpoint,
                        decoration: const InputDecoration(
                          labelText: 'Endpoint',
                          border: OutlineInputBorder(),
                        ),
                        items: _endpoints.keys
                            .map(
                              (x) => DropdownMenuItem(value: x, child: Text(x)),
                            )
                            .toList(),
                        onChanged: (value) => setState(() {
                          _endpoint = value!;
                          _method = _endpoints[value]!;
                        }),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                if (_endpoint == '/post-with-header') ...[
                  TextField(
                    controller: _token,
                    decoration: const InputDecoration(
                      labelText: 'Authorization token',
                      hintText: 'Bearer token-anda',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.key),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
                TextField(
                  controller: _body,
                  minLines: 4,
                  maxLines: 7,
                  enabled: _method != 'GET',
                  decoration: InputDecoration(
                    labelText: 'Request body (JSON)',
                    helperText: _method == 'GET'
                        ? 'GET tidak membutuhkan body.'
                        : 'Contoh: {nama: Hamim}',
                    border: const OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                FilledButton.icon(
                  onPressed: _loading ? null : _send,
                  icon: _loading
                      ? const SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Icon(Icons.send),
                  label: Text(_loading ? 'Mengirim...' : 'Kirim Request'),
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Text('Response', style: theme.textTheme.titleLarge),
                    const SizedBox(width: 8),
                    if (_status != null)
                      Chip(
                        label: Text('HTTP $_status'),
                        backgroundColor: success
                            ? theme.colorScheme.primaryContainer
                            : theme.colorScheme.errorContainer,
                      ),
                  ],
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: SelectableText(
                    _response,
                    style: const TextStyle(fontFamily: 'monospace'),
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
