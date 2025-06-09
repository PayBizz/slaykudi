import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:webview_flutter/webview_flutter.dart';


void main() {
  runApp(SlayKudiApp());
}

class SlayKudiApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Slay Kudi',
      debugShowCheckedModeBanner: false,
      home: AnimatedSplashScreen(
                splash: SplashText(), // 🔥 Custom widget with animation

        backgroundColor: Colors.white,
        duration: 3000,
        splashTransition: SplashTransition.fadeTransition,
        nextScreen: WebViewScreen(),
      ),
    );
  }
}
class SplashText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: FittedBox( // ✅ Auto-scales the text layout if space is tight
          child: DefaultTextStyle(
            style: const TextStyle(
              fontSize: 38.0,
              fontWeight: FontWeight.bold,
              color: Colors.deepPurple,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Hi'),
                SizedBox(height: 10),
                AnimatedTextKit(
                  animatedTexts: [
                    TypewriterAnimatedText(
                      'Beauties',
                      speed: Duration(milliseconds: 150),
                    ),
                  ],
                  isRepeatingAnimation: false,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


class WebViewScreen extends StatefulWidget {
  @override
  _WebViewScreenState createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  late final WebViewController _controller;
  String currentUrl = 'https://www.slaykudi.com/mobile-index.php';

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(currentUrl));
  }

  void _loadPage(String url) {
    setState(() {
      currentUrl = url;
    });
    _controller.loadRequest(Uri.parse(url));
    Navigator.pop(context); // close drawer
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Slay Kudi"),
        backgroundColor: Colors.deepPurple,
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.deepPurple),
              child: Text(
                'Slay Kudi Menu',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () => _loadPage('https://www.slaykudi.com/mobile-index.php'),
            ),
            ListTile(
              leading: Icon(Icons.admin_panel_settings),
              title: Text('Admin'),
              onTap: () => _loadPage('https://www.slaykudi.com/mobile-admin.php'),
            ),
            ListTile(
              leading: Icon(Icons.people),
              title: Text('Staff'),
              onTap: () => _loadPage('https://www.slaykudi.com/mobile-staff.php'),
            ),
            ListTile(
              leading: Icon(Icons.design_services),
              title: Text('Services'),
              onTap: () => _loadPage('https://www.slaykudi.com/mobile-services.php'),
            ),
            ListTile(
              leading: Icon(Icons.info),
              title: Text('About Us'),
              onTap: () => _loadPage('https://www.slaykudi.com/mobile-contact.php'),
            ),
          ],
        ),
      ),
      body: WebViewWidget(controller: _controller),
    );
  }
}
