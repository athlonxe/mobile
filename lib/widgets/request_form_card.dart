import 'package:flutter/material.dart';

class RequestFormCard extends StatelessWidget {
  const RequestFormCard({
    required this.urlController,
    required this.bodyController,
    required this.tokenController,
    required this.method,
    required this.endpoint,
    required this.endpoints,
    required this.isLoading,
    required this.onMethodChanged,
    required this.onEndpointChanged,
    required this.onSend,
    super.key,
  });

  final TextEditingController urlController;
  final TextEditingController bodyController;
  final TextEditingController tokenController;
  final String method;
  final String endpoint;
  final Map<String, String> endpoints;
  final bool isLoading;
  final ValueChanged<String> onMethodChanged;
  final ValueChanged<String> onEndpointChanged;
  final VoidCallback onSend;

  @override
  Widget build(BuildContext context) => _CardShell(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Buat request',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 16),
        TextField(
          controller: urlController,
          keyboardType: TextInputType.url,
          decoration: const InputDecoration(
            labelText: 'URL server',
            prefixIcon: Icon(Icons.link),
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 14),
        Row(
          children: [
            Expanded(
              child: DropdownButtonFormField<String>(
                initialValue: method,
                decoration: const InputDecoration(
                  labelText: 'Method',
                  border: OutlineInputBorder(),
                ),
                items: const ['GET', 'POST', 'PUT', 'PATCH', 'DELETE']
                    .map(
                      (value) =>
                          DropdownMenuItem(value: value, child: Text(value)),
                    )
                    .toList(),
                onChanged: (value) => onMethodChanged(value!),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              flex: 2,
              child: DropdownButtonFormField<String>(
                initialValue: endpoint,
                decoration: const InputDecoration(
                  labelText: 'Endpoint',
                  border: OutlineInputBorder(),
                ),
                items: endpoints.keys
                    .map(
                      (value) =>
                          DropdownMenuItem(value: value, child: Text(value)),
                    )
                    .toList(),
                onChanged: (value) => onEndpointChanged(value!),
              ),
            ),
          ],
        ),
        if (endpoint == '/post-with-header') ...[
          const SizedBox(height: 14),
          TextField(
            controller: tokenController,
            decoration: const InputDecoration(
              labelText: 'Authorization token',
              hintText: 'Bearer token-anda',
              prefixIcon: Icon(Icons.key),
              border: OutlineInputBorder(),
            ),
          ),
        ],
        const SizedBox(height: 14),
        TextField(
          controller: bodyController,
          minLines: 4,
          maxLines: 6,
          enabled: method != 'GET',
          decoration: InputDecoration(
            labelText: 'Request body (JSON)',
            helperText: method == 'GET'
                ? 'GET tidak membutuhkan body.'
                : 'Contoh: {"nama": "Hamim"}',
            alignLabelWithHint: true,
            border: const OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          width: double.infinity,
          child: FilledButton.icon(
            onPressed: isLoading ? null : onSend,
            icon: isLoading
                ? const SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(Icons.send_rounded),
            label: Text(isLoading ? 'Mengirim...' : 'Kirim Request'),
          ),
        ),
      ],
    ),
  );
}

class ResponseCard extends StatelessWidget {
  const ResponseCard({
    required this.response,
    required this.statusCode,
    super.key,
  });
  final String response;
  final int? statusCode;

  @override
  Widget build(BuildContext context) {
    final success = statusCode != null && statusCode! < 400;
    return _CardShell(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text(
                'Response',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
              ),
              const SizedBox(width: 8),
              if (statusCode != null)
                Chip(
                  label: Text('HTTP $statusCode'),
                  backgroundColor: success
                      ? const Color(0xFFDCFCE7)
                      : const Color(0xFFFEE2E2),
                  side: BorderSide.none,
                ),
            ],
          ),
          const SizedBox(height: 10),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: const Color(0xFF0F172A),
              borderRadius: BorderRadius.circular(12),
            ),
            child: SelectableText(
              response,
              style: const TextStyle(
                color: Color(0xFFE2E8F0),
                fontFamily: 'monospace',
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CardShell extends StatelessWidget {
  const _CardShell({required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(18),
      boxShadow: const [
        BoxShadow(
          color: Color(0x120F172A),
          blurRadius: 14,
          offset: Offset(0, 5),
        ),
      ],
    ),
    child: child,
  );
}
