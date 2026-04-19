import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:raw_chem/common/resources/color_manager.dart';
import 'package:raw_chem/common/resources/strings_manager.dart';
import 'package:raw_chem/common/widgets/default_app_bar.dart';
import 'package:raw_chem/common/widgets/default_error_widget.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:async';

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
  bool _isError = false;
  String? _errorMessage;
  Timer? _timeoutTimer;
  bool _isDisposed = false;

  @override
  void dispose() {
    _isDisposed = true;
    _timeoutTimer?.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _startTimeout();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            if (_isDisposed) return;
            setState(() {
              _progress = progress;
            });
          },
          onPageStarted: (String url) {
            if (_isDisposed) return;
            setState(() {
              _isLoading = true;
            });
          },
          onPageFinished: (String url) {
            if (_isDisposed) return;
            _timeoutTimer?.cancel();
            setState(() {
              _isLoading = false;
              _isError = false;
            });
            _handleUrlChange(url);
          },
          onWebResourceError: (WebResourceError error) {
            if (_isDisposed) return;
            setState(() {
              _isError = true;
              _errorMessage = error.description;
              _isLoading = false;
            });
          },
          onNavigationRequest: (NavigationRequest request) {
            return _handleUrlChange(request.url);
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }

  void _startTimeout() {
    _timeoutTimer?.cancel();
    _timeoutTimer = Timer(const Duration(seconds: 45), () {
      if (_isLoading && !_isDisposed) {
        setState(() {
          _isError = true;
          _errorMessage = AppStrings.connectionTimeout.tr();
          _isLoading = false;
        });
      }
    });
  }

  NavigationDecision _handleUrlChange(String url) {
    if (_isDisposed) return NavigationDecision.prevent;
    debugPrint('Checking URL logic: $url');
    
    final uri = Uri.parse(url);
    final successPattern = widget.successUrl ?? 'success';
    final failurePattern = widget.failureUrl ?? 'fail';

    // Precise detection using path segments or query parameters
    bool isSuccess = uri.toString().contains(successPattern) || 
                     uri.queryParameters['status'] == 'success' || 
                     uri.path.contains('success');
    
    bool isFailure = uri.toString().contains(failurePattern) || 
                     uri.queryParameters['status']?.contains('fail') == true || 
                     uri.queryParameters['status'] == 'canceled' ||
                     uri.path.contains('fail') || 
                     uri.path.contains('cancel');

    if (isSuccess) {
      context.pop(true);
      return NavigationDecision.prevent;
    } else if (isFailure) {
      context.pop(false);
      return NavigationDecision.prevent;
    }
    
    return NavigationDecision.navigate;
  }

  Future<bool> _onWillPop() async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(AppStrings.cancelPayment.tr()),
        content: Text(AppStrings.cancelPaymentConfirm.tr()),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: Text(AppStrings.no.tr())),
          TextButton(onPressed: () => Navigator.pop(context, true), child: Text(AppStrings.yes.tr(), style: const TextStyle(color: Colors.red))),
        ],
      ),
    );
    return result ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;
        final shouldPop = await _onWillPop();
        if (shouldPop && mounted) {
          context.pop(false);
        }
      },
      child: Scaffold(
        backgroundColor: ColorManager.white,
        appBar: DefaultAppBar(
          text: AppStrings.paymentSecure.tr(),
          backgroundColor: ColorManager.white,
          titleColor: ColorManager.black,
          withLeading: true,
        ),
        body: Stack(
          children: [
            if (!_isError) WebViewWidget(controller: _controller),
            if (_isError)
              DefaultErrorWidget(
                errorMessage: _errorMessage ?? AppStrings.unknownError.tr(),
                buttonTitle: AppStrings.retry.tr(),
                onPressed: () {
                  setState(() {
                    _isError = false;
                    _isLoading = true;
                    _progress = 0;
                  });
                  _startTimeout();
                  _controller.reload();
                },
              ),
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
            if (_isLoading && _progress < 10 && !_isError)
              const Center(
                child: CircularProgressIndicator(),
              ),
          ],
        ),
      ),
    );
  }
}
