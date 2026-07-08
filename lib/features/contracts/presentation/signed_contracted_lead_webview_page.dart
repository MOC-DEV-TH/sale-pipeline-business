import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../utils/app_colors.dart';

class SignedContractedLeadWebViewPage extends StatefulWidget {
  const SignedContractedLeadWebViewPage({
    super.key,
    required this.url,
  });

  final String url;

  @override
  State<SignedContractedLeadWebViewPage> createState() =>
      _SignedContractedLeadWebViewPageState();
}

class _SignedContractedLeadWebViewPageState
    extends State<SignedContractedLeadWebViewPage> {
  late final WebViewController _controller;

  bool _isLoading = true;
  bool _alreadyPopped = false;

  static const String successPath = '/webapp/save_sign';

  @override
  void initState() {
    super.initState();

    final fullUrl = _buildFullUrl(widget.url);

    debugPrint('Loading signed URL: $fullUrl');

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (url) {
            debugPrint('Page started loading: $url');

            if (mounted) {
              setState(() => _isLoading = true);
            }
          },
          onPageFinished: (url) {
            debugPrint('Page finished loading: $url');

            if (mounted) {
              setState(() => _isLoading = false);
            }

            _handleSuccessUrl(url);
          },
          onHttpError: (error) {
            debugPrint(
              'HTTP error: ${error.response} - ${error.request?.uri}',
            );
          },
          onWebResourceError: (error) {
            debugPrint(
              'Web resource error: ${error.errorType} - ${error.description}',
            );
          },
          onNavigationRequest: (request) {
            debugPrint('Navigation request: ${request.url}');

            if (_isSuccessUrl(request.url)) {
              _popSuccess();
              return NavigationDecision.prevent;
            }

            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(fullUrl));
  }

  String _buildFullUrl(String url) {
    final value = url.trim();

    if (value.startsWith('http://') || value.startsWith('https://')) {
      return value;
    }

    const webBaseUrl = 'https://mojoenet.com';

    if (value.startsWith('/')) {
      return '$webBaseUrl$value';
    }

    return '$webBaseUrl/$value';
  }

  bool _isSuccessUrl(String url) {
    final uri = Uri.tryParse(url);
    if (uri == null) return false;

    return uri.path.startsWith(successPath);
  }

  void _handleSuccessUrl(String url) {
    if (_isSuccessUrl(url)) {
      _popSuccess();
    }
  }

  void _popSuccess() {
    if (!mounted || _alreadyPopped) return;

    _alreadyPopped = true;
    Navigator.of(context).pop(true);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  WebViewWidget(controller: _controller),
                  if (_isLoading)
                    const Center(
                      child: CircularProgressIndicator(),
                    ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: MaterialButton(
                height: 45,
                minWidth: 150,
                onPressed: () => Navigator.of(context).pop(false),
                color: kPrimaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Save',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}