import 'dart:convert';
import 'dart:io';

import 'package:api_tester/models/request_log.dart';
import 'package:api_tester/widgets/api_tester_header.dart';
import 'package:api_tester/widgets/request_form_card.dart';
import 'package:api_tester/widgets/request_history_card.dart';
import 'package:flutter/material.dart';

class ApiTesterScreen extends StatefulWidget {
  const ApiTesterScreen({super.key});

  @override
  State<ApiTesterScreen> createState() => _ApiTesterScreenState();
}

class _ApiTesterScreenState extends State<ApiTesterScreen> {
  final _urlController = TextEditingController(text: 'http://10.0.2.2:3000');
  final _bodyController = TextEditingController(text: '{\n  "nama": "Hamim"\n}');
  final _tokenController = TextEditingController();
  final _endpoints = const <String, String>{
    '/get': 'GET',
    '/post': 'POST',
    '/post-with-header': 'POST',
    '/put': 'PUT',
    '/patch': 'PATCH',
    '/delete': 'DELETE',
  };
  late final List<RequestLog> _history = List.generate(
    30,
    (index) {
      final endpoint = _endpoints.keys.elementAt(index % _endpoints.length);
      return RequestLog(
        method: _endpoints[endpoint]!,
        endpoint: endpoint,
        statusCode: index % 9 == 0 ? 401 : 200,
        timeLabel: 'Contoh request ${index + 1}',
      );
    },
  );

  String _method = 'GET';
  String _endpoint = '/get';
  String _response = 'Tekan Kirim Request untuk melihat respons server.';
  int? _statusCode;
  bool _isLoading = false;

  @override
  void dispose() {
    _urlController.dispose();
    _bodyController.dispose();
    _tokenController.dispose();
    super.dispose();
  }

  Future<void> _sendRequest() async {
    final baseUrl = _urlController.text.trim().replaceFirst(RegExp(r'/+$'), '');
    if (baseUrl.isEmpty) return _showNotice('URL server wajib diisi.');

    String? requestBody;
    if (_method != 'GET' && _bodyController.text.trim().isNotEmpty) {
      try {
        requestBody = jsonEncode(jsonDecode(_bodyController.text));
      } on FormatException {
        return _showNotice('Request body harus berupa JSON yang valid.');
      }
    }

    setState(() {
      _isLoading = true;
      _statusCode = null;
      _response = 'Menghubungkan ke server...';
    });

    final client = HttpClient()..connectionTimeout = const Duration(seconds: 10);
    try {
      final request = await client.openUrl(_method, Uri.parse('$baseUrl$_endpoint'));
      request.headers.contentType = ContentType.json;
      request.headers.set(HttpHeaders.acceptHeader, 'application/json');
      if (_endpoint == '/post-with-header' && _tokenController.text.trim().isNotEmpty) {
        request.headers.set(HttpHeaders.authorizationHeader, _tokenController.text.trim());
      }
      if (requestBody != null) request.write(requestBody);

      final result = await request.close();
      final responseText = await utf8.decoder.bind(result).join();
      if (!mounted) return;
      setState(() {
        _statusCode = result.statusCode;
        _response = _prettyJson(responseText);
        _history.insert(
          0,
          RequestLog(method: _method, endpoint: _endpoint, statusCode: result.statusCode, timeLabel: 'Baru saja'),
        );
      });
    } on SocketException {
      if (mounted) setState(() => _response = 'Server tidak dapat dijangkau. Jalankan Express di port 3000.');
    } on FormatException {
      if (mounted) setState(() => _response = 'URL server tidak valid.');
    } catch (error) {
      if (mounted) setState(() => _response = 'Terjadi kesalahan: $error');
    } finally {
      client.close(force: true);
      if (mounted) setState(() => _isLoading = false);
    }
  }

  String _prettyJson(String value) {
    try {
      return const JsonEncoder.withIndent('  ').convert(jsonDecode(value));
    } on FormatException {
      return value.isEmpty ? '(Respons kosong)' : value;
    }
  }

  void _showNotice(String message) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));

  @override
  Widget build(BuildContext context) => Scaffold(
        body: SafeArea(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 720),
              child: Column(
                children: [
                  const ApiTesterHeader(),
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
                      itemCount: _history.length + 3,
                      itemBuilder: (context, index) {
                        if (index == 0) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: RequestFormCard(
                              urlController: _urlController,
                              bodyController: _bodyController,
                              tokenController: _tokenController,
                              method: _method,
                              endpoint: _endpoint,
                              endpoints: _endpoints,
                              isLoading: _isLoading,
                              onMethodChanged: (value) => setState(() => _method = value),
                              onEndpointChanged: (value) => setState(() {
                                _endpoint = value;
                                _method = _endpoints[value]!;
                              }),
                              onSend: _sendRequest,
                            ),
                          );
                        }
                        if (index == 1) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 24),
                            child: ResponseCard(response: _response, statusCode: _statusCode),
                          );
                        }
                        if (index == 2) {
                          return const Padding(
                            padding: EdgeInsets.only(bottom: 12),
                            child: Text('Riwayat request', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
                          );
                        }
                        return RequestHistoryCard(log: _history[index - 3]);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}
