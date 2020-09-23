//Add the url_laucher package in your pubspec.yaml
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Url Launcher',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: UrlLauncher(),
    );
  }
}

class UrlLauncher extends StatefulWidget {
  @override
  _UrlLauncherState createState() => _UrlLauncherState();
}

Future<void> _launched;

//To open phonebook
Future<void> _callUsers(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

//To open Messaging app
Future<void> _smsUsers(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

//To open email/gmail
Future<void> _mailUsers(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

//To open installed app in the device
Future<void> _launchUniversalLinkIos(String url) async {
  if (await canLaunch(url)) {
    final bool nativeAppLaunchSucceeded = await launch(
      url,
      forceSafariVC: false,
      universalLinksOnly: true,
    );
    if (!nativeAppLaunchSucceeded) {
      await launch(
        url,
        forceSafariVC: true,
      );
    }
  }
}

//To open link in browser
Future<void> _launchInBrowser(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

//To open link in webView
Future<void> _launchInWebView(String url) async {
  if (await canLaunch(url)) {
    await launch(
      url,
      forceSafariVC: true,
      forceWebView: true,
      headers: <String, String>{'my_header_key': 'my_header_value'},
    );
  } else {
    throw 'Could not launch $url';
  }
}

class _UrlLauncherState extends State<UrlLauncher> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.count(
        crossAxisCount: 2,
        children: <Widget>[
          LauncherButton(
            color: Color(0xffF3D180),
            icon: Icons.phone,
            text: 'Phone',
            onPress: () => setState(() {
              _launched = _callUsers('tel:95521515');
            }),
          ),
          LauncherButton(
            color: Color(0xffFCBF49),
            icon: Icons.sms,
            text: 'SMS',
            onPress: () => setState(() {
              _launched = _smsUsers('sms:5550101234');
            }),
          ),
          LauncherButton(
            color: Color(0xffF77F00),
            icon: Icons.mail,
            text: 'Email',
            onPress: () => setState(() {
              _launched = _mailUsers(
                  'mailto:smith@example.org?subject=UrlPackage&body=It%20is%20awesome');
            }),
          ),
          LauncherButton(
            color: Color(0xffD62828),
            icon: Icons.play_arrow,
            text: 'Youtube',
            onPress: () => setState(() {
              _launched = _launchUniversalLinkIos('https://www.youtube.com/');
            }),
          ),
          LauncherButton(
            color: Color(0xff2E933C),
            icon: Icons.public,
            text: 'Brower',
            onPress: () => setState(() {
              _launched = _launchInBrowser('https://www.google.com/');
            }),
          ),
          LauncherButton(
            color: Color(0xff1B4965),
            icon: Icons.http,
            text: 'WebView',
            onPress: () => setState(() {
              _launched = _launchInWebView('https://www.google.com/');
            }),
          ),
        ],
      ),
    );
  }
}

class LauncherButton extends StatelessWidget {
  final Color color;
  final IconData icon;
  final Function onPress;
  final String text;

  const LauncherButton({this.color, this.icon, this.onPress, this.text});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(
              25.0,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                icon,
                size: 60,
                color: Colors.white,
              ),
              Text(
                text,
                style: TextStyle(
                  height: 2,
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}