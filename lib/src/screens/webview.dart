import 'dart:async';
import 'dart:convert';

import 'dart:typed_data';

import 'package:flutter/material.dart';

import 'package:webview_flutter/webview_flutter.dart';
// #docregion platform_imports
// Import for Android features.
import 'package:webview_flutter_android/webview_flutter_android.dart';
// Import for iOS features.
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';
// #enddocregion platform_imports

import 'package:url_launcher/url_launcher.dart';

const String kNavigationExamplePage = '''
<!DOCTYPE html><html>
<head><title>Navigation Delegate Example</title></head>
<body>
<p>
The navigation delegate is set to block navigation to the youtube website.
</p>
<ul>
<ul><a href="https://www.youtube.com/">https://www.youtube.com/</a></ul>
<ul><a href="https://www.google.com/">https://www.google.com/</a></ul>
</ul>
</body>
</html>
''';

const String kLocalExamplePage = '''
<p style="text-align: center; "><span style="font-family: Arial;"><b>This is Show Google Drive</b></span></p><p style="text-align: center; "><iframe frameborder="0" src="https://www.youtube.com/embed/X3D8aDy3D3I" width="800" height="600" class="note-video-clip"></iframe><span style="font-family: Arial; font-size: 12px;"><br></span></p><p style="text-align: center; "><span style="font-family: Arial; font-size: 12px;"><br></span></p><p style="text-align: center; "><span style="font-family: Arial; font-size: 12px;"><br></span><br><p>Transparent background test</p><br><p>Transparent background test</p><br><p>Transparent background test</p></p>
''';

const String kLocalPage = '''
<p style="text-align: center; "><span style="font-family: Arial; font-size: 12px;"></span><span style="font-family: Arial; font-size: 12px;"></span><a href="https://www.youtube.com/watch?v=X3D8aDy3D3I&amp;ab_channel=FourirAkbar" target="_blank"><span style="font-family: Arial;">This is LInk</span></a></p><p style="text-align: center; "><iframe frameborder="0" src="https://drive.google.com/file/d/1MpismW7KHK8CkKwk3Q26tyP5PKGsxXah/preview" width="800" height="600" class="note-video-clip"></iframe><a href="https://www.youtube.com/watch?v=X3D8aDy3D3I&amp;ab_channel=FourirAkbar" target="_blank"><span style="font-family: Arial;"><br></span></a></p><p style="text-align: center; "></p><div id="Content" style="margin: 0px; padding: 0px; position: relative; font-family: &quot;Open Sans&quot;, Arial, sans-serif; text-align: center;"><div class="boxed" style="margin: 10px 28.7969px; padding: 0px; clear: both;"><div id="lipsum" style="margin: 0px; padding: 0px; text-align: justify;"><p style="margin-right: 0px; margin-bottom: 20px; margin-left: 0px; padding: 0px; border: 0px; font-variant-numeric: inherit; font-variant-east-asian: inherit; font-variant-alternates: inherit; font-variant-position: inherit; font-stretch: inherit; font-size: 1.8em; line-height: 1.5; font-family: &quot;Source Sans Pro&quot;, sans-serif; font-optical-sizing: inherit; font-kerning: inherit; font-feature-settings: inherit; font-variation-settings: inherit; vertical-align: baseline; letter-spacing: -0.003em; color: rgba(0, 0, 0, 0.8);"><span style="font-family: Arial; font-size: 12px;">Lorem ipsum dolor sit amet consectetur adipiscing elit nam, suspendisse eu facilisis nunc et posuere parturient, nisi lacinia placerat morbi dictumst enim libero. Interdum nisl est nec inceptos placerat habitasse et, fames ut aptent cursus porta per, praesent pulvinar ante egestas nisi cubilia. Pretium odio enim dis convallis volutpat vehicula, arcu laoreet consequat sollicitudin himenaeos, tristique massa per cubilia sapien. Duis vulputate egestas curabitur mauris maecenas himenaeos at purus metus mattis, parturient magna ante tristique primis erat malesuada dictumst imperdiet donec, fermentum justo hendrerit ultrices fames litora convallis eros habitant.</span></p><div><br></div><div><br></div></div></div></div>
''';

const String kTransparentBackgroundPage = '''
  <!DOCTYPE html>
  <html>
  <head>
    <title>Transparent background test</title>
  </head>
  <style type="text/css">
    body { background: transparent; margin: 0; padding: 0; }
    #container { position: relative; margin: 0; padding: 0; width: 100vw; height: 100vh; }
    #shape { background: red; width: 200px; height: 200px; margin: 0; padding: 0; position: absolute; top: calc(50% - 100px); left: calc(50% - 100px); }
    p { text-align: center; }
  </style>
  <body>
    <div id="container">
      <p>Transparent background test</p>
      <div id="shape"></div>
    </div>
  </body>
  </html>
''';

const String kLogExamplePage = '''
<!DOCTYPE html>
<html lang="en">
<head>
<title>Load file or HTML string example</title>
</head>
<body onload="console.log('Logging that the page is loading.')">

<h1>Local demo page</h1>
<p>
  This page is used to test the forwarding of console logs to Dart.
</p>

<style>
    .btn-group button {
      padding: 24px; 24px;
      display: block;
      width: 25%;
      margin: 5px 0px 0px 0px;
    }
</style>

<div class="btn-group">
    <button onclick="console.error('This is an error message.')">Error</button>
    <button onclick="console.warn('This is a warning message.')">Warning</button>
    <button onclick="console.info('This is a info message.')">Info</button>
    <button onclick="console.debug('This is a debug message.')">Debug</button>
    <button onclick="console.log('This is a log message.')">Log</button>
</div>

</body>
</html>
''';

class WebViewExample extends StatefulWidget {
  const WebViewExample({super.key});

  @override
  State<WebViewExample> createState() => _WebViewExampleState();
}

class _WebViewExampleState extends State<WebViewExample> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();

    // #docregion platform_features
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
    // #enddocregion platform_features

    controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            debugPrint('WebView is loading (progress : $progress%)');
          },
          onPageStarted: (String url) {
            debugPrint('Page started loading: $url');
          },
          onPageFinished: (String url) {
            debugPrint('Page finished loading: $url');
          },
          onWebResourceError: (WebResourceError error) {
            debugPrint('''
              Page resource error:
              code: ${error.errorCode}
              description: ${error.description}
              errorType: ${error.errorType}
              isForMainFrame: ${error.isForMainFrame}
          ''');
          },
          // onNavigationRequest: (NavigationRequest request) {
          //   if (request.url.startsWith('https://www.youtube.com/')) {
          //     debugPrint('blocking navigation to ${request.url}');
          //     return NavigationDecision.prevent;
          //   }
          //   debugPrint('allowing navigation to ${request.url}');
          //   return NavigationDecision.navigate;
          // },
          // onUrlChange: (UrlChange change) {
          //   debugPrint('url change to ${change.url}');
          // },
          // onHttpAuthRequest: (HttpAuthRequest request) {
          //   openDialog(request);
          // },
        ),
      )
      ..addJavaScriptChannel(
        'Toaster',
        onMessageReceived: (JavaScriptMessage message) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message.message)),
          );
        },
      )
      ..loadHtmlString(kLocalPage);
    // ..loadRequest(Uri.parse(
    //     'https://www.wmata.com/schedules/maps/upload/2019-System-Map.pdf'));

    // #docregion platform_features
    if (controller.platform is AndroidWebViewController) {
      AndroidWebViewController.enableDebugging(true);
      (controller.platform as AndroidWebViewController)
          .setMediaPlaybackRequiresUserGesture(false);
    }
    // #enddocregion platform_features

    _controller = controller;
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 0.12;
    final Uri urlD = Uri.parse(
        'https://www.wmata.com/schedules/maps/upload/2019-System-Map.pdf');

    Future<void> launchUrlD() async {
      if (!await launchUrl(urlD)) {
        throw Exception('Could not launch $urlD');
      }
    }

    return Scaffold(
      //backgroundColor: Colors.green,
      // appBar: AppBar(
      //   title: const Text('Infobyte'),
      //   // This drop down menu demonstrates that Flutter widgets can be shown over the web view.
      //   actions: <Widget>[
      //     NavigationControls(webViewController: _controller),
      //     //SampleMenu(webViewController: _controller),
      //   ],
      // ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: height,
              child: const Column(
                children: [
                  Text("Ini adalah Title"),
                  Text("Ini adalah Date"),
                ],
              ),
            ),
            Flexible(
              child: WebViewWidget(controller: _controller),
            ),
            Center(
              child: ElevatedButton(
                onPressed: launchUrlD,
                child: const Text('Show Flutter homepage'),
              ),
            ),
            NavigationControls(webViewController: _controller),
            // Container(
            //   decoration:
            //       BoxDecoration(border: Border.all(color: Colors.blueAccent)),
            //   child:
            // ),
          ],
        ),
      ),
      //floatingActionButton: favoriteButton(),
    );
  }

  // Widget favoriteButton() {
  //   return FloatingActionButton(
  //     onPressed: () async {
  //       final String? url = await _controller.currentUrl();
  //       if (mounted) {
  //         ScaffoldMessenger.of(context).showSnackBar(
  //           SnackBar(content: Text('Favorited $url')),
  //         );
  //       }
  //     },
  //     child: const Icon(Icons.favorite),
  //   );
  // }

  // Future<void> openDialog(HttpAuthRequest httpRequest) async {
  //   final TextEditingController usernameTextController =
  //       TextEditingController();
  //   final TextEditingController passwordTextController =
  //       TextEditingController();

  //   return showDialog(
  //     context: context,
  //     barrierDismissible: false,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: Text('${httpRequest.host}: ${httpRequest.realm ?? '-'}'),
  //         content: SingleChildScrollView(
  //           child: Column(
  //             mainAxisSize: MainAxisSize.min,
  //             children: <Widget>[
  //               TextField(
  //                 decoration: const InputDecoration(labelText: 'Username'),
  //                 autofocus: true,
  //                 controller: usernameTextController,
  //               ),
  //               TextField(
  //                 decoration: const InputDecoration(labelText: 'Password'),
  //                 controller: passwordTextController,
  //               ),
  //             ],
  //           ),
  //         ),
  //         actions: <Widget>[
  //           // Explicitly cancel the request on iOS as the OS does not emit new
  //           // requests when a previous request is pending.
  //           TextButton(
  //             onPressed: () {
  //               httpRequest.onCancel();
  //               Navigator.of(context).pop();
  //             },
  //             child: const Text('Cancel'),
  //           ),
  //           TextButton(
  //             onPressed: () {
  //               httpRequest.onProceed(
  //                 WebViewCredential(
  //                   user: usernameTextController.text,
  //                   password: passwordTextController.text,
  //                 ),
  //               );
  //               Navigator.of(context).pop();
  //             },
  //             child: const Text('Authenticate'),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }
}

enum MenuOptions {
  showUserAgent,
  listCookies,
  clearCookies,
  addToCache,
  listCache,
  clearCache,
  navigationDelegate,
  doPostRequest,

  loadFlutterAsset,
  loadHtmlString,
  transparentBackground,
  setCookie,
  logExample,
  basicAuthentication,
}

class SampleMenu extends StatelessWidget {
  SampleMenu({
    super.key,
    required this.webViewController,
  });

  final WebViewController webViewController;
  late final WebViewCookieManager cookieManager = WebViewCookieManager();

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<MenuOptions>(
      key: const ValueKey<String>('ShowPopupMenu'),
      onSelected: (MenuOptions value) {
        switch (value) {
          case MenuOptions.showUserAgent:
            _onShowUserAgent();
          case MenuOptions.listCookies:
            _onListCookies(context);
          case MenuOptions.clearCookies:
            _onClearCookies(context);
          case MenuOptions.addToCache:
            _onAddToCache(context);
          case MenuOptions.listCache:
            _onListCache();
          case MenuOptions.clearCache:
            _onClearCache(context);
          case MenuOptions.navigationDelegate:
            _onNavigationDelegateExample();
          case MenuOptions.doPostRequest:
            _onDoPostRequest();

          case MenuOptions.loadFlutterAsset:
            _onLoadFlutterAssetExample();
          case MenuOptions.loadHtmlString:
            _onLoadHtmlStringExample();
          case MenuOptions.transparentBackground:
            _onTransparentBackground();
          case MenuOptions.setCookie:
            _onSetCookie();
          case MenuOptions.logExample:
            _onLogExample();
          case MenuOptions.basicAuthentication:
            _promptForUrl(context);
        }
      },
      itemBuilder: (BuildContext context) => <PopupMenuItem<MenuOptions>>[
        const PopupMenuItem<MenuOptions>(
          value: MenuOptions.showUserAgent,
          child: Text('Show user agent'),
        ),
        const PopupMenuItem<MenuOptions>(
          value: MenuOptions.listCookies,
          child: Text('List cookies'),
        ),
        const PopupMenuItem<MenuOptions>(
          value: MenuOptions.clearCookies,
          child: Text('Clear cookies'),
        ),
        const PopupMenuItem<MenuOptions>(
          value: MenuOptions.addToCache,
          child: Text('Add to cache'),
        ),
        const PopupMenuItem<MenuOptions>(
          value: MenuOptions.listCache,
          child: Text('List cache'),
        ),
        const PopupMenuItem<MenuOptions>(
          value: MenuOptions.clearCache,
          child: Text('Clear cache'),
        ),
        const PopupMenuItem<MenuOptions>(
          value: MenuOptions.navigationDelegate,
          child: Text('Navigation Delegate example'),
        ),
        const PopupMenuItem<MenuOptions>(
          value: MenuOptions.doPostRequest,
          child: Text('Post Request'),
        ),
        const PopupMenuItem<MenuOptions>(
          value: MenuOptions.loadHtmlString,
          child: Text('Load HTML string'),
        ),
        const PopupMenuItem<MenuOptions>(
          value: MenuOptions.loadFlutterAsset,
          child: Text('Load Flutter Asset'),
        ),
        const PopupMenuItem<MenuOptions>(
          key: ValueKey<String>('ShowTransparentBackgroundExample'),
          value: MenuOptions.transparentBackground,
          child: Text('Transparent background example'),
        ),
        const PopupMenuItem<MenuOptions>(
          value: MenuOptions.setCookie,
          child: Text('Set cookie'),
        ),
        const PopupMenuItem<MenuOptions>(
          value: MenuOptions.logExample,
          child: Text('Log example'),
        ),
        const PopupMenuItem<MenuOptions>(
          value: MenuOptions.basicAuthentication,
          child: Text('Basic Authentication Example'),
        ),
      ],
    );
  }

  Future<void> _onShowUserAgent() {
    // Send a message with the user agent string to the Toaster JavaScript channel we registered
    // with the WebView.
    return webViewController.runJavaScript(
      'Toaster.postMessage("User Agent: " + navigator.userAgent);',
    );
  }

  Future<void> _onListCookies(BuildContext context) async {
    final String cookies = await webViewController
        .runJavaScriptReturningResult('document.cookie') as String;
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Text('Cookies:'),
            _getCookieList(cookies),
          ],
        ),
      ));
    }
  }

  Future<void> _onAddToCache(BuildContext context) async {
    await webViewController.runJavaScript(
      'caches.open("test_caches_entry"); localStorage["test_localStorage"] = "dummy_entry";',
    );
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Added a test entry to cache.'),
      ));
    }
  }

  Future<void> _onListCache() {
    return webViewController.runJavaScript('caches.keys()'
        // ignore: missing_whitespace_between_adjacent_strings
        '.then((cacheKeys) => JSON.stringify({"cacheKeys" : cacheKeys, "localStorage" : localStorage}))'
        '.then((caches) => Toaster.postMessage(caches))');
  }

  Future<void> _onClearCache(BuildContext context) async {
    await webViewController.clearCache();
    await webViewController.clearLocalStorage();
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Cache cleared.'),
      ));
    }
  }

  Future<void> _onClearCookies(BuildContext context) async {
    final bool hadCookies = await cookieManager.clearCookies();
    String message = 'There were cookies. Now, they are gone!';
    if (!hadCookies) {
      message = 'There are no cookies.';
    }
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(message),
      ));
    }
  }

  Future<void> _onNavigationDelegateExample() {
    final String contentBase64 = base64Encode(
      const Utf8Encoder().convert(kNavigationExamplePage),
    );
    return webViewController.loadRequest(
      Uri.parse('data:text/html;base64,$contentBase64'),
    );
  }

  Future<void> _onSetCookie() async {
    await cookieManager.setCookie(
      const WebViewCookie(
        name: 'foo',
        value: 'bar',
        domain: 'httpbin.org',
        path: '/anything',
      ),
    );
    await webViewController.loadRequest(Uri.parse(
      'https://httpbin.org/anything',
    ));
  }

  Future<void> _onDoPostRequest() {
    return webViewController.loadRequest(
      Uri.parse('https://httpbin.org/post'),
      method: LoadRequestMethod.post,
      headers: <String, String>{'foo': 'bar', 'Content-Type': 'text/plain'},
      body: Uint8List.fromList('Test Body'.codeUnits),
    );
  }

  Future<void> _onLoadFlutterAssetExample() {
    return webViewController.loadFlutterAsset('assets/www/index.html');
  }

  Future<void> _onLoadHtmlStringExample() {
    return webViewController.loadHtmlString(kLocalExamplePage);
  }

  Future<void> _onTransparentBackground() {
    return webViewController.loadHtmlString(kTransparentBackgroundPage);
  }

  Widget _getCookieList(String cookies) {
    if (cookies == '""') {
      return Container();
    }
    final List<String> cookieList = cookies.split(';');
    final Iterable<Text> cookieWidgets =
        cookieList.map((String cookie) => Text(cookie));
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: cookieWidgets.toList(),
    );
  }

  Future<void> _onLogExample() {
    webViewController
        .setOnConsoleMessage((JavaScriptConsoleMessage consoleMessage) {
      debugPrint(
          '== JS == ${consoleMessage.level.name}: ${consoleMessage.message}');
    });

    return webViewController.loadHtmlString(kLogExamplePage);
  }

  Future<void> _promptForUrl(BuildContext context) {
    final TextEditingController urlTextController = TextEditingController();

    return showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Input URL to visit'),
          content: TextField(
            decoration: const InputDecoration(labelText: 'URL'),
            autofocus: true,
            controller: urlTextController,
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                if (urlTextController.text.isNotEmpty) {
                  final Uri? uri = Uri.tryParse(urlTextController.text);
                  if (uri != null && uri.scheme.isNotEmpty) {
                    webViewController.loadRequest(uri);
                    Navigator.pop(context);
                  }
                }
              },
              child: const Text('Visit'),
            ),
          ],
        );
      },
    );
  }
}

class NavigationControls extends StatelessWidget {
  const NavigationControls({super.key, required this.webViewController});

  final WebViewController webViewController;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () async {
            if (await webViewController.canGoBack()) {
              await webViewController.goBack();
            } else {
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('No back history item')),
                );
              }
            }
          },
        ),
        IconButton(
          icon: const Icon(Icons.arrow_forward_ios),
          onPressed: () async {
            if (await webViewController.canGoForward()) {
              await webViewController.goForward();
            } else {
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('No forward history item')),
                );
              }
            }
          },
        ),
        IconButton(
          icon: const Icon(Icons.replay),
          onPressed: () => webViewController.reload(),
        ),
      ],
    );
  }
}
