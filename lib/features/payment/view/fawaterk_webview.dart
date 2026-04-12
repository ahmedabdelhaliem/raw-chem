import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:raw_chem/common/resources/color_manager.dart';
import 'package:raw_chem/common/resources/strings_manager.dart';
import 'package:raw_chem/common/widgets/default_app_bar.dart';
import 'package:webview_flutter/webview_flutter.dart';

class FawaterkWebView extends StatefulWidget {
  final String url;
  final String? successUrl;
  final String? failureUrl;

  const FawaterkWebView({
    super.key,
    required this.url,
    this.successUrl,
    this.failureUrl,
  });

  @override
  State<FawaterkWebView> createState() => _FawaterkWebViewState();
}

class _FawaterkWebViewState extends State<FawaterkWebView> {
  late final WebViewController _controller;
  int _progress = 0;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            if (mounted) {
              setState(() {
                _progress = progress;
              });
            }
          },
          onPageStarted: (String url) {
            if (mounted) {
              setState(() {
                _isLoading = true;
              });
            }
          },
          onPageFinished: (String url) {
            if (mounted) {
              setState(() {
                _isLoading = false;
              });
            }
            _handleUrlChange(url);
          },
          onWebResourceError: (WebResourceError error) {
            debugPrint('WebView Error: ${error.description}');
          },
          onNavigationRequest: (NavigationRequest request) {
            return _handleUrlChange(request.url);
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }

  NavigationDecision _handleUrlChange(String url) {
    debugPrint('Navigating to: $url');
    
    final successPattern = widget.successUrl ?? 'success';
    final failurePattern = widget.failureUrl ?? 'fail';

    if (url.contains(successPattern)) {
      context.pop(true); // Return true for success
      return NavigationDecision.prevent;
    } else if (url.contains(failurePattern) || url.contains('cancel')) {
      context.pop(false); // Return false for failure
      return NavigationDecision.prevent;
    }
    
    return NavigationDecision.navigate;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      appBar: DefaultAppBar(
        text: AppStrings.paymentSecure.tr(),
        backgroundColor: ColorManager.white,
        titleColor: ColorManager.black,
        withLeading: true,
      ),
      body: Stack(
        children: [
          WebViewWidget(controller: _controller),
          if (_isLoading || _progress < 100)
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: LinearProgressIndicator(
                value: _progress / 100,
                backgroundColor: Colors.transparent,
                color: ColorManager.primary,
                minHeight: 3.h,
              ),
            ),
          if (_isLoading && _progress < 10)
            const Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }
}
