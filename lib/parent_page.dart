import 'package:app/loading_page.dart';
import 'package:app/scripts/js.dart';
import 'package:app/scripts/user_data.dart';
import 'package:flutter/material.dart';
import 'package:app/login_page.dart';
import 'package:app/home_page.dart';
import 'dart:convert';
import 'package:webview_flutter/webview_flutter.dart';
// #docregion platform_imports
// Import for Android features.
import 'package:webview_flutter_android/webview_flutter_android.dart';
// Import for iOS features.
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

class ParentPage extends StatefulWidget {
  const ParentPage({Key? key}) : super(key: key);
  @override
  State<ParentPage> createState() => _ParentPageState();
}
enum PageState {
  login,
  loading,
  home,
  start
}
class _ParentPageState extends State<ParentPage> {
  PageState _state = PageState.start;
  late final WebViewController _controller;
  late final WebViewCookieManager _cookieManager;
  late final String _username;
  late final List<UserData> _users;

  void changeState (PageState state) {
    setState(() {
      _state = state;
    });
  }
  @override
  void initState() {
    super.initState();
    late final PlatformWebViewControllerCreationParams params;
    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      params = WebKitWebViewControllerCreationParams(
        allowsInlineMediaPlayback: true,
        mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
      );
    } else {
      params = const PlatformWebViewControllerCreationParams();
    }
    final WebViewController controller = 
      WebViewController.fromPlatformCreationParams(params);
    controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {

          },
          onPageFinished: (String url) {
            if (url == "https://www.instagram.com/accounts/login/") {
              debugPrint("login");
            } else if (url == "https://www.instagram.com/") {
              debugPrint("website");
              setState(() {
                _state = PageState.loading;
              });
              getStartingData();
            } else if (url.contains("/onetap/")) {
              debugPrint("onetap");
              setState(() {
                _state = PageState.loading;
              });
              controller.loadRequest(Uri.parse("https://www.instagram.com/"));
            } else {
              debugPrint(url);
              setState(() {
                _state = PageState.loading;
              });
              controller.loadRequest(Uri.parse("https://www.instagram.com/"));
            }
          }
        )
      )
      ..addJavaScriptChannel(
        "Toaster",
        onMessageReceived: (JavaScriptMessage message) {
          if (message.message[0] == "[") {
            try {
              List<dynamic> jsonList = jsonDecode(message.message);
              List<UserData> users = jsonList.map((e) => UserData.fromJson(e)).toList();
              _users = users;
            } catch (e) {
              debugPrint("Error: $e");
            }
            setState(() {
              _state = PageState.home;
            });
          } else {
            debugPrint("Error: ${message.message}");
          }
        }
      )
      ..loadRequest(Uri.parse('https://instagram.com/accounts/login'));
      if (controller.platform is AndroidWebViewController) {
        AndroidWebViewController.enableDebugging(true);
        (controller.platform as AndroidWebViewController)
        .setMediaPlaybackRequiresUserGesture(false);
      }
      _controller = controller;
      _cookieManager = WebViewCookieManager();
      _cookieManager.clearCookies();
  }
  Future<void> getStartingData() async {
    final String username = await JavaScript.getMyUsername(_controller);
    _username = username;
    debugPrint("Username: $username");
    // get other data here
    await _controller.runJavaScript(JavaScript.createGetFollowersScript(username));
  }
  @override
  Widget build(BuildContext context) {
    if (_state == PageState.start) {
      return LoginPage(changeState);
    } else if (_state == PageState.login) {
      return WebViewWidget(
        controller: _controller
      );
    } else if (_state == PageState.loading) {
      return const LoadingPage();
    } else {
      return HomePage(changeState, _users, _username);
    }
  }
}